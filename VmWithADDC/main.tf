terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.100.0"
    }

   random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }


}

# 3.47.0
provider "azurerm" {
 features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

#Creates the Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}

#Creates the Azure Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "testvm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["192.168.10.0/24"]
}

#Creates the subnet
resource "azurerm_subnet" "testvmsubnet" {
  name                 = "testvmsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.10.0/24"]
}

#Creates a vNIC for the VM
resource "azurerm_network_interface" "dc01_nic" {
  name                = "dc01_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "dc01_nic"
    subnet_id                     = azurerm_subnet.testvmsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id #Added by ca
  }
}
#------------- begin added -------------------
# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Dynamic"

}
# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "myNetworkSecurityGroup"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name

    security_rule {
        name                       = "AllowRDP"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

}
# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.dc01_nic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}
#------------- end added ---------------------
#Creates the Azure VM
resource "azurerm_windows_virtual_machine" "dc01" {
  name                = "DC01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.size
  admin_username      = var.win_username
  admin_password      = data.azurerm_key_vault_secret.mysecret.value
  network_interface_ids = [
    azurerm_network_interface.dc01_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

#Install Active Directory on the DC01 VM
resource "azurerm_virtual_machine_extension" "install_ad" {
  name                 = "install_ad"
#  resource_group_name  = azurerm_resource_group.main.name
  virtual_machine_id   = azurerm_windows_virtual_machine.dc01.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.ADDS.rendered)}')) | Out-File -filepath ADDS.ps1\" && powershell -ExecutionPolicy Unrestricted -File ADDS.ps1 -Domain_DNSName ${data.template_file.ADDS.vars.Domain_DNSName} -Domain_NETBIOSName ${data.template_file.ADDS.vars.Domain_NETBIOSName} -SafeModeAdministratorPassword ${data.template_file.ADDS.vars.SafeModeAdministratorPassword}"
  }
  SETTINGS
}

#Variable input for the ADDS.ps1 script
data "template_file" "ADDS" {
    template = "${file("ADDS.ps1")}"
    vars = {
        Domain_DNSName          = "${var.Domain_DNSName}"
        Domain_NETBIOSName      = "${var.netbios_name}"
        SafeModeAdministratorPassword = "${data.azurerm_key_vault_secret.mysecret.value}"
  }
}

#Export public IP By Cosimo
data "azurerm_public_ip" "myterraformpublicip" {
  name                = azurerm_public_ip.myterraformpublicip.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_windows_virtual_machine.dc01]
}
output "public_ip_address" {
  value = data.azurerm_public_ip.myterraformpublicip.ip_address
}