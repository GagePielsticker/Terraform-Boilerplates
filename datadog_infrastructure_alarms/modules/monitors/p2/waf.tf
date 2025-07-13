#Appsync reporting high latency of over 2 seconds
module "waf_blocked_request" {
  source    = "../base"
  name      = "WAF Blocked Request"
  query     = "sum(last_10m):sum:aws.wafv2.blocked_requests{${var.env_filter}} by {webacl}.as_count() > 2000"
  threshold = 2000
  priority  = 2

  message = <<EOT
WAF {{webacl.name}} has a high blocked request count. Please investigate!

EOT
}