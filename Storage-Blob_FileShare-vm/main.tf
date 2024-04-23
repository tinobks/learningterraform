#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
#https://developer.hashicorp.com/terraform/cli/import/usage
# Redundancy can be LRS, ZRS, GRS, GZRS
# Doc: https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy
#
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.57.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}



# Aggancia an Storage Accounts

data "azurerm_storage_account" "mystoragelf" {
  name                = var.my_Storage_account
  resource_group_name = var.my_resource_group_name
}


resource "azurerm_storage_container" "mycon" {
  name                  = var.my_container
  storage_account_name  = var.my_Storage_account
  container_access_type = "private"
}
# try to upload file 
resource "null_resource" "uploadfile" {

  provisioner "local-exec" {


  command = <<-EOT
  $storageAcct = Get-AzStorageAccount -ResourceGroupName "${var.my_resource_group_name}" -Name "${var.my_Storage_account}"
   Set-AzStorageBlobContent `
   -Context $storageAcct.Context `
   -Container "${azurerm_storage_container.mycon.name}" `
   -File ".\Example.ps1" `
   -Blob "Example.ps1"

  EOT

  interpreter = ["PowerShell", "-Command"]
  #interpreter = ["pwsh", "-Command"]
  }
}

resource "azurerm_storage_share" "myshare2023" {
  name                 = "sharenamelf"
  storage_account_name = var.my_Storage_account
  quota                = 50
}

resource "azurerm_storage_share_file" "testfile" {
  name             = "testfile.zip"
  storage_share_id = azurerm_storage_share.myshare2023.id
  source           = "sorgente.zip"
}

resource "azurerm_storage_blob" "myblob" {
  name                   = "exampleblob"
  storage_account_name   = var.my_Storage_account
  storage_container_name = var.my_container
  type                   = "Block"
  source                 = "D:/EXPERISACADEMY/SecondaParte/Terraform/Storage-Blob_FileShare-vm/tino.txt"

}





/*# Creazione della macchina virtuale con Windows Server 2022
resource "azurerm_windows_virtual_machine" "FileServer" {
  name                  = var.vm_name
  resource_group_name   = var.my_resource_group_name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_DS2_v2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  enable_automatic_updates = false
  network_interface_ids = 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.bootdiag.primary_blob_endpoint
  }
}

# Creazione di una NIC (Network Interface Card) per la VM
resource "azurerm_network_interface" "example" {
  name                = "${azurerm_windows_virtual_machine.FileServer.name}-nic"
  resource_group_name = var.my_resource_group_name
  location = var.region
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}
*/



