terraform {
    backend "s3" {
        bucket = "tf-backend-state"
        key = "terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "tfstate-lock"
        encrypt = true
    }
}