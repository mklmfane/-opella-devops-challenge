locals {
  environment          = var.workflow
  resource_group_name  = "${local.environment}-rg"
  vnet_name            = "${var.vnet_name}-${local.environment}-vnet"
  
  tags = merge(
    var.tags,
    {
      environment = local.environment
    }
  )
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location

  tags = local.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = "sa${replace(local.environment, "-", "")}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version          = "TLS1_2"  # ✅ Fix: secure TLS version

  tags                     = local.tags ## tags are managed by terratag through the pipeline
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = local.vnet_name
  address_space       = var.address_space
  subnets             = var.subnets

  tags                = local.tags ## tags are managed by terratag  through the pipeline
}


module "vm" {
  source = "./modules/vm"

  virtual_machine_name   = "vm-${local.environment}-${var.location}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = var.location
  size_vm                = var.size_vm
  username               = var.username
  ssh_public_key         = var.ssh_public_key
  

  # Add missing required arguments
  vnet_name   = module.vnet.vnet_name
  subnet_id = module.vnet.subnet_ids["subnet-1"]
  environment = local.environment

  os_type               = var.os_type
  admin_password        = var.admin_password


  # New: pass OS-specific image references
  linux_source_image_reference = var.linux_source_image_reference
  windows_image_reference = var.windows_image_reference

  tags                   = local.tags ## tags are managed by terratag
}

