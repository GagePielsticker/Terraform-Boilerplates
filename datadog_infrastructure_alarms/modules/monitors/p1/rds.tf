#RDS CPU > 90%
module "rds_CPU_90" {
  source    = "../base"
  name      = "RDS CPU > 90%"
  query     = "avg(${var.monitor_timescale}):avg:aws.rds.cpuutilization{${var.env_filter}} by {name} > 90"
  threshold = 90
  priority  = 1

  message = var.default_message
}

#RDS Writer Instance Crashed
module "rds_writer_crash" {
  source    = "../base"
  name      = "RDS Writer Instance Crashed"
  query     = "min(${var.monitor_timescale}):min:aws.rds.engine_uptime{${var.env_filter}, role:writer} by {name} <= 0"
  threshold = 0
  priority  = 1

  message = var.default_message
}
