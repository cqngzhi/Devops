# Cloudflare DNS
resource "cloudflare_record" "web_app_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "A"
  content = aws_instance.k8s_master.public_ip
  proxied = true
}