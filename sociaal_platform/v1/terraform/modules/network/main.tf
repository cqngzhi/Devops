# Creëert een VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr  # CIDR-blok voor de VPC en publieke subnetten
  tags = {
    Name = "main-vpc"  # Naam van de VPC
  }
}

# Creëert publieke subnets
resource "aws_subnet" "public" {
  count = length([var.vpc_cidr])  # Aantal publieke subnets
  cidr_block              = "10.0.0.0/16"  # CIDR voor het publieke subnet
  vpc_id                  = aws_vpc.main.id  # Verwijst naar de VPC
  availability_zone       = var.availability_zones[count.index]  # Beschikbare zone voor het subnet
  map_public_ip_on_launch = true  # Zorg ervoor dat de instances een publiek IP krijgen
  tags = {
    Name = "public-subnet-${count.index}"  # Naam van het subnet
  }
}

# Creëert private subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)  # Aantal private subnets
  cidr_block        = var.private_subnets[count.index]  # CIDR voor elk subnet
  vpc_id            = aws_vpc.main.id  # Verwijst naar de VPC
  availability_zone = var.availability_zones[count.index]  # Beschikbare zone voor het subnet
  tags = {
    Name = "private-subnet-${count.index}"  # Naam van het subnet
  }
}

# Creëert een beveiligingsgroep
resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id  # Verwijst naar de VPC voor de beveiligingsgroep
  ingress {
    from_port   = 22  # SSH toegang via poort 22
    to_port     = 22  # Toegang via poort 22
    protocol    = "tcp"  # TCP protocol
    cidr_blocks = ["0.0.0.0/0"]  # Toegestaan van overal
  }
  egress {
    from_port   = 0  # Alle uitgaande poorten
    to_port     = 0  # Alle uitgaande poorten
    protocol    = "-1"  # Alle protocollen
    cidr_blocks = ["0.0.0.0/0"]  # Toegestaan van overal
  }
}
