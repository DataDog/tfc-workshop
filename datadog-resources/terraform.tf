terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.50.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.1"
    }
  }
  required_version = "~> 1.10"
}

data "terraform_remote_state" "k8s" {
  backend = "remote"

  config = {
    organization = var.org_name
    workspaces = {
      name = "storedog-app"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}


