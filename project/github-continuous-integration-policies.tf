# Branch Protection Rules for Sandefjord Game Platform
# This file configures branch protection policies to ensure code quality and security

# Main branch protection
resource "github_branch_protection" "main" {
  repository_id = github_repository.github_repository.node_id
  pattern       = "main"

  # Require pull request reviews before merging
  required_pull_request_reviews {
    required_approving_review_count = 0 # Bump this higer when we have more reviewers
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    require_last_push_approval      = true
  }

  # Require status checks to pass before merging
  required_status_checks {
    strict = true
    # We are only asserting against the aggregate CI status currently
    contexts = [
      "ci-status"
    ]
  }

  # Enforce branch protection rules
  enforce_admins = false # Allow admins to bypass (can be changed to true for stricter enforcement)

  # Prevent force pushes
  allows_force_pushes = false

  # Prevent deletion of the branch
  allows_deletions = false

  # Require branches to be up to date before merging
  require_signed_commits = false # Can be enabled if GPG signing is required

  # Require linear history
  required_linear_history = true
}

# Output for branch protection rule
output "branch_protection_rule" {
  description = "Information about the configured branch protection rule"
  value       = github_branch_protection.main
  sensitive   = false
}
