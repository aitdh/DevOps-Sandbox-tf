resource "azurerm_app_configuration" "appconf" {
  name                = "appconf-${var.devops_sb_resource_group_location}-${var.environment}"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
}