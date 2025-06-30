terraform {
  backend "s3" {
    bucket       = "dev-pipeline-tfstate"
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
      Environment = "dev"
      Project     = "deployment-pipelines"
      Application = "devops"
    }
  }

}