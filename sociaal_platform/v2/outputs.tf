output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.k8s.id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = aws_subnet.k8s_sub.id
}

output "internet_gateway_id" {
  description = "The ID of the created Internet Gateway"
  value       = aws_internet_gateway.k8s_igw.id
}

output "route_table_id" {
  description = "The ID of the created Route Table"
  value       = aws_route_table.k8s_rt.id
}

output "security_group_master" {
  description = "The ID of the master security group"
  value       = aws_security_group.master_sg.id
}

output "security_group_nodes" {
  description = "The ID of the nodes security group"
  value       = aws_security_group.nodes_sg.id
}

output "elastic_ip" {
  description = "The allocated Elastic IP address"
  value       = aws_eip.public_eip.*.public_ip
}
