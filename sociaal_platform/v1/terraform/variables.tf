variable "aws_region" {
  description = "AWS regio"  # Beschrijving van de AWS regio
  type        = string
  default     = "us-east-1"  # Standaard AWS regio
}

variable "vpc_cidr" {
  description = "CIDR-blok voor VPC en publieke subnetten"  # CIDR voor VPC en publieke subnetten
  type        = string
  default     = "10.0.0.0/16"  # Standaard CIDR-blok voor de VPC en publieke subnetten
}

variable "private_subnets" {
  description = "Private subnetten CIDR-blokken"  # CIDR-blokken voor private subnetten
  type        = list(string)
  default     = ["10.0.1.0/24"]  # Standaard private subnetten
}

variable "availability_zones" {
  description = "Beschikbare zones voor subnets"  # Lijst van beschikbare AWS zones
  type        = list(string)
  default     = ["us-east-1a"]  # Standaard beschikbaarheidszone
}

variable "ami" {
  description = "AMI ID voor EC2 instances"  # ID van de AMI die gebruikt zal worden
  type        = string
  default     = "ami-0e86e20dae9224db8" # default AMI ID
}

variable "instance_type" {
  description = "EC2 instance type"  # Het type van de EC2 instance
  type        = string
  default     = "t2.micro"  # Standaard instance type
}

variable "key_name" {
  description = "De naam van de SSH-sleutel"  # De naam van de SSH sleutel voor EC2 toegang
  type        = string
}

# Autoscaling variabelen
variable "asg_min_size" {
  description = "Minimum aantal instances in de Auto Scaling groep"  # Minimum grootte van de autoscaling groep
  type        = number
  default     = 1  # Standaard minimum grootte
}

variable "asg_max_size" {
  description = "Maximaal aantal instances in de Auto Scaling groep"  # Maximale grootte van de autoscaling groep
  type        = number
  default     = 5  # Standaard maximale grootte
}

variable "asg_desired_capacity" {
  description = "Gewenste capaciteit in de Auto Scaling groep"  # Gewenste capaciteit in de autoscaling groep
  type        = number
  default     = 2  # Standaard gewenste capaciteit
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
