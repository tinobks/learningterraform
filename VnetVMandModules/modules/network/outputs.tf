output "public_ip_address_firstsubnet" {
    value = azurerm_public_ip.public_ip_firstsubnet.ip_address
}
output "public_ip_address_secondsubnet" {
    value = azurerm_public_ip.public_ip_secondsubnet.ip_address
}

output "public_ip_id_firstsubnet" {
    value = azurerm_public_ip.public_ip_firstsubnet.id
}
output "public_ip_id_secondsubnet" {
    value = azurerm_public_ip.public_ip_secondsubnet.id
}

output "vnet_id" {
    description = "id della vnet"
    value = azurerm_virtual_network.myterraformnetwork.id
}

output "nic_windows_id" {
  description = "id del primo subnet"
  value       = azurerm_network_interface.nic_windows.id
}

output "nic_linux_id" {
  description = "id del secondo subnet"
  value       = azurerm_network_interface.nic_linux.id
}