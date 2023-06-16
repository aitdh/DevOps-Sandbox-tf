resource "azurerm_mssql_server" "dummy_sql_db_server" {
  name                         = "devops-sandbox-sql-server-dh"
  resource_group_name          = var.ARM_RG_NAME
  location                     = var.devops_sb_resource_group_location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "dummy_sql_db" {
  name           = "devops-sandbox-sqldb-dh"
  server_id      = azurerm_mssql_server.dummy_sql_db_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = false
  sku_name       = "Basic"
  zone_redundant = false

  tags = {
    environment = "var.environment"
  }
}