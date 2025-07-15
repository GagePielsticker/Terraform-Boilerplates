resource "aws_api_gateway_rest_api" "apigw" {
  name        = var.apigw_name
  description = var.apigw_description
}

output "api" {
  value = aws_api_gateway_rest_api.apigw
}