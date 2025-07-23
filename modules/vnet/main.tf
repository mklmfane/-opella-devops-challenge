resource "azurerm_virtual_network" "virtual_network_one" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network_one.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_rule" "insecure_rule" {
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "0.0.0.0/0"
  destination_port_range      = "22"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = "my-nsg"
}
