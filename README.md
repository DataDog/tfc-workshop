# Introduction to monitoring AWS EKS with Datadog and HashiCorp Cloud Platform

This repository contains the code for the Datadog and HashiCorp Cloud Platform workshop.

## Related tutorials and repositories

* [Provision an EKS Cluster (AWS)](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks)
* [Automate Monitoring with the Terraform Datadog Provider](https://developer.hashicorp.com/terraform/tutorials/applications/datadog-provider)
* [DataDog/ecommerce-workshop](https://github.com/DataDog/ecommerce-workshop/tree/main/deploy/generic-k8s/ecommerce-app)

## Prerequisites

To run this workshop code you will need the following:

1. A Datadog Learning Center account [Free Account](https://learn.datadoghq.com/)
1. An AWS account to install a Kubernetes cluster (EKS) - Provided within the Datadog Learning Center lab.
1. A Datadog account - Provided within the Datadog Learning Center lab.
1. A HashiCorp Cloud Platform account
1. A GitHub account
1. Fork this repository

> [!NOTE]
> To run this workshop, you will need to make a request to the Datadog Customer Education & Training team to get access to the Datadog Learning Center lab. It is not publicly available.

## Content

Each folder contains does something different.

* **aws-eks/**: Terraform configuration to define a three node cluster in EKS.

* **storedog-app/**: Terraform configuration to do the following:

  * Deploy an eCommerce application called Storedog with a Load Balancer
  * Deploy Datadog Agent on EKS cluster via helm
  * Deploy Datadog AWS Intergration & associated IAM policies.
  
* **datadog-resources/**: Terraform configuration to:

  * Create dashboards in Datadog
  * Create synthetic tests in Datadog
  * Create monitors in Datadog
