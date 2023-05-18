#Create a RUM application in Datadog
resource "datadog_rum_application" "storedog" {
  name = "storedog"
  type = "browser"
}