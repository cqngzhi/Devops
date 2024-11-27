
variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "ansible_social_platform"
}

variable "ssh_key_path" {
  description = "Path to the SSH private key file"
  default     = "./SSH/id_rsa.pub"
}

output "public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = aws_instance.master.*.public_ip
}

output "private_ips" {
  description = "Private IPs of the EC2 instances"
  value       = aws_instance.master.*.private_ip
}

output "instance_ids" {
  description = "Instance IDs of the EC2 instances"
  value       = aws_instance.master.*.id
}
# Variabele voor de AWS toegangssleutel
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

# Variabele voor de AWS geheime sleutel
variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

# Variabele voor het AWS sessie-token
variable "aws_session_token" {
  description = "AWS session token"
  type        = string
  sensitive   = true
}
variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

# Variabele voor de Cloudflare API-token
variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

# Variabele voor de Cloudflare account ID
variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
  sensitive   = true
}

# Variabele voor de Cloudflare Zone-ID
variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
  sensitive   = true
}