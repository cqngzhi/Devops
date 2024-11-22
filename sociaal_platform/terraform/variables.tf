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

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "aws_session_token" {
  description = "AWS Session Token (optional, required for temporary credentials)"
  type        = string
  default     = ""
}

# Cloudflare Variables
variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}
