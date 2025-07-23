package terraform.analysis.test

import data.terraform.analysis

test_deny_public_ingress_violation if {
  test_input := {
    "resource_changes": [{
      "type": "azurerm_network_security_rule",
      "address": "module.vnet.azurerm_network_security_rule.allow_all",
      "change": {
        "after": {
          "source_address_prefix": "0.0.0.0/0"
        }
      }
    }]
  }

  some msg
  analysis.deny[msg] with input as test_input
  msg == "❌ Public ingress from 0.0.0.0/0 detected at: module.vnet.azurerm_network_security_rule.allow_all"
}
