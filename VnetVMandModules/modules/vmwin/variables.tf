variable "resource_group_name"{}
    
variable "resource_group_location" {}

variable "size" {
    default = "Standard_B2ms"
    description = "size della macchina virtuale"
}

variable "first_subnet_id" {}