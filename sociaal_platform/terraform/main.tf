module "network" {
  source = "./modules/network"
}

module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  security_group_id = module.network.security_group_id
  nodes_sg_id  = module.network.nodes_sg_id
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
