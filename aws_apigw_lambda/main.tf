#Created shared resources
module "shared_iam_role" {
  source = "./modules/iam"
}

module "api_gateway" {
  source            = "./modules/api-gateway"
  apigw_name        = var.apigateway_name
  apigw_description = var.apigateway_description
}

module "lambda_definitions" {
  source          = "./lambda_definitions"
  shared_iam_role = module.shared_iam_role
  api_gateway     = module.api_gateway
}

#Create deployment 
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    module.lambda_definitions
  ]
  rest_api_id = module.api_gateway.api.id
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = module.api_gateway.api.id
  stage_name    = "api"
}

resource "aws_api_gateway_method_settings" "api_stage_settings" {
  rest_api_id = module.api_gateway.api.id
  stage_name  = aws_api_gateway_stage.api_stage.stage_name
  method_path = "*/*"

  settings {
    logging_level = "INFO"
  }
}