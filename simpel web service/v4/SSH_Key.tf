# SSH Key Pair
resource "aws_key_pair" "k8s_key" {
  key_name   = "k8s-key"
  public_key = file("./SSH/id_rsa.pub")
}

