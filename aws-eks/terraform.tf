terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.39.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.4.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.15.0"
    }
  }

  required_version = "~> 1.4"
}

