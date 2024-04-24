# data Block per importare secret di una keyvault esistente in un altro gruppo di risorse

data "azurerm_key_vault_secret" "examplesecret" {
    name = "mysecret"

    #modificare mettendo la propria sub id, nome del rg dove risiede la keyvault e nome della keyvault
    #key_vault_id = "/subscriptions/<subscription_id>/resourceGroups/<nome_rg>/providers/Microsoft.KeyVault/vaults/<nome_keyvault>"
    key_vault_id = "/subscriptions/xxxxxxxxx-xxxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tb-rg/providers/Microsoft.KeyVault/vaults/tbkeyvault24042024"
}

output "secretvalue" {
  value = data.azurerm_key_vault_secret.examplesecret.value
  sensitive = true
}
