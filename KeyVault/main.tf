provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "existingrg" {
  name = var.my_resource_group.nome
}

resource "azurerm_key_vault" "example" {
  name                        = "tbkeyvault23042024"
  location                    = var.my_resource_group.location
  resource_group_name         = var.my_resource_group.nome
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Import",
      "Delete",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover",
    ]

    storage_permissions = [
      "Get",
      "List",
      "Delete",
      "Set",
      "Update",
    ]
  }
}

resource "azurerm_key_vault_secret" "examplesecret" {
  name         = "mysecret"
  value        = "segretissimo"
  key_vault_id = azurerm_key_vault.example.id
}