
/**
EC2 Instance (with dynamic values)

now are 
1. referencing the variables defined in the c2-variables.tf file
2. referencing other resources using attributes
3. referencing data source 
*/
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id   # ! referencing the data source
  instance_type = var.instance_type # ! referencing the variable
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id   ] # ! referencing other resources using attributes
  tags = {
    "Name" = "EC2 Demo 2"
  }
}
