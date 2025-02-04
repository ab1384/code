resource "azurerm_virtual_network" "vnet" {

  name                = var.vnet.name

  address_space       = var.vnet.address_space

  # dns_servers         = ["10.0.0.4", "10.0.0.5"]

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

 

  subnet {

    name                 = "dev_subnet"

    address_prefix       = "10.0.1.0/24"

}

 

# nr 1

  subnet {

    name           = "tst_subnet"

    address_prefix = "10.0.2.0/24"

    # security_group = azurerm_network_security_group.example.id

  }

 

}

 resource "azurerm_public_ip" "dev01vm_pub_ip" {

   name                = "anb-dev01vm_ip"

   resource_group_name = azurerm_resource_group.rg.name

   location            = azurerm_resource_group.rg.location

   allocation_method   = "Static"

   tags = {
    environment = "Production"
  }

}


resource "azurerm_network_security_group" "nsg" {

  name                = local.nsg_name

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

 

  security_rule {

    name                       = "allow_all_icoming_tcp"

    priority                   = 100

    direction                  = "Inbound"

    access                     = "Allow"

    protocol                   = "Tcp"

    source_port_range          = "*"

    destination_port_range     = "3389"

    source_address_prefix      = "*"

    destination_address_prefix = "*"

  }

 

  tags = var.tags

}

resource "azurerm_network_interface" "prod_nic01" {

  name                = "anb-nic01"

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

 

  ip_configuration {

    name                          = "internal"

    subnet_id                     = azurerm_virtual_network.vnet.subnet.*.id[0]

    private_ip_address_allocation = "Dynamic"

    public_ip_address_id          = azurerm_public_ip.dev01vm_pub_ip.id

  }

}



resource "azurerm_windows_virtual_machine" "win11pro" {

  name                = "ANB-Dev-VM"

  resource_group_name = azurerm_resource_group.rg.name

  location            = azurerm_resource_group.rg.location

  size                = "Standard_B2s"

  admin_username      = "adminuser"

  admin_password      = "P@$$w0rd1234!"

  network_interface_ids = [ azurerm_network_interface.prod_nic01.id ]

 

  os_disk {

    caching              = "ReadWrite"

    storage_account_type = "Standard_LRS"

  }

 

  source_image_reference {

    publisher = "MicrosoftWindowsDesktop"

    offer     = "Windows-11"

    sku       = "win11-22h2-pro"

    version   = "latest"

  }

}