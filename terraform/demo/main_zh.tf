# 指定Terraform版本
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

# 配置AWS提供商
provider "aws" {
  region     = "us-east-1"  # 请根据实际情况修改区域
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

# 定义变量
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "aws_session_token" {
  description = "AWS session token"
  type        = string
  sensitive   = true
}

variable "counter" {
  default     = 1
  description = "Number of instances to create"
}

# 创建SSH密钥对并保存私钥到本地
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# 将私钥保存到本地文件
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/generated_key.pem"
  file_permission = "0400"  # 确保私钥的文件权限
}

# 创建VPC，设置名称和启用DNS主机名、DNS支持
resource "aws_vpc" "dev_openvpn" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev_openvpn"
  }
}

# 创建Internet网关以实现外部访问
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_openvpn.id

  tags = {
    Name = "dev_openvpn_igw"
  }
}

# 创建路由表并添加默认路由
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.dev_openvpn.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "dev_openvpn_route_table"
  }
}

# 将路由表关联到子网
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

# 创建子网
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.dev_openvpn.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# 定义一个安全组，允许SSH和OpenVPN端口
resource "aws_security_group" "security" {
  name_prefix = "openvpn_security_group"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow OpenVPN"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 创建一个或多个EC2实例
resource "aws_instance" "openvpn" {
  count                       = var.counter
  ami                         = "ami-0e86e20dae9224db8"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.security.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id

  tags = {
    Name = "openvpn"
  }
}

# 为每个实例分配弹性公网IP
resource "aws_eip" "openvpn_ip" {
  count    = var.counter
  instance = aws_instance.openvpn[count.index].id
}

# 输出实例的公网IP和私钥文件路径
output "instance_public_ips" {
  value       = [for ip in aws_eip.openvpn_ip : ip.public_ip]
  description = "The public IP addresses of the OpenVPN EC2 instances."
}

output "private_key_path" {
  value       = local_file.private_key.filename
  description = "Path to the private SSH key saved locally."
}
