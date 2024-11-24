import subprocess
import yaml
import os

# Terraform 工作目录
TF_DIR = os.path.expanduser('~/social_platform/terraform')
INVENTORY_FILE = os.path.expanduser('~/social_platform/ansible/inventory.yaml')

# 获取 Terraform 输出的公网 IP 地址
def get_terraform_output(output_name):
    try:
        result = subprocess.run(
            ['terraform', '-chdir=' + TF_DIR, 'output', '-raw', output_name],
            capture_output=True, text=True, check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error fetching {output_name} from Terraform: {e}")
        return None

# 获取 Bastion 节点的公网 IP 地址
bastion_ip = get_terraform_output('public_ip_bastion')

# 检查获取到的 IP 是否有效
if not bastion_ip:
    print("Bastion public IP is empty. Exiting.")
    exit(1)

# 读取现有的 inventory.yaml 文件
with open(INVENTORY_FILE, 'r') as file:
    inventory = yaml.safe_load(file)

# 更新 YAML 文件中的 master 部分的 IP 为 Bastion 公网 IP
if 'all' in inventory and 'children' in inventory['all'] and 'master' in inventory['all']['children']:
    for node_ip in list(inventory['all']['children']['master']['hosts'].keys()):
        # 将 master 部分的 IP 地址替换为公网 IP 地址
        inventory['all']['children']['master']['hosts'][bastion_ip] = inventory['all']['children']['master']['hosts'].pop(node_ip)
# 更新 YAML 文件中的节点信息，将 Bastion 公网 IP 替换 10.0.1.10
if 'all' in inventory and 'children' in inventory['all'] and 'nodes' in inventory['all']['children']:
    for node_ip, node_data in inventory['all']['children']['nodes']['hosts'].items():
        # 检查 ansible_ssh_common_args 是否存在并且包含 ProxyCommand
        if 'ansible_ssh_common_args' in node_data:
            # 使用正则表达式替换所有 "ubuntu@" 后面的 IP 地址
            node_data['ansible_ssh_common_args'] = re.sub(
                r"ssh -i .+? -W %h:%p ubuntu@(\S+)",
                f"ssh -i /home/jiaqi/social_platform/ssh_key/ansible_social_platform -W %h:%p ubuntu@{bastion_ip}",
                node_data['ansible_ssh_common_args']
            )

# 写回更新后的 YAML 到文件
with open(INVENTORY_FILE, 'w') as file:
    yaml.safe_dump(inventory, file, default_flow_style=False)

print(f"Updated master IPs with Bastion public IP: {bastion_ip}")

