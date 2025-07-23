package terraform.analysis

allowed_roles := {
  "Custom.Provisioner"
}

deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "azurerm_role_assignment"
  role := rc.change.after.role_definition_name
  not allowed_roles[role]
  msg := sprintf("❌ Role '%s' is not allowed. Only %v are permitted. Resource: %s", [role, allowed_roles, rc.address])
}
