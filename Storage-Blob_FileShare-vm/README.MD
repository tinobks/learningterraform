# Descrizione

Il progetto:

1. prevede di usare un account di archiviazione già esistente e lo aggancia con un blocco data, se non si ha un account di archiviazione crearlo usando il progetto "Storage",
1. crea un container,
1. carica un "blob" usando un file contenuto nella cartella corrente,
1. crea una share con file share e ci carica un file presente sul disco locale.

## Versione 01.01

Eliminata, tramite commenti, la crezione del file server.

## File

| Nome | Descrizione|
|-------------------|:---------------------------------------------------:|
| main.tf | Codice Terrform|
| variables.tf | Principali variabili per la parametrizzazione, <br/> Attenzione: configurare bene le variabili |
| outputs.tf | L'output nome dello storage |

## Documentazione di riferimento

- [Terraform azurerm storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [Import e uso](https://developer.hashicorp.com/terraform/cli/import/usage)
- [La ridondanza può essere LRS, ZRS, GRS, GZRS](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)
