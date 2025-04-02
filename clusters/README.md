# `/clusters`

This folder defines the GitOps entrypoints for each Kubernetes cluster managed via FluxCD. Each cluster is expected to run its own Flux controller, bootstrapped with a scoped view into this repository. The overlays in this directory ensure that each controller only reconciles resources relevant to its own environment.

The `manifests` directory contains shared base definitions for platform components, while `overlays` contains per-cluster configurations and customizations. This structure encourages reusability and clarity across multiple cluster environments, from local development to production.

Secret management is still undecided, but we will likely be using [SOPS](https://github.com/mozilla/sops) with [Age](https://github.com/FiloSottile/age), enabling safe encryption and decryption of secrets directly within the GitOps workflow.

> [!CAUTION]
> If any secrets are accidentally committed unencrypted, they must be revoked and rotated immediately. The new secrets should then be securely encrypted and committed using the standard workflow.
