variable "token" {}
variable "repo_name" {
  type        = string
  description = "Repository Name, must be valid"
}

variable "repo_org" {
  type        = string
  description = "Organization to put repo in. Can be \"user\" for user repo."
  nullable    = true
}

variable "repo_description" {
  type        = string
  description = "Repository Description"
}

variable "visibility" {
  type        = string
  description = "Can be public or private."
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  token = var.token
  owner = (var.repo_org != "user") ? var.repo_org : null #organization to put repo in
}

resource "github_repository" "github_repo" {
  name        = var.repo_name
  description = var.repo_description
  visibility  = var.visibility

  has_issues         = false
  has_discussions    = false
  has_wiki           = false
  has_downloads      = false
  archive_on_destroy = true #when running terraform destroy, archive instead of delete

  delete_branch_on_merge = true

  auto_init = true #Initial Readme Commit

  allow_squash_merge = false
  allow_rebase_merge = false
}

#Branches

resource "github_branch" "dev_branch" {
  depends_on = [github_repository.github_repo]
  repository = var.repo_name
  branch     = "develop"
}

resource "github_branch" "staging_branch" {
  depends_on = [github_repository.github_repo]
  repository = var.repo_name
  branch     = "staging"
}

## Branch Protection Rules
resource "github_branch_protection" "develop_branch_protection" {
  depends_on          = [github_branch.dev_branch]
  pattern             = "develop"
  repository_id       = var.repo_name
  allows_deletions    = false
  allows_force_pushes = true
}

resource "github_branch_protection" "staging_branch_protection" {
  depends_on          = [github_branch.staging_branch]
  pattern             = "staging"
  repository_id       = var.repo_name
  allows_deletions    = false
  allows_force_pushes = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1 #required approvals
    #require_last_push_approval = true #Makes it so someone else must approve the PR
  }
}

resource "github_branch_protection" "main_branch_protection" {
  depends_on          = [github_repository.github_repo]
  pattern             = "main"
  repository_id       = var.repo_name
  allows_deletions    = false
  allows_force_pushes = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1 #required approvals
    #require_last_push_approval = true #Makes it so someone else must approve the PR
  }
}