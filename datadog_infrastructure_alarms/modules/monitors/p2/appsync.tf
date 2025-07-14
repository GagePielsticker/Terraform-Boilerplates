#Appsync reporting high latency of over 2 seconds
module "appsync_latency" {
  source    = "../base"
  name      = "RDS DBLoad High"
  query     = "avg(${var.monitor_timescale}):avg:aws.appsync.latency{${var.env_filter}} by {graphqlapiid} > 2000"
  threshold = 2000
  priority  = 2

  message = var.default_message
}