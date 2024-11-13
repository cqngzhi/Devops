# Cloudflare DNS record
resource "cloudflare_record" "openvpn_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "openvpn"
  type    = "A"
  content = aws_eip.openvpn_ip[0].public_ip  # Het publieke IP van de eerste EC2 instantie (Elastic IP)
  ttl     = 1
  proxied = true  # Als u Cloudflare's proxy-functionaliteit wilt gebruiken, zet dit op true
}

# Creëer een Cloudflare-tunnel
resource "cloudflare_tunnel" "openvpn_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "openvpn-tunnel"
}

# Configureer DNS-records zodat ze naar Cloudflare Tunnel verwijzen
resource "cloudflare_record" "openvpn_dns_tunnel" {
  zone_id = var.cloudflare_zone_id  
  name    = "openvpn"
  type    = "CNAME"
  content = cloudflare_tunnel.openvpn_tunnel.cname
  proxied = true
}
