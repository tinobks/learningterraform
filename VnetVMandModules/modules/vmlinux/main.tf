
# Create virtual machine
resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                  = "vmlinux"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  size                  = var.size
  admin_username        = var.username
  admin_password        = var.password
  network_interface_ids = [
      var.second_subnet_id
    ]

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  disable_password_authentication = false
}