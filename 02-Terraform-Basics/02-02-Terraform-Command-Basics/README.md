# Terraform Command Basics

## Step-01: Introduction :white_check_mark:

- Understand basic Terraform Workflow Commands
  - `terraform init`
    - Used to Initialize a working directory containing terraform config files
    - This is the first command that should be run after writing a new Terraform configuration
    - Downloads <u>Providers</u>
  - `terraform validate`
    - Validates the terraform configurations files in that respective directory to ensure they are <u>syntactically valid and internally consistent</u>.
  - `terraform plan` :white_check_mark:
    - Creates an execution plan
    - Terraform performs a refresh and determines what actions are necessary to achieve the desired state specified in configuration files
  - `terraform apply` :white_check_mark:
    - Used to apply the changes required to reach the desired state of the configuration.
    - By default, apply scans the current directory for the configuration and applies the changes appropriately.
  - `terraform destroy`
    - Used to destroy the Terraform-managed infrastructure
    - This will ask for confirmation before destroying.

## Step-02: Review terraform manifest for EC2 Instance

- **Pre-Conditions-1:** Ensure you have **default-vpc** in that respective region
- **Pre-Conditions-2:** Ensure AMI you are provisioning exists in that region if not update AMI ID
- **Pre-Conditions-3:** Verify your AWS Credentials in **$HOME/.aws/credentials**
  - and make sure the AWS profile that you are going to use has sufficient IAM access (just use an admin user)

then check below manifest file:

```t
# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-04d29b6f966df1537" # Amazon Linux in us-east-1, update as per your region
  instance_type = "t2.micro"
}
```

## Step-03: Terraform Core Commands

```t
# Initialize Terraform
terraform init

# Terraform Validate
terraform validate

# Terraform Plan to Verify what it is going to create / update / destroy
terraform plan

# Terraform Apply to Create EC2 Instance
terraform apply
```

and you do see a folder `.terraform` being created once you run `terraform init`:

<details>
  <summary>terraform init</summary>

```t
(base) ➜  terraform-manifests git:(main) ✗ terraform init
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.74.0...
- Installed hashicorp/aws v5.74.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

</details>

<details>
  <summary>terraform validate</summary>

```shell
(base) ➜  terraform-manifests git:(main) ✗ terraform validate
Success! The configuration is valid.
```

</details>

<details>
  <summary>terraform plan</summary>

```shell
(base) ➜  terraform-manifests git:(main) ✗ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.ec2demo will be created
  + resource "aws_instance" "ec2demo" {
      + ami                                  = "ami-0f71013b2c8bd2c29"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

```

</details>

<details>
  <summary>terraform apply</summary>

just make sure your AWS profile to be used has sufficient IAM access, then run `terraform apply`

- and you do see a EC2 instance running in your AWS console

```shell
(base) ➜  terraform-manifests git:(main) ✗ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:

- create

Terraform will perform the following actions:

# aws_instance.ec2demo will be created

- resource "aws_instance" "ec2demo" {

  - ami = "ami-0f71013b2c8bd2c29"
  - arn = (known after apply)
  - associate_public_ip_address = (known after apply)
  - availability_zone = (known after apply)
  - cpu_core_count = (known after apply)
  - cpu_threads_per_core = (known after apply)
  - disable_api_stop = (known after apply)
  - disable_api_termination = (known after apply)
  - ebs_optimized = (known after apply)
  - get_password_data = false
  - host_id = (known after apply)
  - host_resource_group_arn = (known after apply)
  - iam_instance_profile = (known after apply)
  - id = (known after apply)
  - instance_initiated_shutdown_behavior = (known after apply)
  - instance_lifecycle = (known after apply)
  - instance_state = (known after apply)
  - instance_type = "t2.micro"
  - ipv6_address_count = (known after apply)
  - ipv6_addresses = (known after apply)
  - key_name = (known after apply)
  - monitoring = (known after apply)
  - outpost_arn = (known after apply)
  - password_data = (known after apply)
  - placement_group = (known after apply)
  - placement_partition_number = (known after apply)
  - primary_network_interface_id = (known after apply)
  - private_dns = (known after apply)
  - private_ip = (known after apply)
  - public_dns = (known after apply)
  - public_ip = (known after apply)
  - secondary_private_ips = (known after apply)
  - security_groups = (known after apply)
  - source_dest_check = true
  - spot_instance_request_id = (known after apply)
  - subnet_id = (known after apply)
  - tags_all = (known after apply)
  - tenancy = (known after apply)
  - user_data = (known after apply)
  - user_data_base64 = (known after apply)
  - user_data_replace_on_change = false
  - vpc_security_group_ids = (known after apply)

  - capacity_reservation_specification (known after apply)

  - cpu_options (known after apply)

  - ebs_block_device (known after apply)

  - enclave_options (known after apply)

  - ephemeral_block_device (known after apply)

  - instance_market_options (known after apply)

  - maintenance_options (known after apply)

  - metadata_options (known after apply)

  - network_interface (known after apply)

  - private_dns_name_options (known after apply)

  - root_block_device (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.

Enter a value: yes

aws_instance.ec2demo: Creating...
aws_instance.ec2demo: Still creating... [10s elapsed]
aws_instance.ec2demo: Creation complete after 12s [id=i-010e097fa648a064b]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

</details>

## Step-04: Verify the EC2 Instance in AWS Management Console

- Go to AWS Management Console -> Services -> EC2
- Verify newly created EC2 instance

## Step-05: Destroy Infrastructure

```t
# Destroy EC2 Instance
terraform destroy

# Delete Terraform files
rm -rf .terraform*
rm -rf terraform.tfstate*
```

:::terraform destroy

```bash
(base) ➜  terraform-manifests git:(main) ✗ terraform destroy
aws_instance.ec2demo: Refreshing state... [id=i-010e097fa648a064b]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.ec2demo will be destroyed
  - resource "aws_instance" "ec2demo" {
      - ami                                  = "ami-0f71013b2c8bd2c29" -> null
      - arn                                  = "arn:aws:ec2:ap-southeast-2:640055235180:instance/i-010e097fa648a064b" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "ap-southeast-2b" -> null
      - cpu_core_count                       = 1 -> null
      - cpu_threads_per_core                 = 1 -> null
      - disable_api_stop                     = false -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-010e097fa648a064b" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "t2.micro" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - monitoring                           = false -> null
      - placement_partition_number           = 0 -> null
      - primary_network_interface_id         = "eni-07b194ea8db388c5f" -> null
      - private_dns                          = "ip-172-31-2-236.ap-southeast-2.compute.internal" -> null
      - private_ip                           = "172.31.2.236" -> null
      - public_dns                           = "ec2-52-65-129-1.ap-southeast-2.compute.amazonaws.com" -> null
      - public_ip                            = "52.65.129.1" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [
          - "default",
        ] -> null
      - source_dest_check                    = true -> null
      - subnet_id                            = "subnet-03911ac7f0a61f20b" -> null
      - tags                                 = {} -> null
      - tags_all                             = {} -> null
      - tenancy                              = "default" -> null
      - user_data_replace_on_change          = false -> null
      - vpc_security_group_ids               = [
          - "sg-02fff1522945618ab",
        ] -> null
        # (8 unchanged attributes hidden)

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - cpu_options {
          - core_count       = 1 -> null
          - threads_per_core = 1 -> null
            # (1 unchanged attribute hidden)
        }

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 2 -> null
          - http_tokens                 = "required" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/xvda" -> null
          - encrypted             = false -> null
          - iops                  = 3000 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 125 -> null
          - volume_id             = "vol-0373d3c3d40b977cb" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp3" -> null
            # (1 unchanged attribute hidden)
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.ec2demo: Destroying... [id=i-010e097fa648a064b]
aws_instance.ec2demo: Still destroying... [id=i-010e097fa648a064b, 10s elapsed]
aws_instance.ec2demo: Still destroying... [id=i-010e097fa648a064b, 20s elapsed]
aws_instance.ec2demo: Still destroying... [id=i-010e097fa648a064b, 30s elapsed]
aws_instance.ec2demo: Still destroying... [id=i-010e097fa648a064b, 40s elapsed]
aws_instance.ec2demo: Still destroying... [id=i-010e097fa648a064b, 50s elapsed]
aws_instance.ec2demo: Still destroying... [id=i-010e097fa648a064b, 1m0s elapsed]
aws_instance.ec2demo: Destruction complete after 1m0s

Destroy complete! Resources: 1 destroyed.

```
:::

## Step-08: Conclusion

- Re-iterate what we have learned in this section
- Learned about Important Terraform Commands
  - terraform init
  - terraform validate
  - terraform plan
  - terraform apply
  - terraform destroy
