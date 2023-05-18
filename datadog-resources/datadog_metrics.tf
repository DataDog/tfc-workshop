/*
resource "datadog_monitor" "ecommerce" {
  name               = "Checking ecommerce pods"
  type               = "metric alert"
  message            = "Kubernetes Pods are not in an optimal health state. Notify: @operator"
  escalation_message = "Please investigate the eCommerce App, @operator"

  query = "max(last_1m):sum:kubernetes.containers.running{env:development}<=1"

  monitor_thresholds {
    ok       = 3
    warning  = 2
    critical = 1
  }

  notify_no_data = true

  tags = ["app:ecommerce", "tags.datadoghq.com/env:development"]
}
*/