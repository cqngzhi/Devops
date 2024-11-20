# Cloudflare DNS record
resource "cloudflare_record" "openvpn_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "openvpn"
  type    = "A"
  content = aws_eip.openvpn_ip[0].public_ip  # Het publieke IP van de eerste EC2 instantie (Elastic IP)
  ttl     = 1
  proxied = true  # Als u Cloudflare's proxy-functionaliteit wilt gebruiken, zet dit op true
}
