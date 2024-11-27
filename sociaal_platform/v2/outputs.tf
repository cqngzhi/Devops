output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.k8s.id
}

output "public_ip" {
  value = aws_eip.public_eip[0].public_ip
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

output "master_private_ip" {
  value = aws_instance.master.private_ip
}

output "node1_private_ip" {
  value = aws_instance.node1.private_ip
}

output "node2_private_ip" {
  value = aws_instance.node2.private_ip
}

output "node3_private_ip" {
  value = aws_instance.node3.private_ip
}
