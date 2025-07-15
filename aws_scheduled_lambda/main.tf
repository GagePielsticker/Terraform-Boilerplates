
module "shared_iam_role" {
  source = "./modules/iam/lambda"
}

module "lambda" {
  source = "./modules/lambda"

  lambda_name        = "My-Scheduled-Lambda"
  lambda_description = "My Super Cool Lambda"
  lambda_file_path   = "./src/"
  lambda_handler     = "index.handler"
  lambda_runtime     = "nodejs22.x"
  lambda_role        = module.shared_iam_role.role

  memory_size = 1024
  timeout     = 30

  log_retention = 14
}

module "schedule" {
  source = "./modules/eventbridge"

  schedule_name        = "lambda-scheduler"
  schedule_description = "Deployed Schedule"
  schedule_rate        = "rate(1 minutes)" #minute | minutes | hour | hours | day | days

  lambda_arn = module.lambda.lambda.arn
}

