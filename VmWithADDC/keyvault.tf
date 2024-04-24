# data Block per importare secret di una keyvault esistente in un altro gruppo di risorse
data "azurerm_key_vault" "kv" {
    name = "tbkeyvault042024cpe"
    resource_group_name = "tb-rg"
}
data "azurerm_key_vault_secret" "mysecret" {
    name = "mysecret"
    key_vault_id = data.azurerm_key_vault.kv.id
}

output "secretvalue" {
  value = data.azurerm_key_vault_secret.mysecret.value
  sensitive = true
}