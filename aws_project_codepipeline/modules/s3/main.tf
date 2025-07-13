variable "env" {}
variable "repositories" {}

resource "aws_s3_bucket" "s3_artifact_bucket" {
  for_each = { for inst in var.repositories : inst.name => inst }
  bucket   = "${var.env}-${each.value.name}-artifacts"
}

resource "aws_s3_bucket_public_access_block" "s3_artifact_bucket_access" {
  for_each                = { for inst in var.repositories : inst.name => inst }
  bucket                  = "${var.env}-${each.value.name}-artifacts"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
