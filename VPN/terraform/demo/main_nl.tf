# Geef de vereiste Terraform versie op
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

# Configureer de AWS provider
provider "aws" {
  region     = "us-east-1"  # Wijzig de regio indien nodig
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

# Definieer variabelen
variable "aws_access_key" {
  description = "AWS toegangssleutel"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS geheime sleutel"
  type        = string
  sensitive   = true
}

variable "aws_session_token" {
  description = "AWS sessie token"
  type        = string
  sensitive   = true
}

variable "counter" {
  default     = 1
  description = "Aantal te maken instanties"
}

# Maak een SSH-sleutelpaar en sla de privésleutel lokaal op
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Sla de privésleutel op in een lokaal bestand
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/generated_key.pem"
  file_permission = "0400"  # Zorg ervoor dat het bestand alleen door de eigenaar gelezen kan worden
}

# Maak een VPC, stel de naam in en schakel DNS-hostnamen en DNS-ondersteuning in
resource "aws_vpc" "dev_openvpn" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev_openvpn"
  }
}

# Maak een internet-gateway voor externe toegang
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_openvpn.id

  tags = {
    Name = "dev_openvpn_igw"
  }
}

# Maak een route tabel en voeg een standaard route toe
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

# Koppel de route tabel aan het subnet
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

# Maak een subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.dev_openvpn.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Definieer een beveiligingsgroep die SSH- en OpenVPN-poorten toestaat
resource "aws_security_group" "security" {
  name_prefix = "openvpn_security_group"

  ingress {
    description = "Sta SSH toe"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Sta OpenVPN toe"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Maak één of meerdere EC2-instanties
resource "aws_instance" "openvpn" {
  count                       = var.counter
  ami                         = "ami-0e86e20dae9224db8"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.security.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id

  tags = {
    Name = "openvpn"
  }
}

# Wijs een Elastic IP-adres toe aan elke instantie
resource "aws_eip" "openvpn_ip" {
  count    = var.counter
  instance = aws_instance.openvpn[count.index].id
}

# Toon de publieke IP-adressen van de instanties en het pad naar de privésleutel
output "instance_public_ips" {
  value       = [for ip in aws_eip.openvpn_ip : ip.public_ip]
  description = "De publieke IP-adressen van de OpenVPN EC2-instanties."
}

output "private_key_path" {
  value       = local_file.private_key.filename
  description = "Pad naar de lokaal opgeslagen privésleutel."
}
