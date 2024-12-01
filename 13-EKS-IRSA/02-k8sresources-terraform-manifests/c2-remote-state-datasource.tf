# data "terraform_remote_state" "eks" {
#   backend = "local"  // it can also be remote where you store the state file in S3 bucket -> in s12
#   config = {
#     path = "../../08-AWS-EKS-Cluster-Basics/01-ekscluster-terraform-manifests/terraform.tfstate"
#    }
# }

# ! Terraform Remote State Datasource -> where you get info from the state file of the EKS cluster
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-shawn6237"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}