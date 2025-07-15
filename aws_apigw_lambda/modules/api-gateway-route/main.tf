resource "aws_api_gateway_resource" "route" {
  rest_api_id = var.api_gateway.id
  parent_id   = var.api_gateway.root_resource_id
  path_part   = var.route
}

resource "aws_api_gateway_method" "route_method" {
  rest_api_id   = var.api_gateway.id
  resource_id   = aws_api_gateway_resource.route.id
  http_method   = var.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = var.api_gateway.id
  resource_id = aws_api_gateway_method.route_method.resource_id
  http_method = aws_api_gateway_method.route_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda.invoke_arn
}