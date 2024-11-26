variable "vpc_cidr" {
  description = "CIDR-blok voor VPC"
  type        = string
}

variable "private_subnets" {
  description = "Private subnetten CIDR-blokken"
  type        = list(string)
}

variable "availability_zones" {
  description = "Beschikbare zones voor subnets"
  type        = list(string)
}
