terraform {
    backend "s3" {
        bucket = "prod-tf-backend-state"
        key = "terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
   tags = {
     Environment = "prod"
     Project     = "specific project"
     Application = "larger-app"
   }
 }
}