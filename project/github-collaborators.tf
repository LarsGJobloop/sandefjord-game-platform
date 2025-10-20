resource "github_repository_collaborator" "lg_private" {
  username   = "zabronax"
  repository = github_repository.github_repository.name
}
