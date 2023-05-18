resource "kubernetes_deployment" "frontend" {
  depends_on = [kubernetes_namespace.storedog, datadog_rum_application.storedog]
  metadata {
    labels = {
      "app"                    = "ecommerce"
      "tags.datadoghq.com/env" = "development"
      "tags.datadoghq.com/service" = "storefront"
    }
    name      = "frontend"
    namespace = kubernetes_namespace.storedog.id
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        "app"     = "ecommerce"
        "tags.datadoghq.com/env" = "development"
        "tags.datadoghq.com/service" = "storefront"
      }
    }
    strategy {
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
      type = "RollingUpdate"
    }

    template {
      metadata {
        annotations = {
          "ad.datadoghq.com/storefront-fixed.logs" = "[{\"source\": \"ruby\", \"service\": \"storefront\"}]"
    }
        labels = {
          "app"                    = "ecommerce"
          "tags.datadoghq.com/env" = "development"
          "tags.datadoghq.com/service" = "storefront"
        }
      }

      spec {
        container {
          args    = ["docker-entrypoint.sh"]
          command = ["sh"]
          env {
            name  = "DB_USERNAME"
            value = "user"
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = "db-password"
                key  = "pw"
              }
            }
          }
          env {
            name = "DD_AGENT_HOST"
            value_from {
              field_ref {
                field_path = "status.hostIP"
              }
            }
          }

          env {
            name = "DD_SERVICE"
            value_from {
              field_ref {
                field_path = "metadata.labels['tags.datadoghq.com/service']"
              }
            }
          }
          
          env {
            name  = "DD_LOGS_INJECTION"
            value = true
          }

          env {
            name = "DD_ENV"
            value_from {
              field_ref {
                field_path = "metadata.labels['tags.datadoghq.com/env']"
              }
            }
          }

          env {
            name  = "DD_ANALYTICS_ENABLED"
            value = true
          }

          env {
            name  = "DISCOUNTS_ROUTE"
            value = "http://discounts"
          }

          env {
            name  = "DISCOUNTS_PORT"
            value = "5001"
          }

          env {
            name  = "ADS_ROUTE"
            value = "http://advertisements"
          }

          env {
            name  = "ADS_PORT"
            value = "5002"
          }

          env {
            name  = "DD_CLIENT_TOKEN"
            value = "${datadog_rum_application.storedog.client_token}"
          }

          env {
            name  = "DD_APPLICATION_ID"
            value = "${datadog_rum_application.storedog.id}"
          }


          image             = "public.ecr.aws/x2b9z2t7/ddtraining/storefront-fixed:2.2.1"
          image_pull_policy = "Always"
          name              = "ecommerce-spree-observability"
          port {
            container_port = 3000
            protocol       = "TCP"
          }

          resources {
            # "limits" = {}
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  depends_on = [
    kubernetes_namespace.storedog
  ]
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.storedog.id
    labels = {
      "app"     = "ecommerce"
      "tags.datadoghq.com/env" = "development"
      "tags.datadoghq.com/service" = "storefront"
    }
  }
  spec {
    selector = {
      "app" = "ecommerce"
      "tags.datadoghq.com/env" = "development"
      "tags.datadoghq.com/service" = "storefront"
    }
    port {
      port        = 80
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}

output "frontend" {
  value = "http://${kubernetes_service.frontend.status.0.load_balancer.0.ingress.0.hostname}"
}