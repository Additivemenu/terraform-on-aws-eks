/*
Create VPC Terraform Module
# from TF registry: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# check the doc for details of each argument in this module (published by other people)

! module把一些套路化的infra代码封装成一个module，然后在其他地方调用这个module，就可以快速创建infra
! you see, just in 1 block, we are creating VPC, Subnets, Route Tables, Internet Gateway, NAT Gateway, Security Groups, NACLs etc
! but in our project, we are not using module actually, so there were a long list of resources tf files
*/
module "vpc" { # module block label name can be any name you can give
  source  = "terraform-aws-modules/vpc/aws"  # ! this is how we referencing the module from TF registry
  version = "5.4.0" # ! use exact version, so that you can avoid breaking changes in future
    
  # VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"   
  azs                 = ["ap-southeast-2a", "ap-southeast-2b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table= true
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"]

  #create_database_nat_gateway_route = true
  #create_database_internet_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true  # in our case, we just want to save money by using single NAT Gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    Owner = "kalyan"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
  # Instances launched into the Public subnet should be assigned a public IP address.
  map_public_ip_on_launch = true
}



