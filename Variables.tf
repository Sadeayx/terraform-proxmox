variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type = string
}

variable "proxmox_api_token_id" {
  description = "The Proxmox API token ID"
  type = string
}

variable "proxmox_api_token_secret" {
  description = "The Proxmox API token secret"
  type = string
}

variable "proxmox_node" {
  description = "The Proxmox node to create the VMs on"
  type = string
}

variable "proxmox_storage" {
  description = "The storage pool to create the VMs on"
  type = string
}

variable "vm_vcpu" {
  description = "Number of virtual CPUs"
  type = number
  default = 4
}

variable "vm_memory" {
  description = "Amount of memory in MB"
  type = number
  default = 4096
}

variable "vm_disk_size" {
  description = "Disk size in GB"
  type = number
  default = 50
}

variable "vm_ipv4_netmask" {
  description = "IPv4 netmask length"
  type = string
  default = "24"
}

variable "vm_ipv4_gateway" {
  description = "IPv4 gateway"
  type = string
}

variable "vm_dns_servers" {
  description = "List of DNS servers"
  type = list(string)
  default = ["8.8.8.8", "8.8.4.4"]
}

variable "vm_domain" {
  description = "Domain name"
  type = string
}

variable "vms" {
  description = "Map of VMs to create"
  type = map(object({
    name = string
    vm_ip = string
    os_template = string
  }))
}