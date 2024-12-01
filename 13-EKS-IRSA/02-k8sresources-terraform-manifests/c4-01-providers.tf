# ! Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# ! Terraform Kubernetes Provider
# access outputs from project-1, so that project-2 can access the same cluster
# to access the cluster, we need 3 things: the cluster endpoint, certificate authority data and token
provider "kubernetes" {
  host = data.terraform_remote_state.eks.outputs.cluster_endpoint 
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token = data.aws_eks_cluster_auth.cluster.token
}