# Toon de publieke IP-adressen van de OpenVPN EC2-instanties
output "instance_public_ips" {
  value       = [for ip in aws_eip.openvpn_ip : ip.public_ip]
  description = "Public IP addresses of OpenVPN EC2 instances."
}

# Toon het pad naar de lokaal opgeslagen privésleutel
output "private_key_path" {
  value       = local_file.private_key.filename
  description = "Path to the locally stored private key."
}

# Haal de AMI-ID van de instantie op
output "ami_name" {
  value = value = aws_instance.openvpn[count.index].ami
}

# Toon de Cloudflare zone ID voor het domein
output "cloudflare_zone_id" {
  value       = var.cloudflare_zone_id
  description = "The Cloudflare zone ID for the domain."
}

# Toon het DNS-record voor de OpenVPN-instantie
output "openvpn_dns_record" {
  value       = cloudflare_record.openvpn_dns.hostname
  description = "The DNS record for the OpenVPN instance."
}

# Voer het token uit voor later gebruik
output "cloudflare_tunnel_token" {
  value = cloudflare_tunnel.openvpn_tunnel.token  
  sensitive = true  
}
