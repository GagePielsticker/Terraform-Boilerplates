# Needed for child module to have access to provider
terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

resource "datadog_synthetics_test" "test_uptime" {
  name      = var.name
  type      = "api"
  subtype   = "http"
  status    = "live"
  message   = var.message
  locations = var.locations

  request_definition {
    method = var.method
    url    = var.url
  }

  request_headers = var.headers

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  options_list {
    tick_every = 900
    retry {
      count    = 2
      interval = 300
    }
  }
}

#https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/synthetics_test