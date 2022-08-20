resource "proxmox_vm_qemu" "control_plane" {
  count             = 1
  name              = "control-plane-${count.index}.k8s.cluster"
  target_node       = "${var.pm_node}"

  clone             = "ubuntu-2004-cloudinit-template"

  os_type           = "cloud-init"
  cores             = var.control_cores
  sockets           = "1"
  cpu               = "host"
  memory            = var.control_memory
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "${var.control_disk}"
    type            = "scsi"
    storage         = "local-lvm"
    iothread        = 1
  }

  network {
    model           = "virtio"
    bridge          = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0         = "ip=${var.control_ip_range_start}${count.index}/24,gw=${var.ip_gateway}"
  sshkeys = file("${var.ssh_key_file}")
}

resource "proxmox_vm_qemu" "worker_nodes" {
  count             = 3
  name              = "worker-${count.index}.k8s.cluster"
  target_node       = "${var.pm_node}"

  clone             = "ubuntu-2004-cloudinit-template"

  os_type           = "cloud-init"
  cores             = var.worker_cores
  sockets           = "1"
  cpu               = "host"
  memory            = var.worker_memory
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "${var.worker_disk}"
    type            = "scsi"
    storage         = "local-lvm"
    iothread        = 1
  }

  network {
    model           = "virtio"
    bridge          = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0         = "ip=${var.worker_ip_range_start}${count.index}/24,gw=${var.ip_gateway}"
  sshkeys = file("${var.ssh_key_file}")
}
