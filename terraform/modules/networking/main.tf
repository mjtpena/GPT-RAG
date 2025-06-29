# Networking Module for GPT-RAG Infrastructure

# Virtual Network
resource "azurerm_virtual_network" "main" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = var.vnet_name
  address_space       = [var.vnet_address]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# AI Subnet
resource "azurerm_subnet" "ai" {
  count                = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                 = var.ai_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main[0].name
  address_prefixes     = [var.ai_subnet_prefix]

  delegation {
    name = "Microsoft.Web.serverFarms"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.CognitiveServices",
    "Microsoft.KeyVault"
  ]
}

# App Integration Subnet
resource "azurerm_subnet" "app_integration" {
  count                = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                 = var.app_int_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main[0].name
  address_prefixes     = [var.app_int_subnet_prefix]

  delegation {
    name = "Microsoft.Web.serverFarms"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.CognitiveServices",
    "Microsoft.KeyVault"
  ]
}

# App Services Subnet
resource "azurerm_subnet" "app_services" {
  count                = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                 = var.app_services_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main[0].name
  address_prefixes     = [var.app_services_subnet_prefix]

  delegation {
    name = "Microsoft.Web.serverFarms"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.CognitiveServices",
    "Microsoft.KeyVault"
  ]
}

# Database Subnet
resource "azurerm_subnet" "database" {
  count                = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                 = var.database_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main[0].name
  address_prefixes     = [var.database_subnet_prefix]

  service_endpoints = [
    "Microsoft.AzureCosmosDB"
  ]
}

# Bastion Subnet
resource "azurerm_subnet" "bastion" {
  count                = var.network_isolation && !var.vnet_reuse && var.deploy_vm ? 1 : 0
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main[0].name
  address_prefixes     = [var.bastion_subnet_prefix]
}

# Private DNS Zones
resource "azurerm_private_dns_zone" "blob" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "documents" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = "privatelink.documents.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "vault" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "websites" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "cognitiveservices" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = "privatelink.cognitiveservices.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "openai" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = "privatelink.openai.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "search" {
  count               = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                = "privatelink.search.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Virtual Network Links for Private DNS Zones
resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  count                 = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                  = "blob-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob[0].name
  virtual_network_id    = azurerm_virtual_network.main[0].id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "documents" {
  count                 = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                  = "documents-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.documents[0].name
  virtual_network_id    = azurerm_virtual_network.main[0].id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vault" {
  count                 = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                  = "vault-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.vault[0].name
  virtual_network_id    = azurerm_virtual_network.main[0].id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "websites" {
  count                 = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                  = "websites-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.websites[0].name
  virtual_network_id    = azurerm_virtual_network.main[0].id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "cognitiveservices" {
  count                 = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                  = "cognitiveservices-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.cognitiveservices[0].name
  virtual_network_id    = azurerm_virtual_network.main[0].id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "openai" {
  count                 = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                  = "openai-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.openai[0].name
  virtual_network_id    = azurerm_virtual_network.main[0].id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "search" {
  count                 = var.network_isolation && !var.vnet_reuse ? 1 : 0
  name                  = "search-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.search[0].name
  virtual_network_id    = azurerm_virtual_network.main[0].id
  tags                  = var.tags
}
