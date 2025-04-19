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
2. Add Manifests inside a manifests folder for it
3. Add a cluster deployment referencing those manifests
4. Spin up the local cluster and apply the manifests

### Deploy it to the other clusters

1. Create an issue in the repo tagging the Delivery Roles
