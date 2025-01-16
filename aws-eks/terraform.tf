terraform {
  required_providers {

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.2"
    }
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.49.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.4.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.5"
    }
  }

  required_version = "~> 1.10"
}

