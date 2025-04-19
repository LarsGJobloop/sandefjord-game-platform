# Prints all actions
default:
  @just --list

# Downloads and initializes non-version controlled dependenies
init:
  terraform -chdir=infrastructure/environments/local init

# Applies the currently checkout branch to the local cluster.
apply:
  @echo "Setting up the local k3d cluster"
  @terraform -chdir=infrastructure/environments/local apply -auto-approve &> /dev/null
  @echo "Applying bootstrap manifests and Custom Resource Definitions"
  @# needs to be done twice as they include CRDs
  @if ! kubectl apply -k clusters/overlays/local &> /dev/null; then sleep 3; kubectl apply -k clusters/overlays/local &> /dev/null; fi

  @echo "Applying GitOps configurations"
  @kubectl apply -k clusters/manifests/fluxcd &> /dev/null
  @kubectl apply -f clusters/overlays/local/flux-sources.yaml &> /dev/null

  @echo "Pathching tracked branch to currently checked out branch: $(git rev-parse --abbrev-ref HEAD)"
  @# Check first if the branch has been pushed to the remote
  @if ! git ls-remote --exit-code --heads origin $(git rev-parse --abbrev-ref HEAD) &> /dev/null; then \
    echo "⚠️  Branch '$(git rev-parse --abbrev-ref HEAD)' not found on remote! Please push it first."; \
    exit 1; \
  fi
  @# Then patch the resource
  @kubectl patch gitrepository flux-system \
    --namespace flux-system \
    --type merge \
    --patch '{"spec": {"ref": {"branch": "{{`git rev-parse --abbrev-ref HEAD`}}"}}}' &> /dev/null

# Destroys the local k3d cluster and associated resources
down:
  # Tearing down local k3d cluster
  @terraform -chdir=infrastructure/environments/local destroy -auto-approve &> /dev/null

# Checks that all dependencies are installed
verify-environment:
  #!/bin/bash
  missing_tools=()
  
  command -v just >/dev/null || missing_tools+=("just (https://github.com/casey/just)")
  command -v k3d >/dev/null || missing_tools+=("k3d (https://k3d.io/)")
  command -v terraform >/dev/null || missing_tools+=("terraform (https://developer.hashicorp.com/terraform)")
  command -v kubectl >/dev/null || missing_tools+=("kubectl (https://kubernetes.io/docs/tasks/tools/#kubectl)")
  
  if [ ${#missing_tools[@]} -ne 0 ]; then
    echo "Missing required tools:"
    for tool in "${missing_tools[@]}"; do
      echo "  - $tool"
    done
    exit 1
  fi

# Loads the given applications Container Image into the local registry
update-app APP_NAME:
  #!/bin/bash
  echo "🔍 Retrieving registry endpoint from Terraform outputs"
  REGISTRY_ADDRESS=$(terraform -chdir=infrastructure/environments/local output -raw registry_address)

  APP_PATH="./workloads/applications/{{APP_NAME}}"
  IMAGE_NAMESPACE="" # Prefix with '/' if not blank
  IMAGE_TAG="${REGISTRY_ADDRESS}${IMAGE_NAMESPACE}/{{APP_NAME}}:latest"

  echo "🐳 Building Docker image: $IMAGE_TAG"
  docker build -t "${IMAGE_TAG}" "${APP_PATH}" || { echo "Build failed"; exit 1; }

  echo "📦 Pushing image to local registry"
  docker push "${IMAGE_TAG}" || { echo "Upload failed"; exit 1; }

  # We likely will have to do something about the Namespace of the deployment here
  echo "♻️ Triggering rollout restart for deployment '{{APP_NAME}}'"
  kubectl rollout restart deployment "{{APP_NAME}}" || { echo "Rollout failed"; exit 1; }

  echo "✅ Image for '${APP_PATH}' pushed to ${REGISTRY_ADDRESS} and rollout triggered"
