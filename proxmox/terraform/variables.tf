variable "pm_api_url" {
  default = "https://proxmox.local:8006/api2/json"
}

variable "pm_node" {
  default = "pve"
}

variable "pm_user" {
  default = ""
}

variable "pm_password" {
  default = ""
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ip_gateway" {
  default = "192.168.1.1"
}

variable "control_nodes" {
  default=1
}

variable "control_cores" {
  default=2
}

variable "control_memory" {
  default=2048
}

variable "control_disk" {
  default="20G"
}

variable "control_ip_range_start" {
  default="192.128.1.5"
}

variable "worker_nodes" {
  default=3
}

variable "worker_cores" {
  default=2
}

variable "worker_memory" {
  default=4096
}

variable "worker_disk" {
  default="20G"
}

variable "worker_ip_range_start" {
  default="192.168.1.6
}