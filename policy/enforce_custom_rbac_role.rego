package terraform.analysis

deny[msg] {
  some i
  rc := input.resource_changes[i]
  rc.type == "azurerm_role_assignment"
  role := rc.change.after.role_definition_name
  role != "Custom.Provisioner"
  msg := sprintf("❌ Role '%s' is not allowed. Only 'Custom.Provisioner' is permitted. Resource: %s", [role, rc.address])
}
