# Building an EKS cluster

To build this EKS cluster we have used as reference the content of this Terraform Tutorial: [Provision and EKS Cluster (AWS)](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks).

There are a couple of diferences in relation to what you can find in that Tutorial:

1. We were hitting this issue: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1986 and so we implemented the suggested workaround: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1986#issuecomment-1112635625. To that end we have included the following block within the eks module (`eks-cluster.tf`)

   ```bash
     node_security_group_tags = {
       "kubernetes.io/cluster/${local.cluster_name}" = null
     }
   ```
2. We need to declare the VPC name and AWS Region as terraform variables and define  the AWS credentials as enviromental variables:

   * AWS_ACCESS_KEY_ID
   * AWS_SECRET_ACCESS_KEY