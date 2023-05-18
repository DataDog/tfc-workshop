provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "datadog_agent" {
  name       = "datadog-agent"
  chart      = "datadog"
  repository = "https://helm.datadoghq.com"
  version    = "3.25.5"
  namespace  = kubernetes_namespace.storedog.id

  set_sensitive {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }

  set {
    name  = "datadog.logs.enabled"
    value = true
  }

  set {
    name  = "datadog.logs.containerCollectAll"
    value = true
  }

  set {
    name  = "datadog.leaderElection"
    value = true
  }

  set {
    name  = "datadog.collectEvents"
    value = true
  }

  set {
    name  = "clusterAgent.enabled"
    value = true
  }

  set {
    name  = "clusterAgent.metricsProvider.enabled"
    value = true
  }

  set {
    name  = "networkMonitoring.enabled"
    value = true
  }

  set {
    name  = "systemProbe.enableTCPQueueLength"
    value = true
  }

  set {
    name  = "systemProbe.enableOOMKill"
    value = true
  }

  set {
    name  = "securityAgent.runtime.enabled"
    value = true
  }

  set {
    name  = "datadog.hostVolumeMountPropagation"
    value = "HostToContainer"
  }
  set {
    name  = "datadog.clusterName"
    value = "datadog-x-hashicorp-workshop"
  }
  set {
    name  = "datadog.apm.portEnabled"
    value = true
  }

  set {
    name  = "datadog.processAgent.enabled"
    value = true
  }

  set {
    name  = "datadog.networkMonitoring.enabled"
    value = true
  }

  set {
    name  = "datadog.kubelet.tlsVerify"
    value = false
  }

  set {
    name  = "datadog.processAgent.processCollection"
    value = true
  }

}

