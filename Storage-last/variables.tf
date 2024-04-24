variable "my_resource_group" {
    type = map(string)
    default = {
        name = "rg"
        location = "Switzerland North"
    }
    description = "Nome e Locazione del Resource Group da creare."
}

variable "my_storage_account" {
    type = string
    default = "tbstorage24042024"
}

variable "my_container" {
    type = string
    default = "tbpdccontainer"
    description ="Nome del Container"
}

variable "myshare" {
    type = string
    default = "tbshare2024"
    description ="Nome del Share"
}

variable "mytable" {
    type = string
    default = "tabellatemperature"
    description ="Nome della tabella"
}