# Get latest AMI ID for Amazon Linux2 OS
# here, data source allows you to fetch the information external to the terraform configuration
data "aws_ami" "amzlinux2" {
  most_recent      = true
  owners           = ["amazon"]

  # you can find the filters from the AWS Console AMI catalog
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}