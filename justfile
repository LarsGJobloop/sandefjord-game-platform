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
  @# TODO! Fix error propagation to caller
  command -v just
  command -v k3d
  command -v terraform
  command -v kubectl
