module "iam" {
  source     = "../iam/eventbridge"
  lambda_arn = var.lambda_arn
}

resource "aws_scheduler_schedule" "example" {
  name        = var.schedule_name
  description = var.schedule_description

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = var.schedule_rate

  target {
    arn      = var.lambda_arn
    role_arn = module.iam.arn
  }
}

