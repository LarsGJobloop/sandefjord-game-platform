locals {
  k3d_cluster_lb_port = 80
  k3d_cluster_port    = 6550
  config_path         = "${path.module}/k3d-config.yaml"
  config_source_hash  = sha256(local.config_path)
  config_template = templatefile(local.config_path, {
    k3s_version     = var.k3s_version
    server_count    = var.server_count
    agent_count     = var.agent_count
    cluster_ip      = var.k3d_cluster_ip
    cluster_port    = local.k3d_cluster_port
    host_lb_port    = var.k3d_host_lb_port
    cluster_lb_port = local.k3d_cluster_lb_port
    registry_name   = var.registry_name
    registry_ip     = var.registry_ip
    registry_port   = var.registry_port
  })
}

resource "local_file" "k3d_config" {
  filename = "${path.module}/generated/k3d-config.yaml"
  content  = local.config_template
}

# Terraform’s declarative model means it doesn’t guarantee access to variable values at destroy time.
# Because of that, we can't reference var.k3d_cluster_name directly in the destroy provisioner.
#
# The workaround here wraps the value in a set and uses for_each, which forces Terraform
# to materialize it in the graph and retain it in the resource address (`each.key`) even during destroy.
#
# As far as I can tell, this is the most idiomatic pattern for this use case.
# If there's a cleaner approach, I'd love to see it.
resource "null_resource" "cluster" {
  for_each = toset([var.k3d_cluster_name])

  # Be weary of null_resources as you need to manually
  # track it's dependencies and figure out when those changes.
  # We are doing it simple here and using the input and output
  # content hashes of the configuration.
  triggers = {
    cluster_name = var.k3d_cluster_name
    source_hash  = local.config_source_hash
    config_hash  = local_file.k3d_config.content_sha256
  }

  depends_on = [local_file.k3d_config]

  # Due to how Terraform handles resource lifecycles we have to manually
  # ensure that k3d clusters are destroyed before we try creating a new one.
  # It might be better to extract this logic into it's own script, but
  # due to the low persistence requirements here we are just doing it inline.
  # For production environments, setup something more durable.
  provisioner "local-exec" {
    command = "k3d cluster delete ${each.key} || true && k3d cluster create ${each.key} --config ${local_file.k3d_config.filename}"
    when    = create
  }

  # This actually gets exectued after the resource gets created when re-applying
  # which causes the problem mentioned above. It is still needed for providing
  # a teardown functionality when executing `terraform destroy`
  provisioner "local-exec" {
    command = "k3d cluster delete ${each.key}"
    when    = destroy
  }
}
