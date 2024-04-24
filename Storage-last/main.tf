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

# Creare gruppo di risorse
resource "azurerm_resource_group" "rg" {
  name     = var.my_resource_group.name
  location = var.my_resource_group.location
}

# Creare storage account
resource "azurerm_storage_account" "sa" {
  name                     = var.my_storage_account
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}


# Creazione container e caricamento file come blob
resource "azurerm_storage_container" "mycon" {
  name                  = var.my_container
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
# try to upload file 
resource "null_resource" "uploadfile" {

  provisioner "local-exec" {


  command = <<-EOT
  $storageAcct = Get-AzStorageAccount -ResourceGroupName "${var.my_resource_group.name}" -Name "${var.my_storage_account}"
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

resource "azurerm_storage_blob" "myblob" {
  name                   = "exampleblob"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.mycon.name
  type                   = "Block"
  source                 = "D:/EXPERISACADEMY/SecondaParte/Terraform/Es02/tino.txt"

}

# Creazione share e caricamento file all'interno
resource "azurerm_storage_share" "myshare" {
  name                 = var.myshare
  storage_account_name = azurerm_storage_account.sa.name
  quota                = 50
}

resource "azurerm_storage_share_file" "testfile" {
  name             = "testfile.zip"
  storage_share_id = azurerm_storage_share.myshare.id
  source           = "uploadtoshare.zip"
}

# Creazione tabella con temperature di Roma, Milano e Genova
resource "azurerm_storage_table" "mytable" {
    name                 = var.mytable
    storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_table_entity" "roma" {
    storage_account_name = azurerm_storage_account.sa.name
    table_name = azurerm_storage_table.mytable.name
    
    partition_key = "Roma"
    row_key = 1
    entity = {
      Temperature = "21°C"
    }
}

resource "azurerm_storage_table_entity" "milano" {
    storage_account_name = azurerm_storage_account.sa.name
    table_name = azurerm_storage_table.mytable.name
    
    partition_key = "Milano"
    row_key = 2
    entity = {
      Temperature = "18°C"
    }
}

resource "azurerm_storage_table_entity" "genova" {
    storage_account_name = azurerm_storage_account.sa.name
    table_name = azurerm_storage_table.mytable.name
    
    partition_key = "Genova"
    row_key = 3
    entity = {
      Temperature = "20°C"
    }
}

# Creazione coda messaggi
resource "azurerm_storage_queue" "myqueue1" {
  name                 = "coda1"
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_queue" "myqueue2" {
  name                 = "coda2"
  storage_account_name = azurerm_storage_account.sa.name
}
