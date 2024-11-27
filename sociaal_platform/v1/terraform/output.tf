# Outputs van de belangrijkste infrastructuurcomponenten
# Deze outputs geven nuttige informatie over de infrastructuur na de implementatie

# VPC ID, die kan worden gebruikt voor andere configuraties of diagnostiek
output "vpc_id" {
  description = "De ID van de VPC"  # De VPC ID die wordt aangemaakt
  value       = aws_vpc.main.id  # Verwijst naar de VPC resource die we hebben aangemaakt
}

# Het CIDR-blok van de VPC, handig voor netwerkconfiguraties en subnettering
output "vpc_cidr" {
  description = "Het CIDR-blok van de VPC"  # Het CIDR-blok van de VPC
  value       = aws_vpc.main.cidr_block  # Het CIDR-blok van de VPC resource
}

# De private subnetten ID's, nuttig voor het beheren van beveiligde netwerkbronnen
output "private_subnet" {
  description = "ID's van de private subnetten"  # De ID's van de private subnetten
  value       = aws_subnet.private.id  # Geeft een lijst van ID's van de private subnetten
}

# Beveiligingsgroep ID, handig voor het beheren van netwerkbeveiliging en toegang
output "security_group_id" {
  description = "Het ID van de beveiligingsgroep"  # Het ID van de beveiligingsgroep
  value       = aws_security_group.s_platform_sg.id  # Verwijst naar de beveiligingsgroep die we hebben aangemaakt
}

# De ARN van de Auto Scaling groep, handig voor het beheren van schaling en monitoring
output "asg_arn" {
  description = "De ARN van de Auto Scaling groep"  # ARN voor de Auto Scaling groep
  value       = aws_autoscaling_group.asg.arn  # Verwijst naar de ARN van de Auto Scaling groep
}

# Output voor de Elastic IP die aan de master is gekoppeld
output "master_eip" {
  value = aws_eip.s_platform_ip.public_ip  # Het publieke IP van de Elastic IP
}

# EC2 instance ID's, handig voor toegang tot specifieke instances of debugging
output "ec2_instance_ids" {
  description = "ID's van de EC2-instanties"  # ID's van de EC2-instanties
  value       = [
    aws_instance.master.id,
    aws_instance.node1.id,
    aws_instance.node2.id,
    aws_instance.node3.id # Lijst van de EC2 instance ID's
  ]
}

# Het aantal EC2-instanties in de Auto Scaling groep, nuttig voor schaling en beheer
output "asg_instance_count" {
  description = "Het aantal EC2-instanties in de Auto Scaling groep"  # Aantal EC2-instanties in de Auto Scaling groep
  value       = aws_autoscaling_group.asg.desired_capacity  # Aantal EC2-instanties in de Auto Scaling groep
}

output "account_id" {
  description = "Selected AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "region" {
  description = "Details about selected AWS region"
  value       = data.aws_region.current.name
}
