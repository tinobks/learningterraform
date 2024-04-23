#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
#https://developer.hashicorp.com/terraform/cli/import/usage
# 
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



# Create an Storage Accounts
resource "azurerm_resource_group" "rg" {
  name     = var.my_resource_group.nome
  location = var.my_resource_group.location
}

resource "azurerm_storage_account" "sa" {
  name                     = var.my_Storage_account
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "mycon" {
  name                  = var.my_container
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
# try to upload file 
resource "null_resource" "uploadfile" {

  provisioner "local-exec" {


  command = <<-EOT
  $storageAcct = Get-AzStorageAccount -ResourceGroupName "${azurerm_resource_group.rg.name}" -Name "${azurerm_storage_account.sa.name}"
   Set-AzStorageBlobContent `
   -Context $storageAcct.Context `
   -Container "${azurerm_storage_container.mycon.name}" `
   -File ".\MyDom.ps1" `
   -Blob "MyDom.ps1"

  EOT

  interpreter = ["PowerShell", "-Command"]
  #interpreter = ["pwsh", "-Command"]
  }
}
  /*
    By ca Warning:
    If You use Azure Cloud Shell it's possible it can't find PowerShell 
    Verify $PATH using echo $PATH
    If PowerShell isn't in the path You must add it
    The possible path is /opt/microsoft/powershell/7/
    Add the path using this command
    PATH=$PATH:~/opt/microsoft/powershell/7/
    and replace "PowerShell" with "pwsh" in the line containg interpreter    
   */