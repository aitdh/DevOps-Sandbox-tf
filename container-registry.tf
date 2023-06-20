resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  sku                 = "Basic"
  admin_enabled       = false
}