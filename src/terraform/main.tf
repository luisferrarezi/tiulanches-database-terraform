resource "azurerm_resource_group" "tiulanches_db_rg" {
  name     = "tiulanches_db_rg"
  location = "brazilsouth"
}

resource "azurerm_mysql_server" "tiulanches_mysql_srv" {
  name                = "tiulanchessrv"
  location            = azurerm_resource_group.tiulanches_db_rg.location
  resource_group_name = azurerm_resource_group.tiulanches_db_rg.name

  administrator_login          = var.db_username
  administrator_login_password = var.db_password

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "8.0"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}
