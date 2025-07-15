#Create lambdas
module "test_lambda1" {
  source = "../modules/lambda"

  lambda_name        = "test-lambda"
  lambda_description = "My Super Cool Lambda"
  lambda_file_path   = "./src/lambda1/"
  lambda_handler     = "index.handler"
  lambda_runtime     = "nodejs22.x"
  lambda_role        = var.shared_iam_role.role

  memory_size = 1024
  timeout     = 30

  log_retention = 14

  api_gateway = var.api_gateway.api
  route       = "myroute"
  method      = "GET"
}

module "test_lambda2" {
  source = "../modules/lambda"

  lambda_name        = "test-lambda2"
  lambda_description = "My Super Cool Lambda"
  lambda_file_path   = "./src/lambda2/"
  lambda_handler     = "index.handler"
  lambda_runtime     = "nodejs22.x"
  lambda_role        = var.shared_iam_role.role

  memory_size = 1024
  timeout     = 30

  log_retention = 14

  api_gateway = var.api_gateway.api
  route       = "myroute2"
  method      = "GET"
}
