terraform {
    backend "s3" {
        bucket = "tf-backend-state"
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
     Environment = "qa"
     Project     = "specific project"
     Application = "larger-app"
   }
 }
}