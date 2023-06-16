resource "azurerm_virtual_network" "vnet" {
  name                = "vnet_${replace(var.ARM_RG_NAME,"-","_")}"
  location            = var.devops_sb_resource_group_location
  resource_group_name = var.ARM_RG_NAME
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
#  vnet_subnet_id      = data.azurerm_subnet.aks_sbn_data.id

  #  subnet {
  #    name           = "snet-appcs"
  #    address_prefix = "10.0.1.0/24"
  #  }

#   subnet {
#     name           = "subnet2"
#     address_prefix = "10.0.2.0/24"
#     security_group = azurerm_network_security_group.example.id
#   }

  tags = {
    environment = "var.environment"
  }
}

resource "azurerm_subnet" "snet" {
  name                 = "snet-devops-sandbox"
  resource_group_name  = var.ARM_RG_NAME
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
