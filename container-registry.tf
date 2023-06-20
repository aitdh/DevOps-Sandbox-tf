resource "azurerm_container_registry" "acr" {
  name                = "dhacrdevopssandbox"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  sku                 = "Basic"
  admin_enabled       = false

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_mngd_id.id
    ]
  }
}

resource "azurerm_user_assigned_identity" "acr_mngd_id" {
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location

  name = "dh-devops-registry-uai"
}