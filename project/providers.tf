terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }

  # This is Hetzner's Object Storage (Ceph)
  backend "s3" {
    bucket = "kodehode-sandefjord"
    key    = "sandefjord-game-platform/project/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

variable "gh_token" {
  description = "GitHub token for the project's repository"
  type        = string
  sensitive   = true
}

provider "github" {
  token = var.gh_token
}
