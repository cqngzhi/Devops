output "vpc_id" {
  description = "ID van de VPC"
  value       = aws_vpc.s_platform_vpc.id
}

output "private_subnet" {
  description = "IDs van de private subnetten"
  value       = aws_subnet.private[*].id
}

output "security_group_id" {
  description = "ID van de security group"
  value       = aws_security_group.s_platform_sg.id
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
