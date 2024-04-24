variable "resource_group" {
    type = string
    description = "Resource group name"
    default = "TestAzVM"
}

variable "location" {
    type = string
    description = "RG and resources location"
    default = "Switzerland North"
}

variable "win_username" {
  description = "Windows node username"
  type        = string
  sensitive   = false
  default = "tb"
}

variable "Domain_DNSName" {
  description = "FQDN for the Active Directory forest root domain"
  type        = string
  sensitive   = false
  default = "dom.it"
}

variable "netbios_name" {
  description = "NETBIOS name for the AD domain"
  type        = string
  sensitive   = false
  default = "dom"
}

variable "SafeModeAdministratorPassword" {
  description = "Password for AD Safe Mode recovery"
  type        = string
  sensitive   = true
  default     = "Pippe!Salate123"
}

variable "size" {
  description = "Size of the VM"
  type        = string
  sensitive   = false
  default = "Standard_B2ms"
}