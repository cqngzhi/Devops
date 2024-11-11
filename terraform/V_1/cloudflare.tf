# Cloudflare zone
resource "cloudflare_zone" "example_zone" {
  zone = "example.com"  # 您的域名
}

# Cloudflare DNS记录
resource "cloudflare_record" "openvpn_dns" {
  zone_id = cloudflare_zone.example_zone.id
  name    = "openvpn"
  type    = "A"
  value   = aws_eip.openvpn_ip[0].public_ip  # 使用第一台实例的弹性IP
  ttl     = 3600
  proxied = false  # 如果想使用Cloudflare代理功能可设为true
}
