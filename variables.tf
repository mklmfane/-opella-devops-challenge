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

variable "linux_source_image_reference" {
  description = "Map of source image reference for the virtual machine"
  type = map(string)
  
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "windows_image_reference" {
  description = "Windows image reference"
  type        = map(string)

  default     = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}

variable "os_type" {
  description = "Operating system type for the VM. Allowed values: linux or windows"
  type        = string
  default     = "linux"
  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "os_type must be 'linux' or 'windows'"
  }
}

variable "admin_password" {
  description = "Admin password for Windows VM (required only if os_type is windows)"
  type        = string
  default     = null

  validation {
    condition     = var.os_type == "windows" ? var.admin_password != null && length(var.admin_password) > 0 : true
    error_message = "admin_password must be set and non-empty when os_type is 'windows'."
  }
}
