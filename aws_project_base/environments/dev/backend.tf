terraform {
  backend "s3" {
    bucket       = "dev-tf-backend-state"
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
      Project     = "specific project"
      Application = "larger-app"
    }
  }

}