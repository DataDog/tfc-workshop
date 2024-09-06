# Introduction to monitoring AWS EKS with Datadog and HashiCorp Cloud Platform

## Related tutorials and repositories

* [Provision an EKS Cluster (AWS)](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks)
* [Automate Monitoring with the Terraform Datadog Provider](https://developer.hashicorp.com/terraform/tutorials/applications/datadog-provider)
* [DataDog/ecommerce-workshop](https://github.com/DataDog/ecommerce-workshop/tree/main/deploy/generic-k8s/ecommerce-app)

## Prerequisites
To run this workshop code you will need the following:
1. A datadog learning center account [Free Account](https://learn.datadoghq.com/)
2. An AWS account to install a Kubernetes cluster (EKS) - Provided within the Datadog learning center lab. 
2. A Datadog account - Provided within the Datadog learning center lab. 
3. A HashiCorp Cloud Platform account
4. A github account
5. Fork this repository

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

## Setup
Proceed to the Datadog learning center and look for our lab `Introduction to monitoring AWS with Datadog & HashiCorp Cloud Platform`
All steps for the lab are contained there. 
