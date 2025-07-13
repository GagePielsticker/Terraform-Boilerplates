terraform {
    backend "s3" {
        bucket = "prod-pipeline-tfstate"
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
     Project     = "deployment-pipelines"
     Application = "devops"
   }
 }
}