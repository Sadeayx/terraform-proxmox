proxmox_api_url = "https://10.200.91.173:8006/api2/json"
proxmox_api_token_id = "root@pam!terraform"
proxmox_api_token_secret = "83265470-e39c-46a2-b97a-d7ef5668d432"
proxmox_node = "azubiserver"
proxmox_storage = "local-zfs"

vm_vcpu = 4
vm_memory = 4096
vm_disk_size = 50
vm_ipv4_netmask = "24"
vm_ipv4_gateway = "192.168.1.1"
vm_dns_servers = ["8.8.8.8", "8.8.4.4"]
vm_domain = "example.com"

vms = {
  vm_1 = {
    name = "rocky-1"
    vm_ip = "192.168.1.10"
    os_template = "ubuntu-template"
  }
}