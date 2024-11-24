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

# De publieke subnetten ID's, nuttig voor bijvoorbeeld het verbinden van de EC2-instanties
output "public_subnet_ids" {
  description = "ID's van de publieke subnetten"  # De ID's van de publieke subnetten
  value       = aws_subnet.public[*].id  # Geeft een lijst van ID's van de publieke subnetten
}

# De private subnetten ID's, nuttig voor het beheren van beveiligde netwerkbronnen
output "private_subnet_ids" {
  description = "ID's van de private subnetten"  # De ID's van de private subnetten
  value       = aws_subnet.private[*].id  # Geeft een lijst van ID's van de private subnetten
}

# Beveiligingsgroep ID, handig voor het beheren van netwerkbeveiliging en toegang
output "security_group_id" {
  description = "Het ID van de beveiligingsgroep"  # Het ID van de beveiligingsgroep
  value       = aws_security_group.default.id  # Verwijst naar de beveiligingsgroep die we hebben aangemaakt
}

# De ARN van de Auto Scaling groep, handig voor het beheren van schaling en monitoring
output "asg_arn" {
  description = "De ARN van de Auto Scaling groep"  # ARN voor de Auto Scaling groep
  value       = aws_autoscaling_group.asg.arn  # Verwijst naar de ARN van de Auto Scaling groep
}

# EC2 instance ID's, handig voor toegang tot specifieke instances of debugging
output "ec2_instance_ids" {
  description = "ID's van de EC2-instanties"  # ID's van de EC2-instanties
  value       = aws_instance.example[*].id  # Geeft een lijst van EC2 instance ID's
}

# De back-upplan ARN, handig voor back-up en herstelbeheer
output "backup_plan_arn" {
  description = "De ARN van het back-up plan"  # ARN van het back-up plan
  value       = aws_backup_plan.ec2_backup_plan.arn  # Verwijst naar de ARN van het back-up plan
}

# Het aantal EC2-instanties in de Auto Scaling groep, nuttig voor schaling en beheer
output "asg_instance_count" {
  description = "Het aantal EC2-instanties in de Auto Scaling groep"  # Aantal EC2-instanties in de Auto Scaling groep
  value       = aws_autoscaling_group.asg.desired_capacity  # Aantal EC2-instanties in de Auto Scaling groep
}

# Het schema van de back-ups, handig om te weten wanneer back-ups plaatsvinden
output "backup_schedule" {
  description = "Het schema voor de back-ups"  # Het cron-formaat voor het back-up schema
  value       = var.backup_schedule  # Het back-up schema dat we hebben ingesteld
}
