output "cluster_name" {
  description = "Name of the created cluster."
  value       = var.k3d_cluster_name
}

output "k3d_cluster_ip" {
  description = "IP address of the cluster."
  value       = var.k3d_cluster_ip
}


output "k3d_host_lb_port" {
  description = "Port the LoadBalancer is exposed on."
  value       = var.k3d_host_lb_port
}

output "k3d_api_port" {
  description = "The port of the Control Plane API."
  value       = local.k3d_cluster_port
}

output "registry_ip" {
  description = "IP address of the cluster."
  value       = var.registry_ip
}

output "registry_port" {
  description = "The port of the Control Plane API."
  value       = var.registry_port
}
