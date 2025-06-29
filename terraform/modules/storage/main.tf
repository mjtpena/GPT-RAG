# Storage Account Module

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  
  public_network_access_enabled = var.network_isolation ? false : true
  allow_nested_items_to_be_public = false
  
  blob_properties {
    delete_retention_policy {
      days = 7
    }
    
    container_delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}

# Storage Containers
resource "azurerm_storage_container" "documents" {
  name                  = var.documents_container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "images" {
  name                  = var.images_container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "nl2sql" {
  name                  = var.nl2sql_container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Function App Storage Accounts
resource "azurerm_storage_account" "orchestrator" {
  name                     = "${substr(var.storage_account_name, 0, min(21, length(var.storage_account_name)))}orc"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  
  public_network_access_enabled = var.network_isolation ? false : true
  
  tags = var.tags
}

resource "azurerm_storage_container" "orchestrator_deployment" {
  name                  = "deploymentpackage"
  storage_account_name  = azurerm_storage_account.orchestrator.name
  container_access_type = "private"
}

resource "azurerm_storage_account" "data_ingestion" {
  name                     = "${substr(var.storage_account_name, 0, min(21, length(var.storage_account_name)))}ing"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  
  public_network_access_enabled = var.network_isolation ? false : true
  
  tags = var.tags
}

resource "azurerm_storage_container" "data_ingestion_deployment" {
  name                  = "deploymentpackage"
  storage_account_name  = azurerm_storage_account.data_ingestion.name
  container_access_type = "private"
}
