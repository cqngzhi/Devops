output "ec2_public_ip" {
  value = aws_instance.s_platform_instance.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.s_platform_instance.private_ip
}

output "public_ip" {
  value = aws_eip.s_platform_ip[0].public_ip
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
