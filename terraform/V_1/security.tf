# Definieer een beveiligingsgroep voor OpenVPN en andere toegestane poorten
resource "aws_security_group" "security" {
  name_prefix = "openvpn_security_group"

  # Toegestaan inkomend verkeer voor SSH (poort 22)
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Toegestaan inkomend verkeer voor OpenVPN (poort 1194)
  ingress {
    description = "Allow OpenVPN"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # Toegestaan inkomend verkeer voor HTTP (poort 80)
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Toegestaan inkomend verkeer voor HTTPS (poort 443)
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # Toegestaan inkomend verkeer voor Portainer CE (poort 9443)
  ingress {
    description = "Allow custom port 9443"
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # Toegestaan uitgaand verkeer naar alle bestemmingen (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
