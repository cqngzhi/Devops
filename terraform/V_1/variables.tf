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

# Definieer AWS-regiovariabelen
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"  
}

# Variabele voor het aantal te maken instanties
variable "counter" {
  default     = 1
  description = "Number of instances to create"
}

# Variabele voor de ami id
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0e86e20dae9224db8"  
}

# Variabele voor de instance type
variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

# Definieer AWS Availability Zone-variabelen
variable "aws_availability_zones" {
  description = "List of AWS availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]  
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

# Gebruikte domeinnaam
variable "domain" {
  description = "Your domain for Cloudflare"
  type        = string
}

# Specificeer mappad
variable "ssh_key_directory" {
  description = "Directory to store SSH private key"
  type        = string
  default     = "/home/jiaqi/OPENVPN/SSH_KEY"   
}
