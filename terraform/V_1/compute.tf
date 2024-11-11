resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/generated_key.pem"
  file_permission = "0400"
}

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

resource "aws_eip" "openvpn_ip" {
  count    = var.counter
  instance = aws_instance.openvpn[count.index].id
}
