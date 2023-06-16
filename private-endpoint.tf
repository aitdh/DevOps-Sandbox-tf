# Create a Private DNS Zone
resource "azurerm_private_dns_zone" "db_private_dns" {
  name = "privatelink.database.windows.net"
  resource_group_name = var.ARM_RG_NAME
}
# Link the Private DNS Zone with the VNET
resource "azurerm_private_dns_zone_virtual_network_link" "db_private_dns_link" {
  name = "${var.devops_sb_resource_group_location}-${var.environment}-${var.private_dns_link_name}"
  resource_group_name = var.ARM_RG_NAME
  private_dns_zone_name = azurerm_private_dns_zone.db_private_dns.name
  virtual_network_id = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "db_private_endpoint" {
  name                = "${var.devops_sb_resource_group_location}-${var.environment}-db-private-endpoint"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
  subnet_id           = azurerm_subnet.snet.id

  private_service_connection {
    name                           = "db-privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.dummy_sql_db_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.devops_sb_resource_group_location}-${var.environment}-db-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.db_private_dns.id]
  }
}
