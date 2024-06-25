# ----------------------------------------------------------------
# Public Subnet
# ----------------------------------------------------------------

resource "aws_subnet" "public_subnet" {
  for_each          = toset(data.aws_availability_zones.available.names)
  availability_zone = each.value

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, index(data.aws_availability_zones.available.names, each.value) + 101)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-public-subnet-${index(data.aws_availability_zones.available.names, each.value) + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_default_route_table" "public_rtb" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-public-rtb"
  }
}

resource "aws_route_table_association" "public_rtb_a" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  #route_table_id = aws_route_table.public_rtb.id
  route_table_id = aws_default_route_table.public_rtb.id
}

# ----------------------------------------------------------------
# Private Subnet
# ----------------------------------------------------------------

resource "aws_subnet" "private_subnet" {
  for_each          = toset(data.aws_availability_zones.available.names)
  availability_zone = each.value

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, index(data.aws_availability_zones.available.names, each.value) + 1)

  tags = {
    Name = "${var.prefix}-private-subnet-${index(data.aws_availability_zones.available.names, each.value) + 1}"
  }
}

# Comment out if public nat is not required
resource "aws_eip" "nat_eip" {
  domain           = "vpc"
  public_ipv4_pool = "amazon"
  for_each         = aws_subnet.private_subnet
  tags = {
    Name = "${var.prefix}-nat-eip-${each.value.id}"
  }
}

resource "aws_nat_gateway" "nat" {
  for_each          = aws_subnet.public_subnet
  subnet_id         = each.value.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_eip[each.key].id
  tags = {
    Name = "${var.prefix}-public-nat-${each.value.id}"
  }
}

/*
# Nat Gateway without EIP (private nat)
resource "aws_nat_gateway" "nat" {
  for_each          = aws_subnet.public_subnet
  subnet_id         = each.value.id
  connectivity_type = "private"
  tags = {
    Name = "${var.prefix}-nat-${each.value.id}"
  }
}
*/

resource "aws_route_table" "private_rtb" {
  for_each = aws_subnet.private_subnet
  vpc_id   = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }

  tags = {
    Name = "${var.prefix}-private-rtb-${each.value.id}"
  }
}

resource "aws_route_table_association" "private_rtb_a" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rtb[each.key].id
}
