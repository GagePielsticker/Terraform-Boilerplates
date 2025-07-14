#ECS Memory Alert
module "ecs_memory_alert" {
  source    = "../base"
  name      = "ECS Memory Usage > 75%"
  query     = "avg(${var.monitor_timescale}):avg:aws.ecs.memory_utilization{${var.env_filter}} by {clustername} > 75"
  threshold = 75
  priority  = 2

  message = var.default_message
}

#ECS CPU Alert
module "ecs_cpu_alert" {
  source    = "../base"
  name      = "ECS CPU Usage > 75%"
  query     = "avg(${var.monitor_timescale}):avg:aws.ecs.cpuutilization{${var.env_filter}} by {clustername} > 75"
  threshold = 75
  priority  = 2

  message = var.default_message
}