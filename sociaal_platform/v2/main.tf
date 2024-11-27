resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ./ansible  # Zorg ervoor dat de map bestaat
cat <<EOF > ./ansible/inventory.ini
[master]
$(terraform output -json public_ips | jq -r '.[]') ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa

[nodes]
$(terraform output -json private_ips | jq -r '.[]' | sed 's/^/ansible_ssh_host=master ansible_user=ubuntu ansible_ssh_private_key_file=~\/.ssh\/id_rsa /') 
EOF
EOT
  }
}

