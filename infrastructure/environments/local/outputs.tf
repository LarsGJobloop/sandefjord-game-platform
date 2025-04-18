output "cluster" {
  description = "Cluster information."
  value = {
    name               = module.k3d-cluster.cluster_name
    address            = module.k3d-cluster.k3d_cluster_ip
    control_plane_port = module.k3d-cluster.k3d_api_port
    loadbalancer_port  = module.k3d-cluster.k3d_host_lb_port
  }
}

output "registry" {
  description = "Registry information."
  value = {
    address = module.k3d-cluster.registry_ip
    port    = module.k3d-cluster.registry_port
  }
}
