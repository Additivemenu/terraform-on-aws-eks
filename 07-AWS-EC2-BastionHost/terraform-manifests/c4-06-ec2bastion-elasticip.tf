# Create Elastic IP for Bastion Host https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_public, module.vpc ] # ! meta argument to create resource after other resources are created
  instance = module.ec2_public.id
  vpc      = true
  tags = local.common_tags  
}
