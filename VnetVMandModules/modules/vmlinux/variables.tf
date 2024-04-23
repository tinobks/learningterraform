variable "resource_group_name"{}
    
variable "resource_group_location" {}

variable "size" {
    default = "Standard_B2ms"
    description = "size della macchina virtuale"
}

variable "username" {
    default = "adminlinux"
    description = "username delle vm"
}

variable "password" {
    default = "Pippe!Salate1"
    description = "password delle vm"
}

variable "second_subnet_id" {}