resource "datadog_dashboard" "storedog_dashboard" {
  layout_type  = "ordered"
  reflow_type  = "fixed"
  url = "tgy-akk-nin/storedog-dashboard"
  title        = "Storedog Dashboard"

    widget {
    image_definition {
      has_background   = "true"
      has_border       = "true"
      horizontal_align = "center"
      sizing           = "cover"
      url              = "https://static.boredpanda.com/blog/wp-content/uploads/2014/08/dog-opens-counter-window-shiba-inu-doge-gif.gif"
      vertical_align   = "center"
    }

    widget_layout {
      height          = "5"
      is_column_break = "false"
      width           = "6"
      x               = "0"
      y               = "0"
    }
  }

    widget {
    manage_status_definition {
      color_preference    = "text"
      display_format      = "countsAndList"
      hide_zero_counts    = "true"
      query               = ""
      show_last_triggered = "false"
      show_priority       = "false"
      sort                = "status,asc"
      summary_type        = "monitors"
    }

    widget_layout {
      height          = "5"
      is_column_break = "false"
      width           = "6"
      x               = "6"
      y               = "0"
    }
  }
  
  widget {
    group_definition {
      background_color = "gray"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "INFRA"

      widget {
        note_definition {
          background_color = "blue"
          content          = "\n\nContainers"
          font_size        = "24"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "center"
          tick_edge        = "bottom"
          tick_pos         = "50%"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "1"
        }
      }

      widget {
        note_definition {
          background_color = "blue"
          content          = "\n\nHost/System"
          font_size        = "24"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "center"
          tick_edge        = "bottom"
          tick_pos         = "50%"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "6"
        }
      }

      widget {
        note_definition {
          background_color = "transparent"
          content          = "This group tracks resource metrics at the node and container level."
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "left"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale   = "false"
          custom_unit = "%"
          live_span   = "5m"
          precision   = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "50"
            }

            conditional_formats {
              comparator = ">="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "80"
            }

            conditional_formats {
              comparator = ">="
              hide_value = "false"
              palette    = "white_on_red"
              value      = "0"
            }

            formula {
              formula_expression = "100 * (query1 / timeshift(query1, -300))"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:docker.containers.running{name:storedog}"
              }
            }
          }

          text_align  = "center"
          title       = "Running container change"
          title_align = "center"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1m"
          precision = "0"

          request {
            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:docker.containers.running{name:storedog}"
              }
            }
          }

          text_align  = "center"
          title       = "Running containers"
          title_align = "center"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "8"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1m"
          precision = "0"

          request {
            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:docker.containers.stopped{name:storedog}"
              }
            }
          }

          text_align  = "center"
          title       = "Stopped containers"
          title_align = "center"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_layout = "auto"

          marker {
            display_type = "info solid"
            value        = "0 < y < 100"
          }

          request {
            display_type = "area"

            formula {
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              process_query {
                data_source       = "process"
                is_normalized_cpu = "true"
                limit             = "100"
                metric            = "process.stat.cpu.total_pct"
                name              = "query1"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "true"
          title       = "CPU Usage by Process (%)"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "8"
          y               = "4"
        }
      }

      widget {
        timeseries_definition {
          legend_layout = "auto"

          request {
            display_type   = "area"
            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "system.cpu.idle{host:i-0ad1945254ded3679}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "system.cpu.system{host:i-0ad1945254ded3679}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query3"
                query       = "system.cpu.iowait{host:i-0ad1945254ded3679}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query4"
                query       = "system.cpu.user{host:i-0ad1945254ded3679}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query5"
                query       = "system.cpu.stolen{host:i-0ad1945254ded3679}"
              }
            }
          }

          show_legend = "true"
          title       = "CPU usage (%)"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "7"
        }
      }

      widget {
        timeseries_definition {
          legend_layout = "auto"

          request {
            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "system.load.15{host:i-0ad1945254ded3679}"
              }
            }
          }

          request {
            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "system.load.1{host:i-0ad1945254ded3679}"
              }
            }
          }

          request {
            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "system.load.5{host:i-0ad1945254ded3679}"
              }
            }
          }

          show_legend = "true"
          title       = "Load Averages 1-5-15"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "7"
        }
      }

      widget {
        timeseries_definition {
          legend_size = "0"
          live_span   = "1h"

          request {
            display_type   = "bars"
            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:docker.containers.running{name:storedog} by {docker_image}.fill(0)"
              }
            }
          }

          show_legend = "false"
          title       = "Running containers by image"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "4"
        }
      }

      widget {
        toplist_definition {
          live_span = "1h"

          request {
            formula {
              formula_expression = "timeshift(query1, 40)"

              limit {
                count = "20"
                order = "desc"
              }
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:docker.containers.running{name:storedog} by {docker_image}.fill(60)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          title       = "Running containers by image"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "4"
        }
      }
    }

    widget_layout {
      height          = "10"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "5"
    }
  }

   widget {
    list_stream_definition {
      request {
        columns {
          field = "matches"
          width = "auto"
        }

        columns {
          field = "message"
          width = "auto"
        }

        columns {
          field = "service"
          width = "auto"
        }

        columns {
          field = "status"
          width = "auto"
        }

        columns {
          field = "status_line"
          width = "auto"
        }

        columns {
          field = "volume"
          width = "auto"
        }

        query {
          data_source  = "logs_pattern_stream"
          query_string = "name:storedog"
        }

        response_format = "event_list"
      }

      title_align = "left"
      title_size  = "16"
    }

    widget_layout {
      height          = "9"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_green"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "APM"

      widget {
        topology_map_definition {
          request {
            query {
              data_source = "service_map"
              filters     = ["env:development"]
              service     = "store-frontend"
            }

            request_type = "topology"
          }

          title       = "Service Map"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        trace_service_definition {
          display_format     = "two_column"
          env                = "development"
          service            = "store-frontend"
          show_breakdown     = "true"
          show_distribution  = "true"
          show_errors        = "true"
          show_hits          = "true"
          show_latency       = "true"
          show_resource_list = "false"
          size_format        = "medium"
          span_name          = "rack.request"
          title              = "APM Status"
        }

        widget_layout {
          height          = "12"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }
    }

    widget_layout {
      height          = "17"
      is_column_break = "true"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }
}
