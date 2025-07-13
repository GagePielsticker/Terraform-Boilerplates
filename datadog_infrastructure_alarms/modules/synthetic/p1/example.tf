#Simple Synthetic Test Example checks for 200 status
module "example" {
  source = "../base"
  name   = "Example Synthetic Test"

  url = "https://example.com"
  method = "GET"
  headers = {
    Content-Type = "application/json"
  }

  message   = var.default_message
  locations = var.synthetic_test_locations
}