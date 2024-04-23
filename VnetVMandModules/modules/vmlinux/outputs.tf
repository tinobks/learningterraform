output "linux_vm_id" {
  description = "id della vm Linux"
  value       = azurerm_linux_virtual_machine.linuxvm.id
}

output "linux_vm_public_ip" {
  description = "indirizzo pip della vm linux"
  value       = azurerm_linux_virtual_machine.linuxvm.public_ip_address
}



