variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
}

variable "datadog_app_key" {
  description = "Datadog APP Key"
  type        = string
}

variable "datadog_region_url" {
  description = "Datadog Region URL (Defaults to us5 etc). Example: https://api.us5.datadoghq.com/"
  type        = string
  default     = "https://api.us5.datadoghq.com/"
}

variable "lambda_quota_limit" {
  description = "The account wide concurrent lambda limit, default 1000 for aws accounts."
  default     = 1000
  type        = number
}

variable "synthetic_test_locations" {
  description = "List of locations to send synthetic test from"
  type        = list(string)
  default     = ["aws:us-east-1"]
}

variable "default_message" {
  type    = string
  default = <<EOT
A Datadog Alarm Has Triggered. Please investigate.
EOT
}

variable "env_filter" {
  type        = string
  description = "The filter to apply to all monitors (such as env:prod etc). Helps if you are ingesting multiple environments into DD"
  default     = "*"
}