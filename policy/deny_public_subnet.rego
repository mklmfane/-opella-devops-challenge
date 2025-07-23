package main

deny contains msg if {
  some i
  rc := input.resource_changes[i]
  rc.type == "azurerm_network_security_rule"
  prefix := rc.change.after.source_address_prefix
  prefix == "0.0.0.0/0"
  msg := sprintf("❌ Public ingress from 0.0.0.0/0 detected at: %s", [rc.address])
}

deny contains msg if {
  some i
  rc := input.resource_changes[i]
  rc.type == "azurerm_subnet"
  some j
  rc.change.after.address_prefixes[j] == "0.0.0.0/32"
  msg := sprintf("❌ Subnet %s uses public address 0.0.0.0/32 which is not allowed.", [rc.address])
}
