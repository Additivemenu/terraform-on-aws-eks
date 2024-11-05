# hotkey: ctrl + space to see the available block options

# ! Terraform Block
terraform {
  #required_version = "~> 0.14" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_version = ">= 1.6.0" 
  # ! below is just provider requirement, it is a block within a block
  required_providers {
    # below is argument, you need to use "="
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = ">= 5.31"
    }
  } 
}  


# ! Provider Block (configure the provider). The label name here needs to match that in the required_providers block
provider "aws" {
  region = "ap-southeast-2"
  profile = "default" # optional
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

