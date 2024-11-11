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

# Toon de Cloudflare zone ID voor het domein
output "cloudflare_zone_id" {
  value       = "cb06796a450b34dd4cb1d2b307706ecd"
  description = "The Cloudflare zone ID for the domain."
}

# Toon het DNS-record voor de OpenVPN-instantie
output "openvpn_dns_record" {
  value       = cloudflare_record.openvpn_dns.hostname
  description = "The DNS record for the OpenVPN instance."
}
