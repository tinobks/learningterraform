#------------------------------------------------------------------------------
# Create P2S VPN Gateway connections - certificate authentication 
# Use objects and variables created by main and networkbase 
# but for reuse it recall all resourse needded using a data block
# The VPN Gateway will be deployed into VNet01 GatewaySubnet
#------------------------------------------------------------------------------
data "azurerm_resource_group" "vpnRG"{
    name        = azurerm_resource_group.rg.name  
}

data "azurerm_virtual_network" "vpnvnet" {
  name = azurerm_virtual_network.firstvnet.name
  resource_group_name = data.azurerm_resource_group.vpnRG.name
}
data "azurerm_subnet" "vpnsub" {
  name = azurerm_subnet.firstvnetsub2.name
  resource_group_name = data.azurerm_resource_group.vpnRG.name
  virtual_network_name = data.azurerm_virtual_network.vpnvnet.name
}
# Create Public IP for VPN Gateway 
resource "azurerm_public_ip" "vpnPiptf" {
    name                         = "vpnpip"
    location                     = data.azurerm_virtual_network.vpnvnet.location
    resource_group_name          = data.azurerm_resource_group.vpnRG.name
    allocation_method            = "Dynamic"

}

# Crete VPN Gateway
resource "azurerm_virtual_network_gateway" "vpngateway" {
  name                = "VNet1GW"
  location            = data.azurerm_virtual_network.myvnet.location
  resource_group_name = data.azurerm_virtual_network.myvnet.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw2"
  generation    = "Generation2"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpnPiptf.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.vpnsub.id
  }

  vpn_client_configuration {
    address_space = ["172.16.101.0/24"]

    root_certificate {
      name = "p2s-jvn-root-cert"

      public_cert_data = <<EOF
MIIC5zCCAc+gAwIBAgIQLy7FUhxscLlMT3XNeGiD9zANBgkqhkiG9w0BAQsFADAW
MRQwEgYDVQQDDAtQMlNSb290Q2VydDAeFw0yNDA0MTIxMDAxMjlaFw0yNjA0MTIx
MDExMjlaMBYxFDASBgNVBAMMC1AyU1Jvb3RDZXJ0MIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAxfYR1yTgJvU50ed+UheFFdzntSxAbsfq0h2qhrYDnNrm
EeCpTT02er+rY1xHhhNs/pD0d1EDkiHjTm17jCsieRw8hnAs5aS3HT7O9GrMIznO
hoEMY8qGeVwMRs3CRpSlhxSmyccEpuOQT/P6mhH9z5956BVyQXVFtQiFwri7QP/8
gndIfk7TOmMKJT61q9D91hYHal+7bLo/FWF1UuqX98T6NE6sxCyksic1yPcwWvBy
66mFZC3nZs4SShz6ExY3dm3j+5z4XMjieqwuJJ3DfXuMVq7UOCUdLO7AZsTEi+zI
k3v1QMVyMlFRMGH8z5uLNdM1pvqXd+brVla17wiaoQIDAQABozEwLzAOBgNVHQ8B
Af8EBAMCAgQwHQYDVR0OBBYEFI+hnDpP3ZG2e3bKnPDfdnnDvxmfMA0GCSqGSIb3
DQEBCwUAA4IBAQDBJQJvfvIuGjL35mU9X4Uj6h3E31R03vGaps0rhlGocuIZI/i1
s6/xsTa9TTViEr7LPABATftBjPllK8gzirZu9HLwJxo3dSpz2R63qNOl7d+GfZSb
bllzWjHhALiIZlFaGkeMhZYE4KLQYYEbN3zRgE6at7lQG8i10AWMVil96b7YF53m
mqNlcorJumA9wbgul6w4dFUFhaDqbu4XhKPGsa6vBR+vMofoQIxxFQSicMMnJU0I
BHcjdikKHHoN5wxBScweXORGLnor1a6u75RERJR+PpTjl3X8+hHCvgYaDBEq22Xx
K7DDVFfdyGwT048YlHYUe30864HkmNgFsFXo
EOF
    }
  }
}