resource "github_repository" "github_repository" {
  name        = "sandefjord-game-platform"
  description = "Kodehode Sandefjord Game Platform"

  # Settings
  visibility         = "public"
  archive_on_destroy = true

  # Features
  has_issues      = false
  has_discussions = false
  has_projects    = false
  has_wiki        = false
}

output "github_repository_url" {
  description = "The URL of the GitHub repository"
  value       = github_repository.github_repository.http_clone_url
  sensitive   = false
}
