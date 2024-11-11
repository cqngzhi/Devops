output "instance_public_ips" {
  value       = [for ip in aws_eip.openvpn_ip : ip.public_ip]
  description = "Public IP addresses of OpenVPN EC2 instances."
}

output "private_key_path" {
  value       = local_file.private_key.filename
  description = "Path to the locally stored private key."
}

output "cloudflare_zone_id" {
  value       = cloudflare_zone.example_zone.id
  description = "The Cloudflare zone ID for the domain."
}

output "openvpn_dns_record" {
  value       = cloudflare_record.openvpn_dns.hostname
  description = "The DNS record for the OpenVPN instance."
}
