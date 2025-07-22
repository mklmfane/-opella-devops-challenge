terraform {
  backend "azurerm" {
    resource_group_name  = "dev-rg-terraform"
    storage_account_name = "mytfstateaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}