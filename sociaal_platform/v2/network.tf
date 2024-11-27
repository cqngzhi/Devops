# VPC
resource "aws_vpc" "k8s" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "k8s_vpc"
  }
}

# Subnets
resource "aws_subnet" "k8s_sub" {
  vpc_id                  = aws_vpc.k8s.id 
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "k8s_public"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = aws_vpc.k8s.id

  tags = {
    Name = "k8s_igw"
  }
}

# Route Table
resource "aws_route_table" "k8s_rt" {
  vpc_id = aws_vpc.k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_igw.id
  }

  tags = {
    Name = "k8s_rt"
  }
}

# Route Table Associations
resource "aws_route_table_association" "k8s_association" {
  subnet_id      = aws_subnet.k8s_sub.id
  route_table_id = aws_route_table.k8s_rt.id
}

