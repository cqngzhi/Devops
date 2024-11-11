output "instance_public_ips" {
  value       = [for ip in aws_eip.openvpn_ip : ip.public_ip]
  description = "Public IP addresses of OpenVPN EC2 instances."
}

output "private_key_path" {
  value       = local_file.private_key.filename
  description = "Path to the locally stored private key."
}
