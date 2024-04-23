resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = var.vnet_name
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "firstsubnet" {
    name                 = var.firstsubnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "secondsubnet" {
    name                 = var.secondsubnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "public_ip_firstsubnet" {
    name                = "public-ip-firstsubnet"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    allocation_method   = "Static" 
}

resource "azurerm_public_ip" "public_ip_secondsubnet" {
    name                = "public-ip-secondsubnet"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "mynsg"
    location            = "eastus"
    resource_group_name = var.resource_group_name

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

resource "azurerm_subnet_network_security_group_association" "firstassociation" {
    subnet_id                 = azurerm_subnet.firstsubnet.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

resource "azurerm_subnet_network_security_group_association" "secondassociation" {
    subnet_id                 = azurerm_subnet.secondsubnet.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

#create NIC
resource "azurerm_network_interface" "nic_windows" {
    name                = "nic1"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.firstsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public_ip_firstsubnet.id
    }
}

resource "azurerm_network_interface" "nic_linux" {
    name                = "nic2"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.secondsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public_ip_secondsubnet.id
    }
}

