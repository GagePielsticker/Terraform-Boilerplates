#ELB Response time reporting over 10s
module "elb_response_time" {
  source    = "../base"
  name      = "ELB Response Time > 10s"
  query     = "avg(${var.monitor_timescale}):avg:aws.applicationelb.target_response_time.average{${var.env_filter}} by {name} > 10"
  threshold = 10
  priority  = 2

  message = var.default_message
}

#ELB Target Connection Error
module "elb_target_connection" {
  source    = "../base"
  name      = "ELB Target Connection Error"
  query     = "sum(${var.monitor_timescale}):sum:aws.applicationelb.target_connection_error_count{${var.env_filter}} by {name}.as_count() > 0"
  threshold = 0
  priority  = 2

  message = var.default_message
}