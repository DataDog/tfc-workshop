resource "kubernetes_service_account" "postgres" {
  depends_on = [
    kubernetes_namespace.storedog
  ]
  metadata {
    name = "postgres"
    namespace = kubernetes_namespace.storedog.id
  }
}

resource "kubernetes_secret" "db_password" {
  depends_on = [
    kubernetes_namespace.storedog
  ]
  metadata {
    labels = {
      "app"                    = "ecommerce"
      "service"                = "db"
    }
    name = "db-password"
    namespace = kubernetes_namespace.storedog.id
  }

  data = {
    pw = "password"
  }

  type = "Opaque"
}

resource "kubernetes_persistent_volume" "db" {
  metadata {
    labels = {
      "type"                = "local"
    }
    name = "task-pv-volume"
  }
  spec {
    capacity = {
      storage = "5Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/mnt/data"
      }
    }
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name = "manual"
  }
}

resource "kubernetes_persistent_volume_claim" "db" {
  depends_on = [
    kubernetes_namespace.storedog
  ]
  metadata {
    name = "task-pvc-volume"
    namespace = kubernetes_namespace.storedog.id
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "manual"
  }
}

resource "kubernetes_deployment" "db" {
  depends_on = [
    kubernetes_namespace.storedog
  ]
  metadata {
    labels = {
      "app"                    = "ecommerce"
      "service"                = "db"
    }
    name      = "db"
    namespace = kubernetes_namespace.storedog.id
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "ecommerce"
        service = "db"
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
          "ad.datadoghq.com/postgres.logs" = "[{\"source\": \"postgresql\", \"service\": \"postgres\"}]"
    }
        labels = {
          "app"                    = "ecommerce"
          "service"                = "db"
        }
      }

      spec {
        container {
          env {
            name  = "POSTGRES_USER"
            value = "user"
          }

          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = "db-password"
                key  = "pw"
              }
            }
          }
          
          env {
            name  = "PGDATA"
            value = "/var/lib/postgresql/data/mydata"
          }

          image             = "postgres:11-alpine"
          image_pull_policy = "Always"
          name              = "postgres"
          port {
            container_port = 5432
            protocol       = "TCP"
          }

          resources {}
          security_context {
            privileged = true
          }
          volume_mount {
            mount_path = "/var/lib/postgresql/data"
            name = "postgresdb"
          }
        }
        service_account_name = "postgres"
        volume {
          name = "postgresdb"
          persistent_volume_claim {
            claim_name = "task-pvc-volume"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "db" {
  depends_on = [
    kubernetes_namespace.storedog
  ]
  metadata {
    name      = "db"
    namespace = kubernetes_namespace.storedog.id
    labels = {
      app     = "ecommerce"
      service = "db"
    }
  }
  spec {
    selector = {
      app = "ecommerce"
      service = "db"
    }
    port {
      port        = 5432
      target_port = 5432
    }
    #Unsure if we need this
      # session_affinity = "None"
      # type = "ClusterIP"
  }
}