resource "azurerm_container_registry" "acr" {
  name                = "dhacrdevopssandbox"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  sku                 = "Basic"
  admin_enabled       = false

  # identity {
  #   type = "UserAssigned"
  #   identity_ids = [
  #     azurerm_user_assigned_identity.acr_mngd_id.id
  #   ]
  # }
}

# resource "azurerm_user_assigned_identity" "acr_mngd_id" {
#   resource_group_name = var.ARM_RG_NAME
#   location            = var.devops_sb_resource_group_location

#   name = "dh-devops-registry-uai"
# }

# resource "azuread_application_federated_identity_credential" "example" {
#   application_object_id = azurerm_user_assigned_identity.acr_mngd_id.object_id
#   display_name          = "Image Build"
#   description           = "Builds Docker images and pushes them to our custom registry"
#   audiences             = ["api://AzureADTokenExchange"]
#   issuer                = "https://token.actions.githubusercontent.com"
#   subject               = "repo:aitdh/DevOps-Sample-App"
# }

# resource "azurerm_role_definition" "role_acr_contributor" {
#   name        = "Custom AcrContributor ${var.environment}"
#   scope       = azurerm_container_registry.acr.id
#   description = "Allows users to create Azure Container Registry repositories."

#   permissions {
#     actions = [
#       "Microsoft.ContainerRegistry/registries/listCredentials/action",
#       "Microsoft.ContainerRegistry/registries/write",
#       "Microsoft.ContainerRegistry/registries/pull/read",
#       "Microsoft.ContainerRegistry/registries/push/write",
#       "Microsoft.ContainerRegistry/registries/artifacts/delete"
#     ]
#   }
#   depends_on = [azurerm_container_registry.acr]
# }

data "azuread_service_principal" "sp" {
        application_id  = var.SP_APPLICATION_ID
}

resource "azurerm_role_assignment" "role_acr_contributor_assign" {
  scope                = azurerm_container_registry.acr.id
  # role_definition_name = "Custom AcrContributor ${var.environment}"
  role_definition_name = "*"
  principal_id         = data.azuread_service_principal.sp.id
  # depends_on           = [azurerm_role_definition.role_acr_contributor]
}