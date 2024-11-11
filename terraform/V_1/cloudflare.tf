# Cloudflare zone
resource "cloudflare_zone" "example_zone" {
  zone = "example.com"  # Uw domeinnaam
}

# Cloudflare DNS record
resource "cloudflare_record" "openvpn_dns" {
  zone_id = cloudflare_zone.example_zone.id
  name    = "openvpn"
  type    = "A"
  value   = aws_eip.openvpn_ip[0].public_ip  # Het publieke IP van de eerste EC2 instantie (Elastic IP)
  ttl     = 3600
  proxied = true  # Als u Cloudflare's proxy-functionaliteit wilt gebruiken, zet dit op true
}
