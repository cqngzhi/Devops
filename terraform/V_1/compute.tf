# Genereer een privé-sleutel met TLS
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Genereer een AWS sleutel-paar (SSH sleutel) op basis van de privé-sleutel
resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Maak de map aan (als deze niet bestaat)
resource "null_resource" "create_ssh_key_directory" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.ssh_key_directory}"  
  }
}

# Sla de privé-sleutel lokaal op als een bestand
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/generated_key.pem"
  file_permission = "0400"
}

# Maak een EC2-instantie aan in AWS
resource "aws_instance" "openvpn" {
  count                       = var.counter
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.security.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id

  tags = {
    Name = "openvpn"
  }
}

# Wijs een Elastic IP toe aan de EC2-instantie
resource "aws_eip" "openvpn_ip" {
  count    = var.counter
  instance = aws_instance.openvpn[count.index].id
}
