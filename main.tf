terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "vm" {
  for_each = var.vms

  # VM General Settings
  target_node = var.proxmox_node
  name = each.value.name
  vmid = 0
  desc = "VM ${each.value.name} managed by Terraform"

  # VM OS Settings
  clone = each.value.os_template
  full_clone = true
  os_type = "linux"
  qemu_os = "other"

  # VM System Settings
  cores = var.vm_vcpu
  sockets = "1"
  memory = var.vm_memory

  # Dynamic block for network
  dynamic "network" {
    for_each = [
      {
        bridge = "Server"
        model  = "virtio"
      }
    ]

    content {
      bridge = network.value.bridge
      model  = network.value.model
      id     = 0
    }
  }

  # Dynamic block for disk
  dynamic "disk" {
    for_each = [
      {
        type    = "disk"
        storage = var.proxmox_storage
        size    = "${var.vm_disk_size}G"
        slot     = "scsi0"
      }
    ]

    content {
      type    = disk.value.type
      storage = disk.value.storage
      size    = disk.value.size
      slot     = disk.value.slot
    }
  }

  # Cloud-Init Settings
  ipconfig0 = "ip=${each.value.vm_ip}/${var.vm_ipv4_netmask},gw=${var.vm_ipv4_gateway}"
  nameserver = join(" ", var.vm_dns_servers)
  searchdomain = var.vm_domain

  # VM Boot Settings
  boot = "c"
  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"

  # VM CPU Settings
  cpu = "host"
  numa = true
}