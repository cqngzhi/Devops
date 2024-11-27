resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ./ansible  # Zorg ervoor dat de map bestaat
cat <<EOF > ./ansible/inventory.ini
[master]
$(terraform output -json elastic_ip | jq -r '.[]') ansible_user=ubuntu ansible_ssh_private_key_file=~./SSH/id_rsa

[nodes]
$(terraform output -json node1_private_ip | jq -r '.[]' | sed 's/^/ansible_ssh_host=master ansible_user=ubuntu ansible_ssh_private_key_file=~./SSH/id_rsa')
$(terraform output -json node2_private_ip | jq -r '.[]' | sed 's/^/ansible_ssh_host=master ansible_user=ubuntu ansible_ssh_private_key_file=~./SSH/id_rsa')
$(terraform output -json node3_private_ip | jq -r '.[]' | sed 's/^/ansible_ssh_host=master ansible_user=ubuntu ansible_ssh_private_key_file=~./SSH/id_rsa')
EOF
EOT
  }
}
