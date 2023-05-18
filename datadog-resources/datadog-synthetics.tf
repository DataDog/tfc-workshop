##-----------------------------------------##
##    Create Datadog Synthetics API  test    ##
## ----------------------------------------##

# Create a new Datadog Synthetics API test on storedog!

resource "datadog_synthetics_test" "eCommerce" {
  type    = "api"
  subtype = "http"

  request_definition {
    method = "GET"
    url    = data.terraform_remote_state.k8s.outputs.frontend
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  locations = ["aws:${var.aws_region}"]
  options_list {
    tick_every          = 60
    min_location_failed = 1
  }

  name    = "Checking eCommerce app via API"
  message = "eCommerce Application is not responding to GET requests"
  tags    = ["app:ecommerce", "env:development", "service:store-frontend"]

  status = "live"
}

##---------------------------------------------##
##    Create Datadog Synthetics Browser test    ##
## --------------------------------------------##

# Create a new Datadog Synthetics BrowserI test on storedog!

resource "datadog_synthetics_test" "eCommerce_browser" {
  type    = "browser"
  subtype = "http"

  request_definition {
    method = "GET"
    url    = data.terraform_remote_state.k8s.outputs.frontend
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  device_ids = ["laptop_large"]

  locations = ["aws:${var.aws_region}"]
  options_list {
    tick_every          = 1200
    min_location_failed = 1
  }

  name    = "Checking eCommerce app via browser"
  message = "eCommerce Application is not responding"
  tags    = ["app:ecommerce", "env:development", "service:store-frontend"]

  status = "live"
}