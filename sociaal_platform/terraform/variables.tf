variable "ami" {
  description = "Amazon Machine Image ID"
  type        = string
  default     = "ami-0e86e20dae9224db8" # default AMI ID
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro" # default instance_type
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "ansible_social_platform_key"
}

variable "ssh_key_path" {
  description = "Path to the SSH private key file"
  default     = "/home/jiaqi/social_platform/ssh_key/ansible_social_platform"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

# AWS Variables
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
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

