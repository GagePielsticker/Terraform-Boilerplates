provider "aws" {
  region = "us-east-1"
}

variable "s3_bucket_name" {
  default = "tf-backend-state" ## CHANGE NAME IT MUST BE GLOBALLY UNIQUE
  type = string
}

## State S3 bucket
resource "aws_s3_bucket" "s3_state_bucket" {
  bucket = var.s3_bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "s3_state_bucket_access" {
  bucket                  = aws_s3_bucket.s3_state_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "s3_state_bucket_version" {
  bucket = aws_s3_bucket.s3_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
