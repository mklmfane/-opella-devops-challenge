package terraform.analysis

deny_public_subnet[msg] if {
  rc := input.resource_changes[_]
  rc.type == "azurerm_subnet"
  rc.change.after.name == "public-subnet"  # Example pattern
  msg := sprintf("❌ Public subnet detected at: %s", [rc.address])
}
