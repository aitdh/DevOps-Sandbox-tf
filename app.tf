resource "azurerm_service_plan" "service-plan" {
  name                = "asp-${var.devops_sb_resource_group_location}-${var.environment}-${var.app_name}"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "web-app" {
  name                = "app-${var.devops_sb_resource_group_location}-${var.environment}-${var.app_name}"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  service_plan_id     = azurerm_service_plan.service-plan.id

  site_config {
    dotnet_framework_version = "v6.0"
  }

  tags = {
    environment = var.environment
  }
}