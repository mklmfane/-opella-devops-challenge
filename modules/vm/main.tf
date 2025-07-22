
resource "azurerm_network_interface" "nic" {
  name = "nic-${var.environment}-${var.location}"

  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id 
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size_vm

  admin_username      = var.username

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source_image_reference["publisher"]
    offer     = var.source_image_reference["offer"]
    sku       = var.source_image_reference["sku"]
    version   = var.source_image_reference["version"]
  }

  admin_ssh_key {
    username   = var.username
    public_key = var.ssh_public_key
  }

  #tags = var.tags
}