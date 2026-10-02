provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./module/vpc"

  vpc_config = {
    name       = "my-vpc"
    cidr_block = "10.0.0.0/16"
  }

  subnet_config = {
    public_subnet = {
      az         = "ap-south-1a"
      cidr_block = "10.0.0.0/24"
      public     = false
    }

    private_subnet = {
      az         = "ap-south-1b"
      cidr_block = "10.0.1.0/24"
    }
  }
}
