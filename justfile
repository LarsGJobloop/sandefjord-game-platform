# Prints all actions
default:
  @just --list

# Downloads and initializes non-version controlled dependenies
init:
  terraform -chdir=infrastructure/environments/local init

# Applies the currently checkout branch to the local cluster
# Needs to exist on GitHub to work. TODO! Setup verifier for remote branch
apply:
  terraform -chdir=infrastructure/environments/local apply -auto-approve
  # Apply the fluxcd the manifests, need to be done twice as they include CRDs
  if ! kubectl apply -k clusters/overlays/local; then sleep 3; kubectl apply -k clusters/overlays/local; fi

  # Setup FluxCD to dynamically use the currently checked out branch
  kubectl apply -k clusters/manifests/fluxcd
  kubectl apply -f clusters/overlays/local/flux-sources.yaml
  kubectl patch gitrepository flux-system \
    --namespace flux-system \
    --type merge \
    --patch '{"spec": {"ref": {"branch": "{{`git rev-parse --abbrev-ref HEAD`}}"}}}'

# Destroys the local k3d cluster and associated resources
down:
  terraform -chdir=infrastructure/environments/local destroy -auto-approve

# Checks that all dependencies are installed
verify-environment:
  # TODO! Fix error propagation to caller
  command -v just
  command -v k3d
  command -v terraform
  command -v kubectl