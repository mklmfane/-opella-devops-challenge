package terraform.analysis

import data.terraform.analysis.deny_contributor
import data.terraform.analysis.deny_public_ingress
import data.terraform.analysis.deny_public_subnet
import data.terraform.analysis.deny_invalid_rbac

deny contains msg if {
  msg := deny_contributor[_]
}

deny contains msg if {
  msg := deny_public_ingress[_]
}

deny contains msg if {
  msg := deny_public_subnet[_]
}

deny contains msg if {
  msg := deny_invalid_rbac[_]
}
