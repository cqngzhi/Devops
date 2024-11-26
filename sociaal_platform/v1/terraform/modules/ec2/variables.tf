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
