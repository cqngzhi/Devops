module "network" {
  source = "./modules/network"
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = "ami-0e86e20dae9224db8" #  AMI ID
  instance_type     = "t2.micro" 
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  security_group_id = module.network.security_group_id
  key_name          = var.key_name
}

resource "cloudflare_record" "s_platform_dns" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "A"
  content = module.ec2.public_ip # Elastic IP
  ttl     = 1
  proxied = true
}
