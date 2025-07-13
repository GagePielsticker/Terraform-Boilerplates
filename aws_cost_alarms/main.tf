provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project = "cost-budgets"
    }
  }
}

variable "limit_amount_USD" {
  type        = string
  description = "Cost in USD to monitor for"
  default     = "20"
}

variable "emails" {
  type        = set(string)
  description = "Set of emails to alert when thresholds crossed"
  default     = ["test@test.com", "test2@test.com"]
}

resource "aws_budgets_budget" "account_budget" {
  name         = "Account Budget"
  budget_type  = "COST"
  limit_amount = var.limit_amount_USD
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.emails
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.emails
  }
}