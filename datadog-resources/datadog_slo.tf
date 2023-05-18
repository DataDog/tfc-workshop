##-----------------------------------------##
##      Create Datadog SLO for Storedog      ##
## ----------------------------------------##
resource "datadog_service_level_objective" "storedog_uptime" {
  depends_on = [
    datadog_synthetics_test.eCommerce
  ]
  name        = "Storedog Uptime SLO"
  type        = "monitor"
  description = "Storedog Index Uptime SLO"
  monitor_ids = ["${datadog_synthetics_test.eCommerce.monitor_id}"]

  thresholds {
    timeframe = "7d"
    target    = 99.9
    warning   = 99.99
  }

  thresholds {
    timeframe = "30d"
    target    = 99.9
    warning   = 99.99
  }

   tags    = ["owner:aron.day", "env:development", "app:storedog"]
}