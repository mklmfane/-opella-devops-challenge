locals {
  environment = var.workflow
  
  resource_group_name = "${local.environment}-rg"
  vnet_name           = "${local.environment}-vnet"
  storage_account_name = "${substr(replace("${local.environment}storage${replace(uuid(), "-", "")}", "-", ""), 0, 24)}"

  tags = {
    environment = local.environment
    project     = "multi-env-demo"
  }
}

# Try to fetch the existing resource group
#data "azurerm_resource_group" "existing_rg" {
#  name = local.resource_group_name
#}

resource "azurerm_resource_group" "rg" {
  #count    = data.azurerm_resource_group.existing_rg.id != "" ? 0 : 1
  name     = local.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = local.vnet_name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${local.environment}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = values(module.vnet.subnet_ids)[0]
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.tags
}


resource "random_string" "suffix" {
  length  = 6
  upper   = false
  numeric  = true
  special = false
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${local.environment}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  location            = var.location
  size                = "Standard_B1s"

  admin_username      = "devops"
  network_interface_ids = [azurerm_network_interface.nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }


  admin_ssh_key {
    username  = var.username
    public_key = var.ssh_public_key
  }

  tags = local.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = "sa${replace(local.environment, "-", "")}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags
}
