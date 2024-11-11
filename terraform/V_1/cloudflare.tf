# Cloudflare DNS record
resource "cloudflare_record" "openvpn_dns" {
  zone_id = "cb06796a450b34dd4cb1d2b307706ecd"
  name    = "openvpn"
  type    = "A"
  content = aws_eip.openvpn_ip[0].public_ip  # Het publieke IP van de eerste EC2 instantie (Elastic IP)
  ttl     = 1
  proxied = true  # Als u Cloudflare's proxy-functionaliteit wilt gebruiken, zet dit op true
}
