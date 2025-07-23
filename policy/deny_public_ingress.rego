# File: policy/deny_public_ingress_test.rego
package terraform.analysis

import data.terraform.analysis

test_deny_public_ingress_violation {
  some i
  input := {
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

  msg := terraform.analysis.deny[i]
  msg == "❌ Public ingress from 0.0.0.0/0 detected at: module.vnet.azurerm_network_security_rule.allow_all"
}
