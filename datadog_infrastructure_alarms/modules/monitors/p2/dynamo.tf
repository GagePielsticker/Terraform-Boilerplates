#Dynamo Read Throttling
module "dynamo_read_throttles" {
  source    = "../base"
  name      = "DynamoDB Read Throttles"
  query     = "sum(last_10m):sum:aws.dynamodb.read_throttle_events{${var.env_filter}} by {tablename}.as_count() > 1"
  threshold = 1
  priority  = 2

  message = var.default_message
}

#Dynamo Latency
module "dynamo_latency" {
  source    = "../base"
  name      = "DynamoDB High Latency"
  query     = "avg(last_1h):avg:aws.dynamodb.successful_request_latency{${var.env_filter}} by {tablename} > 1200"
  threshold = 1200
  priority  = 2

  message = var.default_message
}

#Dynamo Write Throttles
module "dynamo_write_throttles" {
  source    = "../base"
  name      = "DynamoDB Write Throttles"
  query     = "sum(last_10m):sum:aws.dynamodb.write_throttle_events{${var.env_filter}} by {tablename}.as_count() > 1"
  threshold = 1
  priority  = 2

  message = var.default_message
}