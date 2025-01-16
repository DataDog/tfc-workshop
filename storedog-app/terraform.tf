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
  }
  required_version = "~> 1.10"
}

provider "aws" {
  region = var.aws_region
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
