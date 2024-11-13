#!/bin/bash

# Geef de doelmap op
TARGET_DIR="/home/jiaqi/DevOps_Project/Ansible"

# Extraheer terraform-uitvoerwaarden
server_ip=$(jq -r '.instance_public_ips.value[0]' terraform_outputs.json)
ssh_key_path=$(jq -r '.private_key_path.value' terraform_outputs.json)
ami_name=$(jq -r '.ami_name.value[0]' terraform_outputs.json)

# Debug output
echo "Server IP: ${server_ip}"
echo "SSH Key Path: ${ssh_key_path}"
echo "AMI Name: ${ami_name}"

# ansible_user is 
ansible_user="ubuntu"

# Check if inventory.yaml already exists and print a message
if [ -f "$TARGET_DIR/inventory.yaml" ]; then
  echo "inventory.yaml already exists, overwriting..."
fi

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

