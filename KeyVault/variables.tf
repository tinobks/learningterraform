variable "my_resource_group" {
    type = map(string)
    default = {
        nome = "tb-pdc-rg"
        location = "West Europe"
    }
    description = "Nome e Locazione del Resource Group da creare."
}