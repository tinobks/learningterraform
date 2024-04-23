variable "resource_group_name"{}
    
variable "resource_group_location" {}

variable "pip_name_firstsubnet" {
    default = "pip_firstsub"
    description = "Indirizzo IP pubblico della prima subnet"
}

variable "pip_name_secondsubnet" {
    default = "pip_secondsub"
    description = "Indirizzo IP pubblico della seconda subnet"
}

variable "vnet_name" {
  description = "nome della VNET"
  default     = "myVnet"
}

variable "firstsubnet_name" {
  description = "nome della prima subnet"
  default     = "subnet1"
}

variable "secondsubnet_name" {
  description = "nome della seconda subnet"
  default     = "subnet2"
}
