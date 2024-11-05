# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # a provider plugin
      #version = "~> 5.31" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" # ! AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "ap-southeast-2" # ! make sure this AZ has a default VPC the AMI you are using
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-0f71013b2c8bd2c29" # Amazon Linux in ap-southeast-2, update as per your region
  instance_type = "t2.micro"
}
