#RDS Read Latency
module "rds_latency_10ms" {
  source    = "../base"
  name      = "RDS LATENCY > 10ms"
  query     = "avg(last_10m):min:aws.rds.read_latency{${var.env_filter}} by {name} > 0.01"
  threshold = 0.01
  priority  = 2

  message = var.default_message
}

#RDS Blocked Transactions
module "rds_blocked_transactions" {
  source    = "../base"
  name      = "RDS Blocked Transactions > .04"
  query     = "sum(last_10m):max:aws.rds.blocked_transactions{${var.env_filter}} by {name}.as_count() > 0.04"
  threshold = 0.04
  priority  = 2

  message = var.default_message
}

#RDS Writer Instance Replication Error
module "rds_writer_replication" {
  source    = "../base"
  name      = "RDS Writer Instance Replication Errors"
  query     = "avg(last_15m):avg:aws.rds.aurora_binlog_replica_lag{${var.env_filter}, role:writer} by {name} <= -1"
  threshold = -1
  priority  = 2

  message = var.default_message
}

#RDS has minimum storage of 10GiB left
module "rds_size_10GiB" {
  source    = "../base"
  name      = "RDS 10GiB Storage Remaining"
  query     = "min(last_1h):min:aws.rds.free_storage_space{${var.env_filter}} by {name} <= 10740000000"
  threshold = 10740000000
  priority  = 2

  message = var.default_message
}

#RDS dbload high
module "rds_db_load" {
  source    = "../base"
  name      = "RDS DBLoad High"
  query     = "avg(last_10m):avg:aws.rds.dbload{${var.env_filter}} by {name} > 15"
  threshold = 15
  priority  = 1

  message = var.default_message
}