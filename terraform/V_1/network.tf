resource "aws_vpc" "dev_openvpn" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev_openvpn"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_openvpn.id

  tags = {
    Name = "dev_openvpn_igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.dev_openvpn.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "dev_openvpn_route_table"
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.dev_openvpn.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}
