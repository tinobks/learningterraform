# Esercizio 02 Terraform - 24/04/2024

Utilizzando Terraform creare un account di archiviazione e in esso:
1.	Creare un container e caricare un file come blob;
2.	Creare una share e caricare un file
3.	Creare un tabella per caricare all’interno le temperature di Roma, Milano, Genova;
4.	Creare una coda di messaggi.

## File (post completamento esercizio)

| Nome | Descrizione|
|-------------------|:---------------------------------------------------:|
| main.tf      | Codice Terraform per creare resource group e storage account|
| variables.tf      | Codice Terraform delle principali variabili per la parametrizzazione|


## Documentazione

- [Terraform azurerm storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [Import e uso](https://developer.hashicorp.com/terraform/cli/import/usage)
- [La ridondanza può essere LRS, ZRS, GRS, GZRS](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)
- [Terraform azurerm table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table_entity)
- [Terraform azurerm queues](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue)
