variable "ami" {
  description = "Amazon Machine Image ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "ansible_social_platform_key"
}

variable "ssh_key_path" {
  description = "Path to the SSH private key file"
  default     = "/home/jiaqi/social_platform/ssh_key/ansible_social_platform"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

