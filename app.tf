resource "azurerm_service_plan" "service-plan" {
  name                = "asp-${var.devops_sb_resource_group_location}-${var.environment}-${var.app_name}"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "web-app" {
  name                = "app-${var.devops_sb_resource_group_location}-${var.environment}-${var.app_name}"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  service_plan_id     = azurerm_service_plan.service-plan.id

  site_config { 
    minimum_tls_version = "1.2"
    always_on = false
    application_stack {
      dotnet_version = "6.0"
    }
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "dummy_app_net_switf" {
  app_service_id = azurerm_linux_web_app.web-app.id
  subnet_id      = azurerm_subnet.webapp_snet.id
}