# Storage Account Module

# Data source for existing storage account (when reusing)
data "azurerm_storage_account" "existing" {
  count               = var.storage_reuse ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = var.existing_storage_resource_group_name
}

# Main storage account (create only if not reusing)
resource "azurerm_storage_account" "main" {
  count                = var.storage_reuse ? 0 : 1
  name                 = var.storage_account_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  account_tier         = "Standard"
  account_replication_type = "LRS"
  account_kind         = "StorageV2"
  
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

# Local values for the actual storage account details
locals {
  storage_account_name = var.storage_reuse ? data.azurerm_storage_account.existing[0].name : azurerm_storage_account.main[0].name
  storage_account_id = var.storage_reuse ? data.azurerm_storage_account.existing[0].id : azurerm_storage_account.main[0].id
  storage_account_primary_connection_string = var.storage_reuse ? data.azurerm_storage_account.existing[0].primary_connection_string : azurerm_storage_account.main[0].primary_connection_string
}

# Storage Containers (create if documents container name is provided)
resource "azurerm_storage_container" "documents" {
  count                = var.documents_container_name != "" ? 1 : 0
  name                 = var.documents_container_name
  storage_account_name = local.storage_account_name
  container_access_type = "private"
}

resource "azurerm_storage_container" "images" {
  count                = var.images_container_name != "" ? 1 : 0
  name                 = var.images_container_name
  storage_account_name = local.storage_account_name
  container_access_type = "private"
}

resource "azurerm_storage_container" "nl2sql" {
  count                = var.nl2sql_container_name != "" ? 1 : 0
  name                 = var.nl2sql_container_name
  storage_account_name = local.storage_account_name
  container_access_type = "private"
}
