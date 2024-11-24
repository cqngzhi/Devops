# VPC
resource "aws_vpc" "s_platform_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "s_platform_vpc"
  }
}

# Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.s_platform_vpc.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "s_platform_public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.s_platform_vpc.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "s_platform_public_subnet_2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "s_platform_igw" {
  vpc_id = aws_vpc.s_platform_vpc.id

  tags = {
    Name = "s_platform_igw"
  }
}

# Route Table
resource "aws_route_table" "s_platform_route_table" {
  vpc_id = aws_vpc.s_platform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.s_platform_igw.id
  }

  tags = {
    Name = "s_platform_route_table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "s_platform_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.s_platform_route_table.id
}

resource "aws_route_table_association" "s_platform_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.s_platform_route_table.id
}

# Security Group
resource "aws_security_group" "s_platform_sg" {
  vpc_id = aws_vpc.s_platform_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.10/32"]  # Bastion Host  IP 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "s_platform_security_group"
  }
}
# Nodes Security Group
resource "aws_security_group" "nodes_sg" {
  vpc_id = aws_vpc.s_platform_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.10/32"] #
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nodes_security_group"
  }
}
