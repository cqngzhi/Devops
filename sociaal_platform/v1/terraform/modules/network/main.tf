# Creëert een VPC
resource "aws_vpc" "s_platform_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "s_platform_vpc"
  }
}

# Creëert private subnets
resource "aws_subnet" "private" {
  count = 1  # Aantal private subnets
  cidr_block        = var.private_subnets  # CIDR voor elk subnet
  vpc_id            = aws_vpc.s_platform_vpc.id  # Verwijst naar de VPC
  availability_zone = var.availability_zones  # Beschikbare zone voor het subnet
  tags = {
    Name = "private-subnet"  # Naam van het subnet
  }
}

# Creëert een beveiligingsgroep
# Platform Security Group - Beveiliging voor het platform
resource "aws_security_group" "s_platform_sg" {
  vpc_id = aws_vpc.s_platform_vpc.id  # Verwijst naar de VPC voor de beveiligingsgroep
  # Inkomende regels (ingress) voor HTTP-toegang binnen de Kubernetes cluster
  ingress {
    from_port   = 80  # HTTP toegang via poort 80
    to_port     = 80  # Toegang via poort 80 voor interne HTTP-verkeer
    protocol    = "tcp"  # TCP protocol
    cidr_blocks = ["10.0.0.0/16"]  # Alleen toegestaan binnen de VPC netwerk
  }

  # Inkomende regels (ingress) voor HTTPS-toegang binnen de Kubernetes cluster
  ingress {
    from_port   = 443  # HTTPS toegang via poort 443
    to_port     = 443  # Toegang via poort 443 voor interne HTTPS-verkeer
    protocol    = "tcp"  # TCP protocol
    cidr_blocks = ["10.0.0.0/16"]  # Alleen toegestaan binnen de VPC netwerk
  }
  ingress {
    from_port   = 22  # Toegang via poort 22 voor SSH
    to_port     = 22  # Toegang via poort 22 voor SSH
    protocol    = "tcp"  # TCP protocol
    cidr_blocks = ["0.0.0.0/0"]  # Toegestaan van overal
  }

  ingress {
    from_port   = 80  # Toegang via poort 80 voor HTTP
    to_port     = 80  # Toegang via poort 80 voor HTTP
    protocol    = "tcp"  # TCP protocol
    cidr_blocks = ["0.0.0.0/0"]  # Toegestaan van overal
  }

  ingress {
    from_port   = 443  # Toegang via poort 443 voor HTTPS
    to_port     = 443  # Toegang via poort 443 voor HTTPS
    protocol    = "tcp"  # TCP protocol
    cidr_blocks = ["0.0.0.0/0"]  # Toegestaan van overal
  }

  egress {
    from_port   = 0  # Alle uitgaande poorten
    to_port     = 0  # Alle uitgaande poorten
    protocol    = "-1"  # Alle protocollen
    cidr_blocks = ["0.0.0.0/0"]  # Toegestaan van overal
  }

  tags = {
    Name = "s_platform_security_group"
  }
}

