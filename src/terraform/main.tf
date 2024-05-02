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

resource "azurerm_cosmosdb_account" "tiulanches_account" {
  name                = "tiulanches-pagamentos"
  location            = azurerm_resource_group.tiulanches_db_rg.location
  resource_group_name = azurerm_resource_group.tiulanches_db_rg.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  capabilities {
    name = "EnableMongo"
  }

  capabilities {
    name = "EnableMongoRoleBasedAccessControl"
  }

  consistency_policy {
    consistency_level = "Strong"
  }

  geo_location {
    location          = azurerm_resource_group.tiulanches_db_rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "tiulanches_mongodb" {
  name                = "tlpagamento"
  resource_group_name = azurerm_cosmosdb_account.tiulanches_account.resource_group_name
  account_name        = azurerm_cosmosdb_account.tiulanches_account.name
}

resource "azurerm_cosmosdb_mongo_user_definition" "tiulanches_definition" {
  cosmos_mongo_database_id = azurerm_cosmosdb_mongo_database.tiulanches_mongodb.id
  username                 = var.db_username
  password                 = var.db_password
}