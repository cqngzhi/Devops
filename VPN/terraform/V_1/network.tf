# Maak een VPC (Virtual Private Cloud) voor OpenVPN
resource "aws_vpc" "dev_openvpn" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev_openvpn"
  }
}

# Maak een internet-gateway voor de VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_openvpn.id

  tags = {
    Name = "dev_openvpn_igw"
  }
}

# Maak een route tabel aan voor de VPC
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

# Koppel de route tabel aan een subnet
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

# Maak een subnet in de VPC
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.dev_openvpn.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}
