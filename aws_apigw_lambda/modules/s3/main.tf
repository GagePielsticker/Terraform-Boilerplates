resource "aws_s3_bucket" "lambda_artifact_bucket" {
  bucket_prefix = "lambda-artifacts"
  force_destroy = true
}

output "bucket_id" {
  value = aws_s3_bucket.lambda_artifact_bucket.id
}