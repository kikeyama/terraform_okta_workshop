# ----------------------------------------------------------------
# Security Groups
# ----------------------------------------------------------------

resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-default-sg"
  }
}

resource "aws_security_group" "public_base_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.prefix}-public-base-sg"
  description = "Public Base Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.home_cidr}"]
    description = "SSH from Home CIDR"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-public-base-sg"
  }
}

resource "aws_security_group" "private_base_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.prefix}-private-base-sg"
  description = "Private Base Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = true
    description = "SSH from This Security Group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-private-base-sg"
  }
}

resource "aws_security_group" "public_windows_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.prefix}-public-windows-sg"
  description = "Public Windows Security Group"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.home_cidr}"]
    description = "RDP from Home CIDR"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-public-windows-base-sg"
  }
}

resource "aws_security_group" "public_nodejs_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.prefix}-public-nodejs-sg"
  description = "Public Node.js Security Group"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${var.home_cidr}"]
    description = "Node.js HTTP from Home CIDR"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-public-nodejs-base-sg"
  }
}
