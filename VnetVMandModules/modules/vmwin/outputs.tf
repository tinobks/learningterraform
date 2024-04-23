output "windows_vm_id" {
  description = "id della vm"
  value       = azurerm_windows_virtual_machine.vmwindows.id
}

output "windows_vm_public_ip" {
  description = "pip della vm"
  value       = azurerm_windows_virtual_machine.vmwindows.public_ip_address
}