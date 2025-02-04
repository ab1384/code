variable "rg_name" {

  description = "Name of an existing resource group where the soultion will be deployed"

  type        = string

  default     = "Andrii_DevOps"

}

 

variable "vnet" {

  type = object({

    name          = string

    address_space = list(string)

  })

  default = {

    name          = "vnet-devops"

    address_space = ["10.0.0.0/16"]

  }

}

 

variable "tags" {

  type = map(string)

  default = {

    environment = "Production"

    owner       = "Andrii Bilokonenko"

    project     = "DevOps"

  }

}

 

variable "vm_network_interface_name" {

  default = "anb-nic"

}

 

variable "vm_config" {

  type = object({

    name  = string

    admin = string

  })

  default = {

    name  = "anb-vm"

    admin = "adminuser"

  }

}

 

variable "subnets_map" {

  type = map(object({

    name           = string

    address_prefix = string

  }))

  default = {

    "bastion" = {

      name           = "AzureBastionSubnet"

      address_prefix = "10.0.1.0/24"

    },

    "dev" = {

      name           = "dev_subnet"

      address_prefix = "10.0.2.0/24"

    },

    "tst" = {

      name           = "tst_subnet"

      address_prefix = "10.0.3.0/24"

    }

  }

}

 

variable "nsg_name" {

  default = "ANB-nsg"

}

variable "PREFIX" {

  description = "Prefix for all the resources"

  default     = "ANB"

}

variable "vm_name" {

  default = "dev-01vm"

}


variable "vnet_name" {

  default = "VNET"

}
