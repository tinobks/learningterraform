
resource "azurerm_windows_virtual_machine" "vmwindows" {
  name                = "windowsvm"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.size
  admin_username      = "adminwin"
  admin_password      = "Pippe!Salate1"
  network_interface_ids = [
      var.first_subnet_id
    ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
