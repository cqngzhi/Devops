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

# 配置AWS提供商，指定区域
provider "aws" {
  region = "us-east-1"  # 请根据实际情况修改区域
}

# 定义一个安全组，允许SSH连接
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 创建一个EC2实例
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2的AMI ID，请根据区域更新AMI ID
  instance_type = "t2.micro"  # 免费套餐实例类型

  # 使用默认的安全组允许SSH
  security_groups = [aws_security_group.allow_ssh.name]

  # 使用自己的密钥对
  key_name = "your_key_name"  # 替换为已在AWS创建的密钥对名称

  tags = {
    Name = "Terraform-EC2"
  }
}

# 分配弹性公网IP并绑定到实例
resource "aws_eip" "web_ip" {
  instance = aws_instance.web_server.id
}

# 输出实例的公网IP
output "instance_public_ip" {
  value = aws_eip.web_ip.public_ip
  description = "The public IP address of the EC2 instance."
}

