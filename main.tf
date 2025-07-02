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

resource "azurerm_resource_group" "rg" {
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

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}
