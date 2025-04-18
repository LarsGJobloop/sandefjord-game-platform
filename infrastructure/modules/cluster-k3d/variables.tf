variable "k3s_version" {
  description = "The K3s version to use"
  type        = string
  default     = "latest"
}

variable "k3d_cluster_name" {
  description = "List of names for the cluster"
  default     = "k3d"
  type        = string
}

variable "k3d_cluster_ip" {
  description = "The IP address the cluster will be hosted on."
  default     = "0.0.0.0"
  type        = string
}

variable "k3d_host_lb_port" {
  description = "Port the LoadBalancer will be exposed on."
  default     = 8080
  type        = number
}

variable "server_count" {
  description = "Number of control plane nodes."
  default     = 1
  type        = number
}

variable "agent_count" {
  description = "Number of agent nodes."
  default     = 1
  type        = number
}
