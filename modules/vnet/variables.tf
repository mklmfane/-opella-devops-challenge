variable "vnet_name" {
  description = "VNET name"
  type = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}


variable "address_space" {
  description = "Address space of the VNET"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "prefix_vnet" {
  description = "Prefix for VNEt name"
  type = string

  default = "vnet-default"
}


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
