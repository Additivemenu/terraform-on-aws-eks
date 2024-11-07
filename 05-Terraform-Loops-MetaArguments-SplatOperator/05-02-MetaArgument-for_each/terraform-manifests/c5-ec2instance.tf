# Availability Zones Datasource https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones.html
# e.g. below will return all the Availability Zones in a region
# if region = "ap-southeast-2" then it will return ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


# EC2 Instance: create a EC2 instance at each AZ in a VPC
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id   ]
  # ! Create EC2 Instance in all Availabilty Zones of a VPC  
  for_each = toset(data.aws_availability_zones.my_azones.names)
  availability_zone = each.key  # ! You can also use each.value here because for list items each.key == each.value
  tags = {
    "Name" = "for_each-Demo-${each.value}"
  }
}
