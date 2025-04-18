output "cluster" {
  description = "Cluster information."
  value = {
    name               = module.k3d-cluster.cluster_name
    control_plane_port = module.k3d-cluster.k3d_api_port
    loadbalancer_port  = module.k3d-cluster.k3d_host_lb_port
  }
}
