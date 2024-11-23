output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.s_platform_vpc.id
}

output "public_subnet_ids" {
  description = "List of IDs for public subnets"
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.s_platform_sg.id
}
