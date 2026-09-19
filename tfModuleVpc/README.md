# Terraform Modules
This is a simple Terraform module for creating a VPC in AWS.

# How to use this terraform module
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
}
```
```bash
tf init
tf plan
tf apply
```

# Module Inputs
- vpc_name - (Optional) Name of the VPC. Default is "my-vpc".
- vpc_cidr - (Optional) CIDR block for the VPC. Default is "10.0.0.0/16".
- azs - (Required) List of availability zones.
- private_subnets - (Required) List of private subnets.
- public_subnets - (Required) List of public subnets.