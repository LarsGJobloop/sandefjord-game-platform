output "cluster" {
  description = "Cluster information."
  value       = module.k3d_cluster.cluster
}

output "loadbalancer" {
  description = "Loadbalancer information."
  value       = module.k3d_cluster.loadbalancer
}

output "registry" {
  description = "Registry information."
  value = {
    url  = module.k3d_cluster.registry.name
    port = module.k3d_cluster.registry.port
  }
}

output "registry_address" {
  description = "Registry address."
  value       = "${module.k3d_cluster.registry.name}:${module.k3d_cluster.registry.port}"
}
