output "cluster" {
  description = "Cluster information."
  value = {
    name                 = var.k3d_cluster_name
    control_plane_port   = local.k3d_cluster_port
    control_plane_adress = var.k3d_cluster_ip
  }
}

output "loadbalancer" {
  description = "Loadbalancer information."
  value = {
    port = var.k3d_host_lb_port
  }
}

output "registry" {
  description = "Registry information."
  value = {
    name    = var.registry_name
    address = var.registry_ip
    port    = var.registry_port
  }
}
