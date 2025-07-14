#Service Limits (ONLY WORKS IF YOU HAVE ENTERPRISE AWS SUPPOSEDLY)
module "aws_service_limits" {
  source    = "../base"
  name      = "AWS Service Limit > 70%"
  query     = "max(${var.monitor_timescale}):max:aws.trustedadvisor.service_limit_usage{${var.env_filter}} by {servicelimit} > 70"
  threshold = 70
  priority  = 2

  message = var.default_message
}