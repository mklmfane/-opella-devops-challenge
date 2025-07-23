package terraform.analysis

deny contains msg if {
  some i
  rc := input.resource_changes[i]
  rc.type == "azurerm_role_assignment"
  rc.change.after.role_definition_name != "Custom.Provisioner"
  msg := sprintf("❌ Role '%s' is not allowed. Only 'Custom.Provisioner' is permitted.", [rc.change.after.role_definition_name])
}
