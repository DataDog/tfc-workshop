terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.15.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
  datadog = {
      source  = "datadog/datadog"
      version = "~> 3.18.0"
    }
  }
  required_version = "~> 1.4.5"
}

provider "aws" {
  region = var.aws_region
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
