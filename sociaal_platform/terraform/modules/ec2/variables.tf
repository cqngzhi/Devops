variable "vpc_id" {
  description = "VPC ID for EC2 instances"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for EC2 instances"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Key name for EC2 instances"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0e86e20dae9224db8" #  AMI ID
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
