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

# Variabele voor het aantal te maken instanties
variable "counter" {
  default     = 1
  description = "Number of instances to create"
}

# Variabele voor de Cloudflare API-token
variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

