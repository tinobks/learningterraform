# Descrizione

Il progetto:

1. crea un account di archiviazione,
1. un container e 
1. carica un "blob" usando un file contenuto nella cartella corrente.

## File

| Nome | Descrizione|
|-------------------|:---------------------------------------------------:|
| main.tf | Codice Terrform|
| variables.tf | Principali variabili per la parametrizzazione |
| outputs.tf | L'output del tier dello storage |

## Documentazione di riferimento

- [Terraform azurerm storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [Import e uso](https://developer.hashicorp.com/terraform/cli/import/usage)
- [La ridondanza può essere LRS, ZRS, GRS, GZRS](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)
