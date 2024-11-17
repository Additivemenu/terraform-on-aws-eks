# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws" # ! we are using TF Registry module https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
  #version = "~> 3.0"
  #version = "3.3.0"
  version = "5.0.0"  

  name = "${local.name}-BastionHost"
  ami                    = data.aws_ami.amzlinux2.id # ! get dynamically from data source
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0] # reference to VPC module output https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id] # reference to security group module output https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest?tab=outputs
  
  tags = local.common_tags
}