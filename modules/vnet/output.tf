output "vnet_id" {
  description = "ID of the VNET"
  value       = azurerm_virtual_network.virtual_network_one.id
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value = { 
    for subnet in azurerm_subnet.subnet : subnet.name => subnet.id 
  }
}

output "vnet_name" {
  description = "Name of the VNET displayed"
  value = azurerm_virtual_network.virtual_network_one.name
}