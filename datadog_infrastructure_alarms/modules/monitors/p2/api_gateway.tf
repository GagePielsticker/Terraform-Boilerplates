#Api Gateway Latency Alarm
module "api_gateway_latency" {
  source    = "../base"
  name      = "API Gateway > 6s Latency"
  query     = "max(last_30m):avg:aws.apigateway.latency{${var.env_filter}} by {apiname} > 6000"
  threshold = 6000
  priority  = 2

  message = var.default_message
}