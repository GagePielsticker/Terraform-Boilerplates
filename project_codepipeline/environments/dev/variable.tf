variable "env" {
  default     = "dev"
  type        = string
  description = "Environment that is currently operating."
}

variable "github_connection_arn" {
  default     = "xxxxxxxx"
  type        = string
  description = "The github app connection to authenticate codepipeline source with."
}

variable "repositories" { #Iterated through and create new pipeline for each
  type = list(object({
    id     = string
    name   = string
    branch = string
  }))

  default = [
    {
      id     = "org/repository" #org/repo
      name   = "my-proj"        #Used in config names, shorthand, no spaces use - instead
      branch = "dev"            #branch to pull from for build
    },
    {
      id     = "org/repository"
      name   = "my-proj"
      branch = "dev"
    },
  ]
}