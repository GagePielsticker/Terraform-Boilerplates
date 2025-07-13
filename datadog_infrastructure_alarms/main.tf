#Infra Monitors
module "Infrastructure_P1_Alarms" {
  source             = "./modules/monitors/p1"
  default_message    = var.default_message
  env_filter         = var.env_filter
  lambda_quota_limit = var.lambda_quota_limit
}

module "Infrastructure_P2_Alarms" {
  source          = "./modules/monitors/p2"
  default_message = var.default_message
  env_filter      = var.env_filter
}

#Synthetic Test
module "Synthetic_P1_Alarms" {
  source                   = "./modules/synthetic/p1"
  synthetic_test_locations = var.synthetic_test_locations
  default_message          = var.default_message
}