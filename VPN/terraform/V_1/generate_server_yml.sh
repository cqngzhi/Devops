#!/bin/bash

# Geef de doelmap op
TARGET_DIR="/home/jiaqi/DevOps_Project/Ansible"

# Extraheer terraform-uitvoerwaarden
server_ip=$(jq -r '.instance_public_ips.value[0]' terraform_outputs.json)
ssh_key_path=$(jq -r '.private_key_path.value' terraform_outputs.json)

# Stel de gebruikersnaam in op basis van het AMI-besturingssysteem
ami_name=$(jq -r '.ami_name.value[0]' terraform_outputs.json)

# ansible user is ubuntu
  ansible_user="ubuntu"

# Maak het inventory.yaml-bestand en schrijf het naar de opgegeven map
cat <<EOF > "$TARGET_DIR/inventory.yaml"
all:
  children:
    web_servers:
      hosts:
        server1:
          ansible_host: "${server_ip}"
          ansible_ssh_private_key_file: "${ssh_key_path}"
          ansible_user: "${ansible_user}"
  vars:
    ansible_python_interpreter: /usr/bin/python3
EOF

echo "inventory.yaml has been generated successfully in $TARGET_DIR."
