variable "location" {
  description = "Azure location"
  type        = string
  default     = "westeurope"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space of the VNET"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}


variable "workflow" {
  description = "Workflow environment: dev, test, or prod"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.workflow)
    error_message = "Workflow must be one of: dev, test, prod."
  }
}

variable "username" {
  description = "username provided for VM"
  type        = string
  default     = "devops-test"
}


variable "ssh_public_key" {
  description = "ssh public key file"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSMgn1iGOksghwCrnuXAMXKtAk/TwAw/pTJb9mC+q6v9Clo+yVizRwQ+kGsDAtZUUkQfIr3Ep5MUSOtyfyeLQkiC55iD4JvEpWbiwCrbma17z9hPDiEUu8cYBZhQIpXnVkTdtoRRSejNlAfgb1OJDjyG5tAv/QF7Bvq8+MsxEHYlb7NewSe8Fh/AFTCFVkixyYhjXEHOrX9naBzNyYRqkGpQ9dJd9USsGEIgku3VkI2jNNCLtJIlli3TTy726vtAJ713TXfzbcYtlkXmcDRk3r7Y1934DfRSwenlad8O5ElcnYgeLPo50SVUnEufmbz0OV/rIb1WBL1KWuIcPdKkRRTz7X+uGdSGj24FTTrtAWajpEyvFemtN2ViZpqUJ+L/oJEKObc/ZP1pNX2a53Y9MJIDQ+mtzFvA1p//1p5FSe9yoBtzLurP0MiLdLJZJcjVAGv+p6jYCk2XPOFqaMV59j2qz978Ky65LycJ5L8SAyvUqoqoDS0eB9ckxnjhlR6j+f6mWOQ8gW7bYEDTvRQJr45LWtuyW61hC7Xp0E9MuG0Sr5/YKS6cSqppNsgCuOiWK74z+lKmTwkw3xXMhM8VRO67TVthRIdbEhvL8pHSiS02iLHl7aIcmou5XZIUwE0KQW3TKurxcA1wiibWC++n/oGX95IKOjskxnt/ce/cQsoQ== devops-test@staff-fddggfgd.myhost.com"
}
