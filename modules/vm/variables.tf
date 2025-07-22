variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the virtual machine"
  type = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "size_vm" {
  description = "Size of the virtual machine"
  type = string
  default = "Standard_B1s"
}

variable "environment" {
  description = "Environment name"
  type = string  
}

variable "subnet_id" {
  description = "Id of the subnet"
  type = string  
}

variable "username" {
  description = "Username of Windows VM"
  type = string  
}

variable "ssh_public_key" {
  description = "ssh public key"
  type = string  
}

variable "source_image_reference" {
  description = "source image name references"
  type        = map(string)
  default     = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

#variable "network_interface_id" {
#  description = "ID of the network interface"
#  type        = string
#}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}