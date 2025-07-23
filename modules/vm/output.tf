output "vm_id" {
  value = var.os_type == "linux" && length(azurerm_linux_virtual_machine.vm) > 0 ? azurerm_linux_virtual_machine.vm[0].id : var.os_type == "windows" && length(azurerm_windows_virtual_machine.vm_windows) > 0 ? azurerm_windows_virtual_machine.vm_windows[0].id : null
}

output "vm_name" {
  value = var.os_type == "linux" && length(azurerm_linux_virtual_machine.vm) > 0 ? azurerm_linux_virtual_machine.vm[0].name : var.os_type == "windows" && length(azurerm_windows_virtual_machine.vm_windows) > 0 ? azurerm_windows_virtual_machine.vm_windows[0].name : null
}
