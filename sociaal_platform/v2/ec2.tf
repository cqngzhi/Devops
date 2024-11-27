# Elastic IP
resource "aws_eip" "public_eip" {
  count = 1
  domain = "vpc"
  tags = {
    Name = "public_eip"
  }
}

# Bind EIP aan de masterinstantie
resource "aws_eip_association" "public_eip_association" {
  instance_id = aws_instance.master.id
  allocation_id = aws_eip.public_eip[0].id  # Let op het gebruik van index hier om naar het eerste EIP te verwijzen
}


# uplosd key
resource "aws_key_pair" "ansible_social_platform" {
  key_name   = "ansible_social_platform"  #
  public_key = file("./SSH/id_rsa.pub")  # key location
}

# Master knooppunt
resource "aws_instance" "master" {
  ami               = "ami-0e86e20dae9224db8"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.k8s_sub.id
  private_ip        = "10.0.1.10"
  key_name          = var.key_name
  security_groups   = [aws_security_group.master_sg.id]
 
  tags = {
    Name = "K8s-Master"
  }
}

# Elastic IP binden aan Master knooppunt
resource "aws_eip_association" "public_eip" {
  instance_id   = aws_instance.master.id
  allocation_id = aws_eip.public_eip[0].id
}

# Node1 knooppunt
resource "aws_instance" "node1" {
  ami               = "ami-0e86e20dae9224db8"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.k8s_sub.id
  private_ip        = "10.0.1.11"
  key_name          = var.key_name
  security_groups   = [aws_security_group.nodes_sg.id]
  associate_public_ip_address = false
  tags = {
    Name = "K8s-Node1"
  }
}

# Node2 knooppunt
resource "aws_instance" "node2" {
  ami               = "ami-0e86e20dae9224db8"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.k8s_sub.id
  private_ip        = "10.0.1.12"
  key_name          = var.key_name
  security_groups   = [aws_security_group.nodes_sg.id]
  associate_public_ip_address = false
  tags = {
    Name = "K8s-Node2"
  }
}

# Node3 knooppunt
resource "aws_instance" "node3" {
  ami               = "ami-0e86e20dae9224db8"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.k8s_sub.id
  private_ip        = "10.0.1.13"
  key_name          = var.key_name
  security_groups   = [aws_security_group.nodes_sg.id]
  associate_public_ip_address = false
  tags = {
    Name = "K8s-Node3"
  }
}
