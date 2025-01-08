resource "local_file" "ansible_inventory" {
  filename = "./ansible/inventory.ini" 
  content  = <<EOT
[master]
${aws_instance.k8s_master.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../SSH/id_rsa ansible_python_interpreter=/usr/bin/python3.12 ansible_hostname=master

[workers]
${join("\n", [
  for i, ip in aws_instance.k8s_workers : 
  "${ip.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../SSH/id_rsa ansible_python_interpreter=/usr/bin/python3.12 ansible_hostname=node${i + 1}"
])}

[all:vars]
ansible_become=yes
ansible_become_method=sudo
EOT

  lifecycle {
    create_before_destroy = true
  }
}
