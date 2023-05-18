resource "datadog_monitor" "k8_pods_unhealty" {
  escalation_message = "Please investigate the eCommerce App, @operator"
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "Kubernetes Pods are not in an optimal health state. Notify: @operator"

  monitor_thresholds {
    critical = "1"
    warning  = "2"
  }

  name                 = "Checking ecommerce pods"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "10"
  notify_audit         = "false"
  notify_no_data       = "true"
  priority             = "0"
  query                = "max(last_1m):sum:kubernetes.containers.running{env:development}<=1"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "true"
  tags                 = ["app:ecommerce", "tags.datadoghq.com/env:development"]
  timeout_h            = "0"
  type                 = "metric alert"
}

resource "datadog_monitor" "discounts_service_error_rate" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`discountsservice` error rate is too high."

  monitor_thresholds {
    critical = "0.05"
    warning  = "0.01"
  }

  name                 = "Service discountsservice has a high error rate on env:development"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "0"
  query                = "sum(last_1m): ( sum:trace.flask.request.errors{env:development,service:discountsservice}.as_count() / sum:trace.flask.request.hits{env:development,service:discountsservice}.as_count() ) > 0.05"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "false"
  tags                 = ["env:development", "service:discountsservice"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "discounts_service_latency" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`discountsservice` average latency is too high."

  monitor_thresholds {
    critical = "0.5"
    warning  = "0.3"
  }

  name                 = "Service discountsservice has a high average latency on env:development"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "0"
  query                = "avg(last_1m): ( sum:trace.flask.request.duration{env:development,service:discountsservice}.rollup(sum).fill(zero) / sum:trace.flask.request.hits{env:development,service:discountsservice} ) > 0.5"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "false"
  tags                 = ["env:development", "service:discountsservice"]
  timeout_h            = "0"
  type                 = "metric alert"
}

resource "datadog_monitor" "store_frontend_error_rate" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`store-frontend` error rate is too high."

  monitor_thresholds {
    critical = "0.05"
    warning  = "0.01"
  }

  name                 = "Service store-frontend has a high error rate on env:development"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "0"
  query                = "sum(last_1m): ( sum:trace.rack.request.errors{env:development,service:store-frontend}.as_count() / sum:trace.rack.request.hits{env:development,service:store-frontend}.as_count() ) > 0.05"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "false"
  tags                 = ["env:development", "service:store-frontend"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "store_frontend_latency" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`store-frontend` average latency is too high\n\nFor more detail take a look to the [StoreDog 3Pillars Dashboards](https://app.datadoghq.com/dashboard/msy-hmt-yug/standard-store-dog-dashboard?from_ts=1669304352081\u0026to_ts=1669307952081\u0026live=true)\n \n \n   @jaime.alonso@datadoghq.com"

  monitor_thresholds {
    critical = "0.4"
    warning  = "0.3"
  }

  name                 = "Service store-frontend has a high average latency on env:development"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "0"
  query                = "avg(last_1m):( sum:trace.rack.request.duration{env:development,service:store-frontend}.rollup(sum).fill(zero) / sum:trace.rack.request.hits{env:development,service:store-frontend} ) > 0.4"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "false"
  tags                 = ["env:development", "service:store-frontend"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "postgres_latency" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`postgres` average latency is too high."

  monitor_thresholds {
    critical = "0.5"
    warning  = "0.3"
  }

  name                 = "Service postgres has a high average latency on env:development"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "0"
  query                = "avg(last_3m): ( sum:trace.postgres.query.duration{env:development,service:postgres}.rollup(sum).fill(zero) / sum:trace.postgres.query.hits{env:development,service:postgres} ) > 0.5"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "false"
  tags                 = ["env:development", "service:postgres"]
  timeout_h            = "0"
  type                 = "metric alert"
}
