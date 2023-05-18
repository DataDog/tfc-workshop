terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.15.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
  }
  required_version = "~> 1.4.5"
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


