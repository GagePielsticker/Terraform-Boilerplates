# Needed for child module to have access to provider
terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

#ALERT IF NO METRICS PRESENTING
resource "datadog_monitor" "metric_monitor" {
  name     = "Metric Ingest Monitor"
  type     = "metric alert"
  message  = "NO DATA IS PRESENTING TO DD MONITORS, PLEASE INVESTIGATE!!"
  query    = "avg(${var.monitor_timescale}):avg:aws.rds.cpuutilization{${var.env_filter}} by {name} == -1"
  priority = 1

  evaluation_delay = 900
  new_group_delay  = 300
  timeout_h        = 0

  notify_no_data      = true
  notify_audit        = false
  require_full_window = false

  monitor_thresholds {
    critical = -1
  }
}

# Monitor concurrent lambdas against default quota
resource "datadog_monitor" "lambda_concurrency" {
  name     = "Lambda Concurrency 90% Usage"
  type     = "metric alert"
  message  = var.default_message
  query    = "sum(${var.monitor_timescale}):max:aws.lambda.concurrent_executions{${var.env_filter}} / ${var.lambda_quota_limit} > 0.9"
  priority = 2

  evaluation_delay = 900
  timeout_h        = 0

  notify_no_data      = false
  notify_audit        = false
  require_full_window = false

  monitor_thresholds {
    critical = 0.9
  }
}