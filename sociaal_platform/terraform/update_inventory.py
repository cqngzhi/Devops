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

# 获取每个节点的 IP 地址
node1_ip = get_terraform_output('public_ip_node1')
node2_ip = get_terraform_output('public_ip_node2')
node3_ip = get_terraform_output('public_ip_node3')

# 检查获取到的 IP 是否有效
if not node1_ip or not node2_ip or not node3_ip:
    print("One or more public IPs are empty. Exiting.")
    exit(1)

# 读取现有的 inventory.yaml 文件
with open(INVENTORY_FILE, 'r') as file:
    inventory = yaml.safe_load(file)

# 更新 YAML 文件中的 IP 地址
inventory['all']['hosts']['node1']['ansible_host'] = node1_ip
inventory['all']['hosts']['node2']['ansible_host'] = node2_ip
inventory['all']['hosts']['node3']['ansible_host'] = node3_ip

# 写回更新后的 YAML 到文件
with open(INVENTORY_FILE, 'w') as file:
    yaml.safe_dump(inventory, file, default_flow_style=False)

print(f"Updated inventory.yaml with IPs: {node1_ip}, {node2_ip}, {node3_ip}")
