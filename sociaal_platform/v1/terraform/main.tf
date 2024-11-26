# Laadt de netwerkmodule
module "network" {
  source = "./modules/network"

  vpc_cidr        = var.vpc_cidr  # CIDR voor VPC
  private_subnets = var.private_subnets  # Private subnetten
  availability_zones = var.availability_zones  # Beschikbare zones
}

# Laadt de EC2 module
module "ec2" {
  source = "./modules/ec2"

  ami               = var.ami  # Het ID van de AMI
  instance_type     = var.instance_type  # EC2 instance type
  key_name          = var.key_name  # De naam van het SSH sleutel
  private_subnet = module.network.private_subnet  # IDs van private subnets
  security_group_id = module.network.security_group_id  # Het ID van de beveiligingsgroep
  asg_min_size      = var.asg_min_size  # Minimum grootte van de autoscaling groep
  asg_max_size      = var.asg_max_size  # Maximale grootte van de autoscaling groep
  asg_desired_capacity = var.asg_desired_capacity  # Gewenste capaciteit voor autoscaling groep
}

