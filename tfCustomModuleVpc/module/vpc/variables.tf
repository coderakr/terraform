variable "vpc_config" {
  description = "Configuration for the VPC module"

  type = object({
    name       = string
    cidr_block = string
  })

  validation {
    condition     = can(cidrhost(var.vpc_config.cidr_block, 0))
    error_message = "Invalid CIDR block for VPC. Please provide a valid CIDR block."
  }
}

variable "subnet_config" {
  description = "Configuration for the Subnet module"

  type = map(object({
    az         = string
    cidr_block = string
    public     = optional(bool, false)
  }))

  validation {
    condition = alltrue([
      for subnet in values(var.subnet_config) :
      can(cidrhost(subnet.cidr_block, 0))
    ])

    error_message = "Invalid CIDR block for Subnet. Please provide valid CIDR blocks for all subnets."
  }
}

# Routing Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_config.name}-rt"
  }
}
