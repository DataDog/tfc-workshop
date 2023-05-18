provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

locals {
  # cluster_name = "datadog-webminar-${random_string.suffix.result}"
  cluster_name = "datadog-x-hashicorp-workshop"
}
