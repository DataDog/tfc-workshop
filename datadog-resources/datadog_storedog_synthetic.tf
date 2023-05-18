resource "datadog_synthetics_test" "storedog_browser_test" {
  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on button #add-to-cart-button"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"main\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"button\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"button\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" input-group-append \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" input-group-append \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"co\":\"[{\\\"text\\\":\\\"add to cart\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[local-name()=\\\"button\\\"]\"},\"targetOuterHTML\":\"<button name=\\\"button\\\" type=\\\"submit\\\" class=\\\"btn btn-success\\\" id=\\\"add-to-cart-button\\\">\\n                  Add To Cart\\n</button>\",\"url\":\"https://URL/products/datadog-tote\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on span \"Datadog Tote\""

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"main\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"a\\\"][1]/*[local-name()=\\\"span\\\"][1]\",\"at\":\"/descendant::*[@title=\\\"Datadog Tote\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" mt-4 \\\")][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" info \\\")]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"datadog tote\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"datadog tote\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"datadog tote\\\"]]\"},\"targetOuterHTML\":\"<span class=\\\"info mt-3 d-block\\\" itemprop=\\\"name\\\" title=\\\"Datadog Tote\\\">Datadog Tote</span>\",\"url\":\"https://URL/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Test the active page does not contain text"

    params {
      delay      = "0"
      value      = "error"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertPageLacks"
  }

  device_ids = ["chrome.laptop_large"]
  locations  = ["aws:${var.aws_region}"]
  message    = "eCommerce Application is not responding"
  name       = "Checkout eCommerce app via browser"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "0"
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    monitor_priority = "1"
    no_screenshot    = "false"

    retry {
      count    = "0"
      interval = "300"
    }

    rum_settings {
      client_token_id = "0"
      is_enabled      = "false"
    }

    tick_every = "300"
  }

  request_definition {
    dns_server_port         = "0"
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    port                    = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = data.terraform_remote_state.k8s.outputs.frontend
  }

  status = "live"
  tags   = ["app:ecommerce", "env:development", "service:store-frontend"]
  type   = "browser"
}
