resource "github_repository_collaborator" "lg_private" {
  username   = "zabronax"
  repository = github_repository.github_repository.name
}

resource "github_repository_collaborator" "wolfgang25sfj" {
  username   = "Wolfgang25sfj"
  repository = github_repository.github_repository.name
}

resource "github_repository_collaborator" "desiree25sfj" {
  username   = "desiree25sfj"
  repository = github_repository.github_repository.name
}

resource "github_repository_collaborator" "ivankalyta2025" {
  username   = "IvanKalyta2025"
  repository = github_repository.github_repository.name
}
