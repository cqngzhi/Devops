# Upload de SSH sleutel
resource "aws_key_pair" "ansible_social_platform" {
  key_name   = "ansible_social_platform"  # Naam van de SSH-sleutel
  public_key = file("/home/jiaqi/social_platform/ssh_key/ansible_social_platform.pub")  # Pad naar de publieke sleutel
}

# Master knooppunt (EC2 Instance voor K8s Master)
resource "aws_instance" "master" {
  ami               = var.ami  # Het AMI-ID dat gebruikt wordt voor de instance
  instance_type     = var.instance_type  # Het type van de instance (bijv. t2.micro)
  subnet_id         = var.public_subnet_ids[0]  # Het subnet waarin de instance komt
  vpc_security_group_ids = [var.security_group_id]  # De beveiligingsgroep ID's
  private_ip        = "10.0.1.10"  # Het private IP-adres voor deze instance
  key_name          = var.key_name  # De naam van de SSH-sleutel
  security_groups   = [var.security_group_id]  # De beveiligingsgroepen waartoe deze instance behoort
  associate_public_ip_address = false  # Zet geen publieke IP toe aan deze instance

  tags = {
    Name = "K8s-Master"  # Tag voor de naam van de instance
  }
}

# Elastic IP binden aan Master knooppunt
resource "aws_eip_association" "s_platform_eip" {
  instance_id   = aws_instance.master.id  # Verwijst naar de instance ID van de master
  allocation_id = aws_eip.s_platform_ip[0].id  # Verwijst naar de Elastic IP die wordt geassocieerd
}

# Node1 knooppunt (EC2 Instance voor K8s Node1)
resource "aws_instance" "node1" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.nodes_sg.name]  # Verwijst naar de security group voor nodes
  private_ip        = "10.0.1.11"
  key_name          = var.key_name
  security_groups   = [var.security_group_id]
  associate_public_ip_address = false

  tags = {
    Name = "K8s-Node1"
  }
}

# Node2 knooppunt (EC2 Instance voor K8s Node2)
resource "aws_instance" "node2" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.nodes_sg.name]
  private_ip        = "10.0.1.12"
  key_name          = var.key_name
  security_groups   = [var.security_group_id]
  associate_public_ip_address = false

  tags = {
    Name = "K8s-Node2"
  }
}

# Node3 knooppunt (EC2 Instance voor K8s Node3)
resource "aws_instance" "node3" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.nodes_sg.name]
  private_ip        = "10.0.1.13"
  key_name          = var.key_name
  security_groups   = [var.security_group_id]
  associate_public_ip_address = false

  tags = {
    Name = "K8s-Node3"
  }
}

# Creëert een Launch Template voor Auto Scaling
resource "aws_launch_template" "autoscaling_template" {
  name                  = "ec2-launch-template"  # Naam van de launch template
  image_id              = var.ami  # Het ID van de AMI
  instance_type        = var.instance_type  # Het type van de instance
  key_name             = var.key_name  # De naam van de SSH sleutel
  security_group_ids   = [var.security_group_id]  # De ID van de beveiligingsgroep
  user_data            = <<-EOF
                        #!/bin/bash
                        echo "EC2 instance launched" > /var/log/ec2_startup.log
                        EOF  # Script dat bij het opstarten van de instance uitgevoerd wordt
}

# Creëert een Auto Scaling groep
resource "aws_autoscaling_group" "asg" {
  desired_capacity     = var.asg_desired_capacity  # Gewenste capaciteit
  max_size             = var.asg_max_size  # Maximale capaciteit
  min_size             = var.asg_min_size  # Minimale capaciteit
  vpc_zone_identifier  = var.private_subnet_ids  # De subnets voor de Auto Scaling groep
  launch_template {
    id      = aws_launch_template.autoscaling_template.id  # Verwijst naar de launch template
    version = "$Latest"  # Gebruik de laatste versie van de template
  }
}

# Output de ARN van de Auto Scaling groep
output "instance_arn" {
  value = aws_autoscaling_group.asg.arn  # ARN van de Auto Scaling groep
}
