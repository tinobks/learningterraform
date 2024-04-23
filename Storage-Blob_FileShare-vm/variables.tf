variable "my_resource_group_name" {
  type = string
  default = "tb-pdc-rg"
 
}

variable "region" {
  type    = string
  default = "West Europe"
}

variable "my_Storage_account" {
    type = string
    default = "tbpdcsa2023"
}

variable "my_container" {
    type = string
    default = "tbpdccontainer02"
    description ="Nome del container"
}

variable "admin_username" {
  type    = string
  default = "leof"
}

variable "admin_password" {
  type    = string
  default = "Pippe!Salate1"
}

variable "vm_name" {
  type    = string
  default = "FileServer"
}