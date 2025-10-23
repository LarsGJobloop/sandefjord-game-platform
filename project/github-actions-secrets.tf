# GitHub Actions Environment and Secrets Management
# This file manages environments and secrets for GitHub Actions workflows

variable "project_sops_age_key" {
  description = "SOPS Age key for project infrastructure workflows"
  type        = string
  sensitive   = true
}

# Environment for project infrastructure workflows
resource "github_repository_environment" "project_infrastructure" {
  environment = "project-infrastructure"
  repository  = github_repository.github_repository.name

  # Protection rules for enhanced security
  # No branch restrictions during development - can be added later for production
}

# Project SOPS Age Key for project infrastructure workflows
resource "github_actions_environment_secret" "project_sops_age_key" {
  environment     = github_repository_environment.project_infrastructure.environment
  repository      = github_repository.github_repository.name
  secret_name     = "PROJECT_SOPS_AGE_KEY"
  plaintext_value = var.project_sops_age_key
}
