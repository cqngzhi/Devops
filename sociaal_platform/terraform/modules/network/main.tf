# VPC-creatie
resource "aws_vpc" "s_platform_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "s_platform_vpc"
  }
}

# Creatie van een openbaar subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.s_platform_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "s_platform_public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.s_platform_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
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

# routeringstabel
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

# Routetabellen die zijn gekoppeld aan subnetten
resource "aws_route_table_association" "s_platform_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.s_platform_route_table.id
}

resource "aws_route_table_association" "s_platform_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.s_platform_route_table.id
}

# Beveiligingsgroep (staat SSH-, HTTP- en HTTPS-toegang toe)
resource "aws_security_group" "s_platform_sg" {
  vpc_id = aws_vpc.s_platform_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

# Netwerkinformatie uitvoeren
output "vpc_id" {
  value = aws_vpc.s_platform_vpc.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "security_group_id" {
  value = aws_security_group.s_platform_sg.id
}
