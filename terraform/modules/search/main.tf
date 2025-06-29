# Azure Search Service Module

resource "azurerm_search_service" "main" {
  name                = var.search_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.search_service_sku_name

  public_network_access_enabled = var.network_isolation ? false : true
  
  # Enable managed identity
  identity {
    type = "SystemAssigned"
  }

  # Authentication options
  authentication_failure_mode = "http401WithBearerChallenge"
  
  # Semantic search configuration
  semantic_search_sku = var.use_semantic_reranking ? "free" : null

  tags = var.tags
}

# Store Search service key in Key Vault
resource "azurerm_key_vault_secret" "search_key" {
  name         = "azureSearchKey"
  value        = azurerm_search_service.main.primary_key
  key_vault_id = var.key_vault_id
}

# Search service shared private link resources for network isolation
resource "azurerm_search_shared_private_link_resource" "openai" {
  count               = var.network_isolation ? 1 : 0
  name                = "${var.search_service_name}-aoailink-${var.resource_token}"
  search_service_id   = azurerm_search_service.main.id
  subresource_name    = "openai_account"
  target_resource_id  = var.openai_resource_id
  request_message     = "Please approve this private link connection for Azure OpenAI"
}

resource "azurerm_search_shared_private_link_resource" "storage" {
  count               = var.network_isolation ? 1 : 0
  name                = "${var.search_service_name}-storagelink-${var.resource_token}"
  search_service_id   = azurerm_search_service.main.id
  subresource_name    = "blob"
  target_resource_id  = var.storage_account_id
  request_message     = "Please approve this private link connection for Storage Account"
  
  depends_on = [azurerm_search_shared_private_link_resource.openai]
}

resource "azurerm_search_shared_private_link_resource" "function_app" {
  count               = var.network_isolation ? 1 : 0
  name                = "${var.search_service_name}-funcapplink-${var.resource_token}"
  search_service_id   = azurerm_search_service.main.id
  subresource_name    = "sites"
  target_resource_id  = var.data_ingestion_function_id
  request_message     = "Please approve this private link connection for Function App"
  
  depends_on = [azurerm_search_shared_private_link_resource.storage]
}
