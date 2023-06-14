# Create a Private DNS Zone
resource "azurerm_private_dns_zone" "db-private-dns" {
  name = "${var.devops_sb_resource_group_location}-${var.environment}-${var.private_network_name}"
  resource_group_name = var.ARM_RG_NAME
}
# Link the Private DNS Zone with the VNET
resource "azurerm_private_dns_zone_virtual_network_link" "db-private-dns-link" {
  name = "${var.devops_sb_resource_group_location}-${var.environment}-${var.private_dns_link_name}"
  resource_group_name = var.ARM_RG_NAME
  private_dns_zone_name = "${var.devops_sb_resource_group_location}-${var.environment}-${var.private_network_name}"
  virtual_network_id = azurerm_virtual_network.vnet.id
}
# Create a DB Private DNS Zone
resource "azurerm_private_dns_zone" "db-endpoint-dns-private-zone" {
  name = "${var.private_dns_link_name}.database.windows.net"
  resource_group_name = var.ARM_RG_NAME
}