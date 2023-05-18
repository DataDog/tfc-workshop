#Use the exisiting Terraform State from TFC
data "terraform_remote_state" "eks" {
  backend = "remote"

  config = {
    organization = var.org_name
    workspaces = {
      name = "aws-eks"
    }
  }
}

# Retrieve EKS cluster configuration from aws_eks workspace
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

#Configure Kubernetes Provider based on EKS cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}

#Create the Kubernetes Namespace for the application + Datadog
resource "kubernetes_namespace" "storedog" {
  metadata {
    name = var.application_name
  }
}