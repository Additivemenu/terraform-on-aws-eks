# Terraform Remote State Datasource - Remote Backend AWS S3
# !get cluster info in project 01-eks-terraform-manifests
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-shawn6237"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}