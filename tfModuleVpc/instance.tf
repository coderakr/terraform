module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.1"

  name = "my-test-instance"

  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name        = "module-ec2-instance"
    Environment = "dev"
  }
}
