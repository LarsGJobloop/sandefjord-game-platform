# Develop a New Web App

This is language agnostic, only limitation is that you have to package it as a Container and it can only talk to the outside world through the networking interfaces.

## Phases

### Local Development

1. Checkout a new branch and give it a decent name.
2. Clone it locally
3. Start a new Web Application and put it in a directory under [/workloads/applications/](/workloads/applications/)
4. Play around with the local setup however you want

### Deploy it to the local cluster

> [!NOTE]
>
> The syncing will happen against the remote repository. So ensure the branch is pushed there.

1. Add a Dockerfile definition to it
2. Add Manifests inside a manifests folder for it `/workloads/applications/<your-app-name>/manifests/`
  - `kustomization.yaml` - Aggregates all resources, acts as entrypoint
  - `deployment.yaml` - This is the actual application
  - `service.yaml` - Load balancer in front of the deployment
  - `ingress.yaml` - Exposes the application through the public gateways
3. Add a cluster deployment referencing those manifests in [/clusters/manifests/](/clusters/manifests/)
  - `kustomization.yaml` - Entrypoint
  - `source.yaml` - Contains the path that should be synced against
  - `namespace.yaml` - Optional
4. Spin up the local cluster and apply the manifests
    
    ```sh
    just init
    just apply
    ```

### Deploy it to the other clusters

1. Create an issue in the repo tagging the Delivery Roles
