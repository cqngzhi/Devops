# Geef de vereiste Terraform versies en providers aan
terraform {
  required_providers {
    # AWS provider configuratie
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
 # Cloudflare provider configuratie
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

# Configureer de AWS provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

# Configureer de Cloudflare provider
provider "cloudflare" {
  api_token = var.cloudflare_api_token
  account_id = var.cloudflare_account_id
}
