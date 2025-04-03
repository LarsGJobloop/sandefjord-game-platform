# Prints all actions
default:
  @just --list

# Downloads and initializes non-version controlled dependenies
init:
  terraform -chdir=infrastructure/environments/local init

# Creates the local k3d cluster and associated resources
up:
  terraform -chdir=infrastructure/environments/local apply -auto-approve
  # Apply the fluxcd the manifests, need to be done twice as they include CRDs
  if ! kubectl apply -k clusters/overlays/local; then sleep 3; kubectl apply -k clusters/overlays/local; fi

  # Setup FluxCD to dynamically use the currently checked out branch
  kubectl apply -f clusters/overlays/local/flux-sources.yaml
  kubectl patch gitrepository flux-system \
    --namespace flux-system \
    --type merge \
    --patch '{"spec": {"ref": {"branch": "{{`git rev-parse --abbrev-ref HEAD`}}"}}}'

# Destroys the local k3d cluster and associated resources
down:
  terraform -chdir=infrastructure/environments/local destroy -auto-approve
