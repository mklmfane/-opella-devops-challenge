variable "subscription_id" {
  description = "The Azure Subscription ID to use"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources in"
  type        = string
  default     = "westeurope"
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

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets for the VNet"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "username" {
  description = "Username for the virtual machine"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM authentication"
  type        = string
}

variable "size_vm" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "source_image_reference" {
  description = "Map of source image reference for the virtual machine"
  type = map(string)
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
