# Master Node
resource "aws_instance" "k8s_master" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.subnet_a.id
  private_ip             = "10.0.1.10"
  vpc_security_group_ids = [aws_security_group.k8s_master.id]
  key_name               = aws_key_pair.k8s_key.key_name

  root_block_device {
    volume_size = 20
  }

  user_data = <<-EOF
  #!/bin/bash
(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update and Upgrade Ubuntu
apt-get update 
apt-get upgrade -y

# Install and configure NTP
apt-get install -y ntp
systemctl enable ntp
systemctl start ntp

# Install ipvsadm
install ipvsadm -y

# Install IPSet
apt install ipset -y

# Install br_netfilter module
apt install linux-image-extra-virtual
echo "br_netfilter" | sudo tee -a /etc/modules
EOF

  tags = {
    Name = "k8s-master"
  }
}

# Worker Nodes
resource "aws_instance" "k8s_workers" {
  count                  = 3
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t3.medium"
  subnet_id              = element([aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id], count.index)
  private_ip             = cidrhost(element(["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], count.index), 100)
  vpc_security_group_ids = [aws_security_group.k8s_worker.id]
  key_name               = aws_key_pair.k8s_key.key_name

  user_data = <<-EOF
#!/bin/bash

# Update and Upgrade Ubuntu
apt-get update 
apt-get upgrade -y

# Install and configure NTP
apt-get install -y ntp
systemctl enable ntp
systemctl start ntp

# Install ipvsadm
install ipvsadm -y

# Install IPSet
apt install ipset -y

# Install br_netfilter module
apt install linux-image-extra-virtual
echo "br_netfilter" | sudo tee -a /etc/modules
EOF

  tags = {
    Name = "k8s-worker-${count.index + 1}"
  }
}
