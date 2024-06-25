# ----------------------------------------------------------------
# VPC
# ----------------------------------------------------------------

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  #main_route_table_id  = aws_route_table.public_rtb

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
