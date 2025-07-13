terraform {
  backend "s3" {
    bucket       = "qa-pipeline-tfstate"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "qa"
      Project     = "deployment-pipelines"
      Application = "devops"
    }
  }
}