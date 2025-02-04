locals {

  vm_name                   = "${var.PREFIX}-${var.vm_name}"

  vnet_name                 = "${var.PREFIX}-${var.vnet_name}"

  vm_network_interfaca_name = "${var.PREFIX}-${var.vm_network_interface_name}"

  nsg_name                  = "${var.PREFIX}-${var.nsg_name}"

}
