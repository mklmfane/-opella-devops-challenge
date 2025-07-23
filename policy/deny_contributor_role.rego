# File: policy/deny_contributor_role.rego
package terraform.analysis

deny[msg] {
  some i
  rc := input.resource_changes[i]
  rc.type == "azurerm_role_assignment"
  lower(rc.change.after.role_definition_name) == "contributor"
  msg := sprintf("❌ 'Contributor' role is not allowed. Found at resource: %s", [rc.address])
}
