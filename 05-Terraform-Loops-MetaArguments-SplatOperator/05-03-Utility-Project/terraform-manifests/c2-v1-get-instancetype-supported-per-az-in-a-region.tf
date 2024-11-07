# Datasource
data "aws_ec2_instance_type_offerings" "my_ins_type1" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    # values = ["us-east-1a"]
    values = ["ap-southeast-2a"]
  }
  location_type = "availability-zone"
}


# Output: this basically prints the output of the data source, handy for debug
output "output_v1_1" {
  value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
}

