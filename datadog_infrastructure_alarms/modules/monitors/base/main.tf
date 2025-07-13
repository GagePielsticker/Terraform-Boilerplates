# Needed for child module to have access to provider
terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

resource "datadog_monitor" "default_setup" {
  name     = var.name
  type     = "metric alert"
  message  = var.message
  query    = var.query
  priority = var.priority

  evaluation_delay = 900
  new_group_delay  = 300
  timeout_h        = 0

  notify_no_data      = false
  notify_audit        = false
  require_full_window = false

  monitor_thresholds {
    critical = var.threshold
  }
}
