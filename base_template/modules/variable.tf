variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "state_s3_name" {
  type    = string
  default = "tf-backend-state"
}

variable "state_dynamo_name" {
  type    = string
  default = "tf-backend-state"
}