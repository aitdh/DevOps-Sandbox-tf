resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}.${var.ARM_RG_NAME}"
  location            = var.devops_sb_resource_group_location
  resource_group_name = var.ARM_RG_ID
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
#  vnet_subnet_id      = data.azurerm_subnet.aks_sbn_data.id

   subnet {
     name           = "snet-appcs"
     address_prefix = "10.0.1.0/24"
   }

#   subnet {
#     name           = "subnet2"
#     address_prefix = "10.0.2.0/24"
#     security_group = azurerm_network_security_group.example.id
#   }

  tags = {
    environment = "Sandbox"
  }
}