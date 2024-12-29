# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-shawn6237"  #! bucket name is global unique
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "ap-southeast-2" 
  }
}