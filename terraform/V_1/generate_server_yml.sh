#!/bin/bash

# Geef de doelmap op
TARGET_DIR="/home/jiaqi/DevOps_Project/Ansible"

# Extraheer terraform-uitvoerwaarden
server_ip=$(jq -r '.server_public_ip.value' terraform_outputs.json)
ssh_key_path=$(jq -r '.ssh_key_path.value' terraform_outputs.json)
ami_name=$(jq -r '.ami_name.value' terraform_outputs.json)

# Debug output
echo "Server IP: ${server_ip}"
echo "SSH Key Path: ${ssh_key_path}"
echo "AMI Name: ${ami_name}"

# Stel anible_user in op basis van mogelijke besturingssysteemtypen
if [[ "$ami_name" == *"ubuntu"* ]]; then
  ansible_user="ubuntu"
elif [[ "$ami_name" == *"amzn"* || "$ami_name" == *"amazon"* ]]; then
  ansible_user="ec2-user"
elif [[ "$ami_name" == *"centos"* ]]; then
  ansible_user="centos"
else
  ansible_user="admin"
fi

# Debug output for ansible_user
echo "Ansible User: ${ansible_user}"

# Maak het inventory.yaml-bestand en schrijf het naar de opgegeven map
cat <<EOF > "$TARGET_DIR/inventory.yaml"
all:
  hosts:
    server1:
      ansible_host: "${server_ip}"
      ansible_ssh_private_key_file: "${ssh_key_path}"
      ansible_user: "${ansible_user}"
  vars:
    ansible_python_interpreter: /usr/bin/python3
EOF

echo "inventory.yaml has been generated successfully in $TARGET_DIR."
