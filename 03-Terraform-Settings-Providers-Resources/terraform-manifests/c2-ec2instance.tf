# Resource: EC2 Instance
# see full reference at https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference
resource "aws_instance" "myec2vm" {
  ami = "ami-0f71013b2c8bd2c29" # ! Amazon Linux in ap-southeast-2, update as per your region
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh") # script to run on instance launch
  tags = {
    "Name" = "EC2 Demo"
  }
}