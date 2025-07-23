package terraform.analysis

deny contains msg if {
  some i
  input.resource_changes[i].type == "azurerm_role_assignment"
  lower(input.resource_changes[i].change.after.role_definition_name) == "contributor"
  msg := sprintf("❌ 'Contributor' role is not allowed. Found at resource: %s", [input.resource_changes[i].address])
}
