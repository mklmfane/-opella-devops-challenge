package terraform.analysis

deny contains msg if {
  some i
  rc := input.resource_changes[i]
  rc.type == "azurerm_network_security_rule"
  prefix := object.get(rc.change.after, "source_address_prefix", "")
  prefix == "0.0.0.0/0"
  msg := sprintf("❌ Public ingress from 0.0.0.0/0 detected at: %s", [rc.address])
}
