resource "aws_s3_bucket" "s3_artifact_bucket" {
  bucket = "${env}-artifact-bucket"
}

resource "aws_s3_bucket_public_access_block" "s3_artifact_bucket_access" {
  bucket                  = aws_s3_bucket.s3_artifact_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
