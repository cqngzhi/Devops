# Elastic IP
resource "aws_eip" "s_platform_ip" {
  count = 1
  vpc   = true
}

# Master knooppunt
resource "aws_instance" "master" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  private_ip        = "10.0.1.10"
  key_name          = var.key_name
  security_groups   = [var.security_group_id]
  associate_public_ip_address = false # Maak gebruik van een intranetverbinding

  tags = {
    Name = "K8s-Master"
  }
}

# Elastic IP binden aan Master knooppunt
resource "aws_eip_association" "s_platform_eip" {
  instance_id   = aws_instance.master.id
  allocation_id = aws_eip.s_platform_ip[0].id
}

# Node1 knooppunt
resource "aws_instance" "node1" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  private_ip        = "10.0.1.11"
  key_name          = var.key_name
  security_groups   = [var.security_group_id]
  associate_public_ip_address = false

  tags = {
    Name = "K8s-Node1"
  }
}

# Node2 knooppunt
resource "aws_instance" "node2" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  private_ip        = "10.0.1.12"
  key_name          = var.key_name
  security_groups   = [var.security_group_id]
  associate_public_ip_address = false

  tags = {
    Name = "K8s-Node2"
  }
}

# Node3 knooppunt
resource "aws_instance" "node3" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  private_ip        = "10.0.1.13"
  key_name          = var.key_name
  security_groups   = [var.security_group_id]
  associate_public_ip_address = false

  tags = {
    Name = "K8s-Node3"
  }
}
