# Scopo

L'obiettivo del progetto è creare due Virtual Network in Peering con una VPN nella prima.
Si distribuiscono anche due Windows Server per effettuare le prove.
Le password dei due Windows Server sono stati presi da un secret all'interno di una keyvault esistente in un altro gruppo di risorse.
I server sono dotati di un IP pubblico ed hanno le porte RDP abilitate.
Dopo la distribuzione bisogna scaricare il software disponibile nel portale per la connessione VPN punto-sito.
Testare la connessione RDP prima tramite gli IP privati via VPN e poi con gli IP pubblici.

## Attenzione

Per eseguire l'esercizio bisogna avere un certificato a disposizione (se non c'è crearlo con lo script PS) e di una keyvault con una secret da usare come password delle due macchine virtuali da creare.


## Elenco file

| File | Descrizione |
|-------------------|----------------------------------------|
| main.tf | Dichiara solo il provider e crea il gruppo di risorse |
| variables.tf | Varibili per main.tf |
| varnetworkbase.tf| Definisce le variabili per le virtual network |
| networkbase.tf | Crea le virtual network e le subnet |
| vpn.tf | Crea una VPN punto-sito |
| peering.tf | Crea il peering tra le due vnet tenendo conto della VPN |
| pdc01. tf <br/> pdc02.tf | Creano i due server |
| ExportedTemplate-ca-vpnpeering-rg.zip | Template JSON di una distribuzione|
| ca-vpnpeering-rg.png | Visualizzazione grafica della distribuzione|
| keyvault.tf | Importa il secret di una keyvault esistente da usare come password|

