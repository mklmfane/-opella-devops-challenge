package terraform.analysis

deny_contributor[msg] if {
  rc := input.resource_changes[_]
  rc.type == "azurerm_role_assignment"
  lower(rc.change.after.role_definition_name) == "contributor"
  msg := sprintf("❌ 'Contributor' role is not allowed. Found at resource: %s", [rc.address])
}
