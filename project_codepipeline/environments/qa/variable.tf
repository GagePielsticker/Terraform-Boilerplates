variable "env" {
  default = "qa"
  type = string
  description = "Environment that is currently operating."
}

variable "github_connection_id" {
  default = "xxxxxxxx"
  type = string
  description = "The github app connection to authenticate codepipeline source with."
}

variable "repositories" { #Iterated through and create new pipeline for each
  type = list(object({
    url = string
    name = string
  }))

  default = [
    {
      url = "https://github.com/xxxx/xxxx"
      name = "my-cool-project" #Used in config names
    },
    {
      url = "https://github.com/xxxx/xxxx"
      name = "my-cool-project" #Used in config names
    },
    ]
}