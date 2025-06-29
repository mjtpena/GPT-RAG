# Private Endpoints Module

# Storage Account Private Endpoint
resource "azurerm_private_endpoint" "storage" {
  count               = var.network_isolation ? 1 : 0
  name                = var.storage_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.ai_subnet_id

  private_service_connection {
    name                           = "${var.storage_pe_name}-connection"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.blob_dns_zone_id]
  }

  tags = var.tags
}

# Cosmos DB Private Endpoint
resource "azurerm_private_endpoint" "cosmos" {
  count               = var.network_isolation ? 1 : 0
  name                = var.cosmos_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.database_subnet_id

  private_service_connection {
    name                           = "${var.cosmos_pe_name}-connection"
    private_connection_resource_id = var.cosmos_account_id
    subresource_names              = ["Sql"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.documents_dns_zone_id]
  }

  tags = var.tags
}

# Key Vault Private Endpoint
resource "azurerm_private_endpoint" "keyvault" {
  count               = var.network_isolation ? 1 : 0
  name                = var.keyvault_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.ai_subnet_id

  private_service_connection {
    name                           = "${var.keyvault_pe_name}-connection"
    private_connection_resource_id = var.key_vault_id
    subresource_names              = ["Vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.vault_dns_zone_id]
  }

  tags = var.tags
}

# OpenAI Private Endpoint
resource "azurerm_private_endpoint" "openai" {
  count               = var.network_isolation ? 1 : 0
  name                = var.openai_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.ai_subnet_id

  private_service_connection {
    name                           = "${var.openai_pe_name}-connection"
    private_connection_resource_id = var.openai_account_id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.openai_dns_zone_id]
  }

  tags = var.tags
}

# AI Services Private Endpoint
resource "azurerm_private_endpoint" "ai_services" {
  count               = var.network_isolation ? 1 : 0
  name                = var.ai_services_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.ai_subnet_id

  private_service_connection {
    name                           = "${var.ai_services_pe_name}-connection"
    private_connection_resource_id = var.ai_services_account_id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.cognitiveservices_dns_zone_id]
  }

  tags = var.tags
}

# Search Service Private Endpoint
resource "azurerm_private_endpoint" "search" {
  count               = var.network_isolation ? 1 : 0
  name                = var.search_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.ai_subnet_id

  private_service_connection {
    name                           = "${var.search_pe_name}-connection"
    private_connection_resource_id = var.search_service_id
    subresource_names              = ["searchService"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.search_dns_zone_id]
  }

  tags = var.tags
}

# Orchestrator Function App Private Endpoint
resource "azurerm_private_endpoint" "orchestrator" {
  count               = var.network_isolation ? 1 : 0
  name                = var.orchestrator_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.app_services_subnet_id

  private_service_connection {
    name                           = "${var.orchestrator_pe_name}-connection"
    private_connection_resource_id = var.orchestrator_function_id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.websites_dns_zone_id]
  }

  tags = var.tags
}

# Data Ingestion Function App Private Endpoint
resource "azurerm_private_endpoint" "data_ingestion" {
  count               = var.network_isolation ? 1 : 0
  name                = var.data_ingestion_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.app_services_subnet_id

  private_service_connection {
    name                           = "${var.data_ingestion_pe_name}-connection"
    private_connection_resource_id = var.data_ingestion_function_id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.websites_dns_zone_id]
  }

  tags = var.tags
}

# Frontend App Service Private Endpoint
resource "azurerm_private_endpoint" "frontend" {
  count               = var.network_isolation ? 1 : 0
  name                = var.frontend_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.app_services_subnet_id

  private_service_connection {
    name                           = "${var.frontend_pe_name}-connection"
    private_connection_resource_id = var.frontend_app_id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.websites_dns_zone_id]
  }

  tags = var.tags
}

# Function App Storage Account Private Endpoints
resource "azurerm_private_endpoint" "orchestrator_storage" {
  count               = var.network_isolation ? 1 : 0
  name                = "${var.storage_pe_name}orc"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.app_services_subnet_id

  private_service_connection {
    name                           = "${var.storage_pe_name}orc-connection"
    private_connection_resource_id = var.orchestrator_storage_account_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.blob_dns_zone_id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "data_ingestion_storage" {
  count               = var.network_isolation ? 1 : 0
  name                = "${var.storage_pe_name}ing"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.app_services_subnet_id

  private_service_connection {
    name                           = "${var.storage_pe_name}ing-connection"
    private_connection_resource_id = var.data_ingestion_storage_account_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.blob_dns_zone_id]
  }

  tags = var.tags
}
