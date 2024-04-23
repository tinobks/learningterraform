variable "my_resource_group" {
    type = map(string)
    default = {
        nome = "tb-pdc-rg"
        location = "West Europe"
    }
    description = "Nome e Locazione del Resource Group da creare."
}
variable "my_Storage_account" {
    type = string
    default = "tbpdcsa2023"
}
variable "my_container" {
    type = string
    default = "tbpdccontainer01"
    description ="Nome del Container"
}