resource "azurerm_container_registry" "acr" {
  name                = "dhacrdevopssandbox"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  sku                 = "Premium"
  admin_enabled       = true
}

#https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles?WT.mc_id=AZ-MVP-5004151
resource "azurerm_role_assignment" "role_acr_contributor_assign" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrImageSigner"
  principal_id         = var.SP_ACR_OBJ_ID
  # depends_on           = [azurerm_role_definition.role_acr_contributor]
}