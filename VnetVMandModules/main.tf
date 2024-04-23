# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "myterraformgroup" {
  name     = var.resource_group_name
  location = var.resource_group_location
  }

module "rete" {
    source          = "./modules/network"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    depends_on = [azurerm_resource_group.myterraformgroup]
}


module "vmlinux" {
    source = "./modules/vmlinux"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    second_subnet_id = module.rete.nic_linux_id
    depends_on = [azurerm_resource_group.myterraformgroup, module.rete]
}


module "vmwindows" {
    source = "./modules/vmwin"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    first_subnet_id = module.rete.nic_windows_id
    depends_on = [azurerm_resource_group.myterraformgroup, module.rete]
}