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
