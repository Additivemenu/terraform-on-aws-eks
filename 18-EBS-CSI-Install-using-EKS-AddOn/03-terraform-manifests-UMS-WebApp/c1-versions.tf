# Terraform Settings Block
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = ">= 5.31"
     }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }     
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-shawn6237"
    key    = "dev/dev-ebs-sampleapp-demo/terraform.tfstate"
    region = "ap-southeast-2" 

    # For State Locking
    dynamodb_table = "dev-ebs-sampleapp-demo"    
  }    
}

