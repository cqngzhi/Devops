# 1. 导入必要的库
import subprocess  # 用于执行系统命令
import yaml       # 用于处理 YAML 文件
import os         # 用于处理文件路径
import re         # 用于正则表达式匹配替换

# 2. 设置关键路径
TF_DIR = os.path.expanduser('~/social_platform/terraform')        # Terraform 工作目录
INVENTORY_FILE = os.path.expanduser('~/social_platform/ansible/inventory.yaml')  # Ansible inventory 文件路径

# 3. 定义获取 Terraform 输出的函数
def get_terraform_output(output_name):
    try:
        # 执行 terraform output 命令获取指定输出
        result = subprocess.run(
            ['terraform', '-chdir=' + TF_DIR, 'output', '-raw', output_name],
            capture_output=True, text=True, check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error fetching {output_name} from Terraform: {e}")
        return None

# 4. 获取跳板机的公网 IP
bastion_ip = get_terraform_output('public_ip_bastion')

# 5. 验证 IP 地址
if not bastion_ip:
    print("Bastion public IP is empty. Exiting.")
    exit(1)

# 6. 读取并更新 inventory 文件
# 读取现有的 inventory.yaml
with open(INVENTORY_FILE, 'r') as file:
    inventory = yaml.safe_load(file)

# 7. 更新 master 组的 IP 地址
if 'all' in inventory and 'children' in inventory['all'] and 'master' in inventory['all']['children']:
    for node_ip in list(inventory['all']['children']['master']['hosts'].keys()):
        # 用新的跳板机公网 IP 替换旧的 IP
        inventory['all']['children']['master']['hosts'][bastion_ip] = (
            inventory['all']['children']['master']['hosts'].pop(node_ip)
        )

# 8. 更新 nodes 组中的 ProxyCommand
if 'all' in inventory and 'children' in inventory['all'] and 'nodes' in inventory['all']['children']:
    for node_ip, node_data in inventory['all']['children']['nodes']['hosts'].items():
        if 'ansible_ssh_common_args' in node_data:
            # 使用正则表达式更新 ProxyCommand 中的跳板机 IP
            node_data['ansible_ssh_common_args'] = re.sub(
                r"ssh -i .+? -W %h:%p ubuntu@(\S+)",
                f"ssh -i /home/jiaqi/social_platform/ssh_key/ansible_social_platform -W %h:%p ubuntu@{bastion_ip}",
                node_data['ansible_ssh_common_args']
            )

# 9. 保存更新后的配置
with open(INVENTORY_FILE, 'w') as file:
    yaml.safe_dump(inventory, file, default_flow_style=False)

print(f"Updated master IPs with Bastion public IP: {bastion_ip}")
