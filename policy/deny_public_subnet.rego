# File: policy/deny_public_ingress.rego
package terraform.analysis

deny[msg] {
  some i
  rc := input.resource_changes[i]
  rc.type == "azurerm_network_security_rule"
  rc.change.after.source_address_prefix == "0.0.0.0/0"
  msg := sprintf("❌ Public ingress from 0.0.0.0/0 detected at: %s", [rc.address])
}
