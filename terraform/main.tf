# GPT-RAG Infrastructure - Terraform Configuration
# This file replaces the main.bicep file for deploying GPT-RAG infrastructure

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Data sources
data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

# Generate unique resource token
resource "random_string" "resource_token" {
  length  = 13
  upper   = false
  special = false
}

# Local values for computed names and configurations
locals {
  resource_token = lower(random_string.resource_token.result)
  
  # Resource group name
  resource_group_name = var.resource_group_name != "" ? var.resource_group_name : "rg-${var.environment_name}"
  
  # Resource reuse logic matching Bicep
  azure_reuse_config = var.azure_reuse_config
  
  # Generate resource names with reuse logic
  key_vault_name = var.azure_reuse_config.key_vault_reuse ? var.azure_reuse_config.existing_key_vault_name : (var.key_vault_name != "" ? var.key_vault_name : "kv0-${local.resource_token}")
  storage_account_name = var.azure_reuse_config.storage_reuse ? var.azure_reuse_config.existing_storage_name : (var.storage_account_name != "" ? var.storage_account_name : "strag0${local.resource_token}")
  openai_service_name = var.azure_reuse_config.aoai_reuse ? var.azure_reuse_config.existing_aoai_name : (var.openai_service_name != "" ? var.openai_service_name : "oai0-${local.resource_token}")
  ai_services_name = var.azure_reuse_config.ai_services_reuse ? var.azure_reuse_config.existing_ai_services_name : (var.ai_services_name != "" ? var.ai_services_name : "ai0-${local.resource_token}")
  app_service_plan_name = var.azure_reuse_config.app_service_plan_reuse ? var.azure_reuse_config.existing_app_service_plan_name : (var.app_service_plan_name != "" ? var.app_service_plan_name : "appplan0-${local.resource_token}")
  app_insights_name = var.azure_reuse_config.app_insights_reuse ? var.azure_reuse_config.existing_app_insights_name : (var.app_insights_name != "" ? var.app_insights_name : "appins0-${local.resource_token}")
  app_service_name = var.azure_reuse_config.app_service_reuse ? var.azure_reuse_config.existing_app_service_name : (var.app_service_name != "" ? var.app_service_name : "webgpt0-${local.resource_token}")
  orchestrator_function_name = var.azure_reuse_config.orchestrator_function_app_reuse ? var.azure_reuse_config.existing_orchestrator_function_app_name : (var.orchestrator_function_app_name != "" ? var.orchestrator_function_app_name : "fnorch0-${local.resource_token}")
  data_ingestion_function_name = var.azure_reuse_config.data_ingestion_function_app_reuse ? var.azure_reuse_config.existing_data_ingestion_function_app_name : (var.data_ingestion_function_app_name != "" ? var.data_ingestion_function_app_name : "fninges0-${local.resource_token}")
  search_service_name = var.azure_reuse_config.ai_search_reuse ? var.azure_reuse_config.existing_ai_search_name : (var.search_service_name != "" ? var.search_service_name : "search0-${local.resource_token}")
  cosmos_account_name = var.azure_reuse_config.cosmos_db_reuse ? var.azure_reuse_config.existing_cosmos_db_account_name : (var.azure_db_config.db_account_name != "" ? var.azure_db_config.db_account_name : "dbgpt0-${local.resource_token}")
  cosmos_database_name = var.azure_reuse_config.cosmos_db_reuse ? var.azure_reuse_config.existing_cosmos_db_database_name : (var.azure_db_config.db_database_name != "" ? var.azure_db_config.db_database_name : "db0-${local.resource_token}")
  load_testing_name = var.load_testing_name != "" ? var.load_testing_name : "loadtest0-${local.resource_token}"
  
  # Function app storage accounts
  orchestrator_storage_name = var.azure_reuse_config.orchestrator_function_app_storage_reuse ? var.azure_reuse_config.existing_orchestrator_function_app_storage_name : "${local.storage_account_name}orc"
  data_ingestion_storage_name = var.azure_reuse_config.data_ingestion_function_app_storage_reuse ? var.azure_reuse_config.existing_data_ingestion_function_app_storage_name : "${local.storage_account_name}ing"
  
  # Resource group names for reused resources
  key_vault_resource_group_name = var.azure_reuse_config.key_vault_reuse ? var.azure_reuse_config.existing_key_vault_resource_group_name : local.resource_group_name
  storage_resource_group_name = var.azure_reuse_config.storage_reuse ? var.azure_reuse_config.existing_storage_resource_group_name : local.resource_group_name
  openai_resource_group_name = var.azure_reuse_config.aoai_reuse ? var.azure_reuse_config.existing_aoai_resource_group_name : local.resource_group_name
  ai_services_resource_group_name = var.azure_reuse_config.ai_services_reuse ? var.azure_reuse_config.existing_ai_services_resource_group_name : local.resource_group_name
  app_insights_resource_group_name = var.azure_reuse_config.app_insights_reuse ? var.azure_reuse_config.existing_app_insights_resource_group_name : local.resource_group_name
  search_resource_group_name = var.azure_reuse_config.ai_search_reuse ? var.azure_reuse_config.existing_ai_search_resource_group_name : local.resource_group_name
  cosmos_resource_group_name = var.azure_reuse_config.cosmos_db_reuse ? var.azure_reuse_config.existing_cosmos_db_resource_group_name : local.resource_group_name
  orchestrator_function_resource_group_name = var.azure_reuse_config.orchestrator_function_app_reuse ? var.azure_reuse_config.existing_orchestrator_function_app_resource_group_name : local.resource_group_name
  data_ingestion_function_resource_group_name = var.azure_reuse_config.data_ingestion_function_app_reuse ? var.azure_reuse_config.existing_data_ingestion_function_app_resource_group_name : local.resource_group_name
  orchestrator_storage_resource_group_name = var.azure_reuse_config.orchestrator_function_app_storage_reuse ? var.azure_reuse_config.existing_orchestrator_function_app_storage_resource_group_name : local.resource_group_name  
  data_ingestion_storage_resource_group_name = var.azure_reuse_config.data_ingestion_function_app_storage_reuse ? var.azure_reuse_config.existing_data_ingestion_function_app_storage_resource_group_name : local.resource_group_name
  
  # Network settings with reuse logic
  vnet_name = var.azure_reuse_config.vnet_reuse ? var.azure_reuse_config.existing_vnet_name : (var.vnet_name != "" ? var.vnet_name : "aivnet0-${local.resource_token}")
  vnet_address = var.vnet_address != "" ? var.vnet_address : "10.0.0.0/23"
  vnet_resource_group_name = var.azure_reuse_config.vnet_reuse ? var.azure_reuse_config.existing_vnet_resource_group_name : local.resource_group_name
  
  # Subnet configurations
  ai_subnet_name       = var.ai_subnet_name != "" ? var.ai_subnet_name : "ai-subnet"
  ai_subnet_prefix     = var.ai_subnet_prefix != "" ? var.ai_subnet_prefix : "10.0.0.0/26"
  bastion_subnet_name  = "AzureBastionSubnet"
  bastion_subnet_prefix = var.bastion_subnet_prefix != "" ? var.bastion_subnet_prefix : "10.0.0.64/26"
  app_int_subnet_name  = var.app_int_subnet_name != "" ? var.app_int_subnet_name : "app-int-subnet"
  app_int_subnet_prefix = var.app_int_subnet_prefix != "" ? var.app_int_subnet_prefix : "10.0.0.128/26"
  app_services_subnet_name = var.app_services_subnet_name != "" ? var.app_services_subnet_name : "app-services-subnet"
  app_services_subnet_prefix = var.app_services_subnet_prefix != "" ? var.app_services_subnet_prefix : "10.0.0.192/26"
  database_subnet_name = var.database_subnet_name != "" ? var.database_subnet_name : "database-subnet"
  database_subnet_prefix = var.database_subnet_prefix != "" ? var.database_subnet_prefix : "10.0.1.0/26"
  
  # Private endpoint names
  storage_pe_name        = var.azure_storage_account_pe != "" ? var.azure_storage_account_pe : "stragpe0-${local.resource_token}"
  cosmos_pe_name         = var.azure_db_account_pe != "" ? var.azure_db_account_pe : "dbgptpe0-${local.resource_token}"
  keyvault_pe_name       = var.azure_keyvault_pe != "" ? var.azure_keyvault_pe : "kvpe0-${local.resource_token}"
  orchestrator_pe_name   = var.azure_orchestrator_pe != "" ? var.azure_orchestrator_pe : "orchestratorPe-${local.resource_token}"
  frontend_pe_name       = var.azure_frontend_pe != "" ? var.azure_frontend_pe : "frontendPe-${local.resource_token}"
  data_ingestion_pe_name = var.azure_data_ingestion_pe != "" ? var.azure_data_ingestion_pe : "ingestionPe-${local.resource_token}"
  ai_services_pe_name    = var.azure_ai_services_pe != "" ? var.azure_ai_services_pe : "aiServicesPe-${local.resource_token}"
  openai_pe_name         = var.azure_openai_pe != "" ? var.azure_openai_pe : "openAiPe-${local.resource_token}"
  search_pe_name         = var.azure_search_pe != "" ? var.azure_search_pe : "searchPe-${local.resource_token}"
  
  # VM settings
  vm_name = var.zt_vm_name != "" ? var.zt_vm_name : "testvm-${local.resource_token}"
  bastion_kv_name = var.bastion_kv_name != "" ? var.bastion_kv_name : "bastionkv-${local.resource_token}"
  vm_kv_secret_name = var.vm_kv_secret_name != "" ? var.vm_kv_secret_name : "vmUserInitialPassword"
  
  # Tags
  common_tags = merge(
    {
      "azd-env-name" = var.environment_name
    },
    var.deployment_tags
  )
  
  # Model configurations
  chat_gpt_model_name = var.chat_gpt_model_name != "" ? var.chat_gpt_model_name : "gpt-4o"
  chat_gpt_model_version = var.chat_gpt_model_version != "" ? var.chat_gpt_model_version : "2024-11-20"
  chat_gpt_deployment_name = var.chat_gpt_deployment_name != "" ? var.chat_gpt_deployment_name : "chat"
  chat_gpt_deployment_capacity = var.chat_gpt_deployment_capacity != 0 ? var.chat_gpt_deployment_capacity : 40
  
  embeddings_model_name = var.embeddings_model_name != "" ? var.embeddings_model_name : "text-embedding-3-large"
  embeddings_model_version = var.embeddings_model_version != "" ? var.embeddings_model_version : "1"
  embeddings_deployment_name = var.embeddings_deployment_name != "" ? var.embeddings_deployment_name : "text-embedding"
  embeddings_vector_size = var.embeddings_vector_size != 0 ? var.embeddings_vector_size : 3072
  embeddings_deployment_capacity = var.embeddings_deployment_capacity != 0 ? var.embeddings_deployment_capacity : 40
  
  openai_api_version = var.openai_api_version != "" ? var.openai_api_version : "2024-10-21"
  
  # Storage settings
  storage_container_name = var.storage_container_name != "" ? var.storage_container_name : "documents"
  storage_images_container_name = "${local.storage_container_name}-images"
  storage_nl2sql_container_name = "nl2sql"
  
  # Search settings
  search_index = var.search_index != "" ? var.search_index : "ragindex"
  search_analyzer_name = var.search_analyzer_name != "" ? var.search_analyzer_name : "standard"
  search_api_version = var.search_api_version != "" ? var.search_api_version : "2024-07-01"
  search_index_interval = var.search_index_interval != "" ? var.search_index_interval : "PT1H"
  retrieval_approach = var.retrieval_approach != "" ? var.retrieval_approach : "hybrid"
  search_service_sku_name = var.network_isolation ? "standard2" : "standard"
  
  # Function app settings
  func_app_runtime_version = var.func_app_runtime_version != "" ? var.func_app_runtime_version : "3.11"
  app_service_runtime_version = var.app_service_runtime_version != "" ? var.app_service_runtime_version : "3.12"
  
  # Language settings
  orchestrator_messages_language = var.orchestrator_messages_language != "" ? var.orchestrator_messages_language : "en"
  speech_recognition_language = var.speech_recognition_language != "" ? var.speech_recognition_language : "en-US"
  speech_synthesis_language = var.speech_synthesis_language != "" ? var.speech_synthesis_language : "en-US"
  speech_synthesis_voice_name = var.speech_synthesis_voice_name != "" ? var.speech_synthesis_voice_name : "en-US-RyanMultilingualNeural"
  
  # Chunking settings
  chunk_num_tokens = var.chunk_num_tokens != "" ? var.chunk_num_tokens : "2048"
  chunk_min_size = var.chunk_min_size != "" ? var.chunk_min_size : "100"
  chunk_token_overlap = var.chunk_token_overlap != "" ? var.chunk_token_overlap : "200"
  
  # Document intelligence API version
  docint_api_version = "2024-11-30"
  
  # Orchestrator endpoint
  orchestrator_endpoint = "https://${local.orchestrator_function_name}.azurewebsites.net/api/orc"
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
  
  lifecycle {
    prevent_destroy = false
  }
}

# Networking Module
module "networking" {
  count  = var.network_isolation && !var.azure_reuse_config.vnet_reuse ? 1 : 0
  source = "./modules/networking"
  
  network_isolation         = var.network_isolation
  vnet_reuse               = var.azure_reuse_config.vnet_reuse
  deploy_vm                = var.deploy_vm
  vnet_name                = local.vnet_name
  vnet_address             = local.vnet_address
  location                 = var.location
  resource_group_name      = azurerm_resource_group.main.name
  tags                     = local.common_tags
  
  ai_subnet_name           = local.ai_subnet_name
  ai_subnet_prefix         = local.ai_subnet_prefix
  app_int_subnet_name      = local.app_int_subnet_name
  app_int_subnet_prefix    = local.app_int_subnet_prefix
  app_services_subnet_name = local.app_services_subnet_name
  app_services_subnet_prefix = local.app_services_subnet_prefix
  database_subnet_name     = local.database_subnet_name
  database_subnet_prefix   = local.database_subnet_prefix
  bastion_subnet_name      = local.bastion_subnet_name
  bastion_subnet_prefix    = local.bastion_subnet_prefix
}

# Data source for existing VNet (when reusing)
data "azurerm_virtual_network" "existing" {
  count               = var.azure_reuse_config.vnet_reuse ? 1 : 0
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

# Data sources for existing subnets (when reusing VNet)
data "azurerm_subnet" "ai_subnet_existing" {
  count                = var.azure_reuse_config.vnet_reuse && var.network_isolation ? 1 : 0
  name                 = local.ai_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "app_int_subnet_existing" {
  count                = var.azure_reuse_config.vnet_reuse && var.network_isolation ? 1 : 0
  name                 = local.app_int_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "app_services_subnet_existing" {
  count                = var.azure_reuse_config.vnet_reuse && var.network_isolation ? 1 : 0
  name                 = local.app_services_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "database_subnet_existing" {
  count                = var.azure_reuse_config.vnet_reuse && var.network_isolation ? 1 : 0
  name                 = local.database_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "bastion_subnet_existing" {
  count                = var.azure_reuse_config.vnet_reuse && var.network_isolation && var.deploy_vm ? 1 : 0
  name                 = local.bastion_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

# Local values for subnet IDs
locals {
  # Determine subnet IDs based on whether we're creating or reusing
  ai_subnet_id = var.network_isolation ? (
    var.azure_reuse_config.vnet_reuse ? 
    data.azurerm_subnet.ai_subnet_existing[0].id : 
    module.networking[0].ai_subnet_id
  ) : ""
  
  app_int_subnet_id = var.network_isolation ? (
    var.azure_reuse_config.vnet_reuse ? 
    data.azurerm_subnet.app_int_subnet_existing[0].id : 
    module.networking[0].app_int_subnet_id
  ) : ""
  
  app_services_subnet_id = var.network_isolation ? (
    var.azure_reuse_config.vnet_reuse ? 
    data.azurerm_subnet.app_services_subnet_existing[0].id : 
    module.networking[0].app_services_subnet_id
  ) : ""
  
  database_subnet_id = var.network_isolation ? (
    var.azure_reuse_config.vnet_reuse ? 
    data.azurerm_subnet.database_subnet_existing[0].id : 
    module.networking[0].database_subnet_id
  ) : ""
  
  vnet_id = var.network_isolation ? (
    var.azure_reuse_config.vnet_reuse ? 
    data.azurerm_virtual_network.existing[0].id : 
    module.networking[0].vnet_id
  ) : ""
  
  bastion_subnet_id = var.network_isolation && var.deploy_vm ? (
    var.azure_reuse_config.vnet_reuse ? 
    data.azurerm_subnet.bastion_subnet_existing[0].id : 
    module.networking[0].bastion_subnet_id
  ) : ""
}

# Storage Module
module "storage" {
  source = "./modules/storage"
  
  storage_account_name      = local.storage_account_name
  resource_group_name       = azurerm_resource_group.main.name
  location                  = var.location
  network_isolation         = var.network_isolation
  documents_container_name  = local.storage_container_name
  images_container_name     = local.storage_images_container_name
  nl2sql_container_name     = local.storage_nl2sql_container_name
  tags                      = local.common_tags
  storage_reuse            = var.azure_reuse_config.storage_reuse
  existing_storage_resource_group_name = var.azure_reuse_config.existing_storage_resource_group_name
}

# Orchestrator Function App Storage Account
module "orchestrator_storage" {
  source = "./modules/storage"
  
  storage_account_name      = local.orchestrator_storage_name
  resource_group_name       = local.orchestrator_function_resource_group_name
  location                  = var.location
  network_isolation         = var.network_isolation
  documents_container_name  = "deploymentpackage"
  tags                      = local.common_tags
  storage_reuse            = var.azure_reuse_config.orchestrator_function_app_storage_reuse
  existing_storage_resource_group_name = var.azure_reuse_config.existing_orchestrator_function_app_storage_resource_group_name
}

# Data Ingestion Function App Storage Account
module "data_ingestion_storage" {
  source = "./modules/storage"
  
  storage_account_name      = local.data_ingestion_storage_name
  resource_group_name       = local.data_ingestion_function_resource_group_name
  location                  = var.location
  network_isolation         = var.network_isolation
  documents_container_name  = "deploymentpackage"
  tags                      = local.common_tags
  storage_reuse            = var.azure_reuse_config.data_ingestion_function_app_storage_reuse
  existing_storage_resource_group_name = var.azure_reuse_config.existing_data_ingestion_function_app_storage_resource_group_name
}

# Key Vault Module
module "keyvault" {
  source = "./modules/keyvault"
  
  key_vault_name          = local.key_vault_name
  location                = var.location
  resource_group_name     = azurerm_resource_group.main.name
  network_isolation       = var.network_isolation
  principal_id            = var.principal_id != "" ? var.principal_id : data.azurerm_client_config.current.object_id
  vm_user_password        = var.vm_user_initial_password
  vm_password_secret_name = local.vm_kv_secret_name
  tags                    = local.common_tags
}

# Cosmos DB Module
module "cosmosdb" {
  source = "./modules/cosmosdb"
  
  cosmos_account_name            = local.cosmos_account_name
  location                       = var.location
  resource_group_name            = azurerm_resource_group.main.name
  network_isolation              = var.network_isolation
  database_name                  = local.cosmos_database_name
  conversations_container_name   = var.azure_db_config.conversation_container_name != "" ? var.azure_db_config.conversation_container_name : "conversations"
  datasources_container_name     = var.azure_db_config.datasources_container_name != "" ? var.azure_db_config.datasources_container_name : "datasources"
  key_vault_id                   = module.keyvault.key_vault_id
  tags                           = local.common_tags
  
  depends_on = [module.keyvault]
}

# AI Services Module
module "ai_services" {
  source = "./modules/ai_services"
  
  openai_service_name             = local.openai_service_name
  ai_services_name               = local.ai_services_name
  location                       = var.location
  resource_group_name            = azurerm_resource_group.main.name
  network_isolation              = var.network_isolation
  
  chat_gpt_deployment_name       = local.chat_gpt_deployment_name
  chat_gpt_model_name           = local.chat_gpt_model_name
  chat_gpt_model_version        = local.chat_gpt_model_version
  chat_gpt_deployment_type      = var.chat_gpt_model_deployment_type
  chat_gpt_deployment_capacity  = local.chat_gpt_deployment_capacity
  
  embeddings_deployment_name     = local.embeddings_deployment_name
  embeddings_model_name         = local.embeddings_model_name
  embeddings_model_version      = local.embeddings_model_version
  embeddings_deployment_type    = var.embeddings_deployment_type
  embeddings_deployment_capacity = local.embeddings_deployment_capacity
  
  key_vault_id                  = module.keyvault.key_vault_id
  tags                          = local.common_tags
  
  depends_on = [module.keyvault]
}

# Search Service Module
module "search" {
  source = "./modules/search"
  
  search_service_name         = local.search_service_name
  resource_group_name         = azurerm_resource_group.main.name
  location                    = var.location
  search_service_sku_name     = local.search_service_sku_name
  network_isolation           = var.network_isolation
  use_semantic_reranking      = var.use_semantic_reranking
  key_vault_id               = module.keyvault.key_vault_id
  resource_token             = local.resource_token
  openai_resource_id         = module.ai_services.openai_account_id
  storage_account_id         = module.storage.storage_account_id
  data_ingestion_function_id = module.compute.data_ingestion_function_id
  tags                       = local.common_tags
  
  depends_on = [module.keyvault, module.ai_services, module.storage]
}

# Compute Module
module "compute" {
  source = "./modules/compute"
  
  app_service_plan_name                 = local.app_service_plan_name
  app_insights_name                     = local.app_insights_name
  orchestrator_function_name            = local.orchestrator_function_name
  data_ingestion_function_name          = local.data_ingestion_function_name
  app_service_name                      = local.app_service_name
  location                              = var.location
  resource_group_name                   = azurerm_resource_group.main.name
  network_isolation                     = var.network_isolation
  provision_application_insights        = var.provision_application_insights
  app_integration_subnet_id             = local.app_int_subnet_id
  func_app_runtime_version              = local.func_app_runtime_version
  app_service_runtime_version           = local.app_service_runtime_version
  orchestrator_storage_account_name     = module.orchestrator_storage.storage_account_name
  orchestrator_storage_account_key      = module.orchestrator_storage.storage_account_connection_string
  data_ingestion_storage_account_name   = module.data_ingestion_storage.storage_account_name
  data_ingestion_storage_account_key    = module.data_ingestion_storage.storage_account_connection_string
  tags                                  = local.common_tags

  # App Settings for Orchestrator Function
  orchestrator_app_settings = {
    "AZURE_DB_ID"                        = module.cosmosdb.cosmos_account_name
    "AZURE_DB_NAME"                      = module.cosmosdb.database_name
    "AZURE_DB_CONVERSATIONS_CONTAINER_NAME" = var.azure_db_config.conversation_container_name != "" ? var.azure_db_config.conversation_container_name : "conversations"
    "AZURE_DB_DATASOURCES_CONTAINER_NAME"   = var.azure_db_config.datasources_container_name != "" ? var.azure_db_config.datasources_container_name : "datasources"
    "AZURE_KEY_VAULT_NAME"               = module.keyvault.key_vault_name
    "AZURE_SEARCH_SERVICE"               = module.search.search_service_name
    "AZURE_SEARCH_INDEX"                 = local.search_index
    "AZURE_SEARCH_APPROACH"              = local.retrieval_approach
    "AZURE_SEARCH_USE_SEMANTIC"          = var.use_semantic_reranking
    "AZURE_SEARCH_API_VERSION"           = local.search_api_version
    "AZURE_OPENAI_RESOURCE"              = module.ai_services.openai_account_name
    "AZURE_OPENAI_CHATGPT_MODEL"         = local.chat_gpt_model_name
    "AZURE_OPENAI_CHATGPT_DEPLOYMENT"    = local.chat_gpt_deployment_name
    "AZURE_OPENAI_API_VERSION"           = local.openai_api_version
    "AZURE_OPENAI_EMBEDDING_MODEL"       = local.embeddings_model_name
    "AZURE_OPENAI_EMBEDDING_DEPLOYMENT"  = local.embeddings_deployment_name
    "AZURE_EMBEDDINGS_VECTOR_SIZE"       = local.embeddings_vector_size
    "ORCHESTRATOR_MESSAGES_LANGUAGE"     = local.orchestrator_messages_language
  }

  # App Settings for Data Ingestion Function
  data_ingestion_app_settings = {
    "DOCINT_API_VERSION"                 = local.docint_api_version
    "AZURE_KEY_VAULT_NAME"               = module.keyvault.key_vault_name
    "FUNCTION_APP_NAME"                  = local.data_ingestion_function_name
    "SEARCH_INDEX_NAME"                  = local.search_index
    "SEARCH_ANALYZER_NAME"               = local.search_analyzer_name
    "SEARCH_API_VERSION"                 = local.search_api_version
    "SEARCH_INDEX_INTERVAL"              = local.search_index_interval
    "STORAGE_ACCOUNT_NAME"               = module.storage.storage_account_name
    "STORAGE_CONTAINER"                  = local.storage_container_name
    "STORAGE_CONTAINER_IMAGES"           = local.storage_images_container_name
    "AZURE_FORMREC_SERVICE"              = module.ai_services.ai_services_account_name
    "AZURE_OPENAI_API_VERSION"           = local.openai_api_version
    "AZURE_SEARCH_APPROACH"              = local.retrieval_approach
    "AZURE_SEARCH_SERVICE"               = module.search.search_service_name
    "AZURE_SEARCH_INDEX_NAME"            = local.search_index
    "AZURE_OPENAI_SERVICE_NAME"          = module.ai_services.openai_account_name
    "AZURE_OPENAI_EMBEDDING_DEPLOYMENT"  = local.embeddings_deployment_name
    "AZURE_EMBEDDINGS_VECTOR_SIZE"       = local.embeddings_vector_size
    "AZURE_OPENAI_EMBEDDING_MODEL"       = local.embeddings_model_name
    "AZURE_OPENAI_CHATGPT_DEPLOYMENT"    = local.chat_gpt_deployment_name
    "NUM_TOKENS"                         = local.chunk_num_tokens
    "MIN_CHUNK_SIZE"                     = local.chunk_min_size
    "TOKEN_OVERLAP"                      = local.chunk_token_overlap
    "NETWORK_ISOLATION"                  = var.network_isolation
    "AZURE_STORAGE_ACCOUNT_RG"           = azurerm_resource_group.main.name
    "AZURE_AOAI_RG"                      = azurerm_resource_group.main.name
  }

  # App Settings for Frontend App Service
  frontend_app_settings = {
    "SPEECH_SYNTHESIS_VOICE_NAME"    = local.speech_synthesis_voice_name
    "SPEECH_SYNTHESIS_LANGUAGE"      = local.speech_synthesis_language
    "SPEECH_RECOGNITION_LANGUAGE"    = local.speech_recognition_language
    "SPEECH_REGION"                  = var.location
    "ORCHESTRATOR_ENDPOINT"          = local.orchestrator_endpoint
    "AZURE_SUBSCRIPTION_ID"          = data.azurerm_subscription.current.subscription_id
    "AZURE_RESOURCE_GROUP_NAME"      = azurerm_resource_group.main.name
    "AZURE_ORCHESTRATOR_FUNC_NAME"   = local.orchestrator_function_name
    "AZURE_KEY_VAULT_ENDPOINT"       = module.keyvault.key_vault_uri
    "AZURE_KEY_VAULT_NAME"           = module.keyvault.key_vault_name
    "STORAGE_ACCOUNT"                = module.storage.storage_account_name
    "LOGLEVEL"                       = "INFO"
  }
  
  depends_on = [module.storage, module.orchestrator_storage, module.data_ingestion_storage, module.keyvault, module.cosmosdb, module.ai_services, module.search]
}

# Private Endpoints Module
module "private_endpoints" {
  count  = var.network_isolation && !var.azure_reuse_config.vnet_reuse ? 1 : 0
  source = "./modules/private_endpoints"
  
  network_isolation                     = var.network_isolation
  location                              = var.location
  resource_group_name                   = azurerm_resource_group.main.name
  
  # Subnet IDs
  ai_subnet_id                         = local.ai_subnet_id
  database_subnet_id                   = local.database_subnet_id
  app_services_subnet_id               = local.app_services_subnet_id
  
  # Private endpoint names
  storage_pe_name                      = local.storage_pe_name
  cosmos_pe_name                       = local.cosmos_pe_name
  keyvault_pe_name                     = local.keyvault_pe_name
  openai_pe_name                       = local.openai_pe_name
  ai_services_pe_name                  = local.ai_services_pe_name
  search_pe_name                       = local.search_pe_name
  orchestrator_pe_name                 = local.orchestrator_pe_name
  data_ingestion_pe_name              = local.data_ingestion_pe_name
  frontend_pe_name                     = local.frontend_pe_name
  
  # Resource IDs
  storage_account_id                   = module.storage.storage_account_id
  cosmos_account_id                    = module.cosmosdb.cosmos_account_id
  key_vault_id                         = module.keyvault.key_vault_id
  openai_account_id                    = module.ai_services.openai_account_id
  ai_services_account_id               = module.ai_services.ai_services_account_id
  search_service_id                    = module.search.search_service_id
  orchestrator_function_id             = module.compute.orchestrator_function_id
  data_ingestion_function_id           = module.compute.data_ingestion_function_id
  frontend_app_id                      = module.compute.frontend_app_id
  orchestrator_storage_account_id      = module.orchestrator_storage.storage_account_id
  data_ingestion_storage_account_id    = module.data_ingestion_storage.storage_account_id
  
  # DNS Zone IDs
  blob_dns_zone_id                     = module.networking[0].blob_dns_zone_id
  documents_dns_zone_id                = module.networking[0].documents_dns_zone_id
  vault_dns_zone_id                    = module.networking[0].vault_dns_zone_id
  websites_dns_zone_id                 = module.networking[0].websites_dns_zone_id
  cognitiveservices_dns_zone_id        = module.networking[0].cognitiveservices_dns_zone_id
  openai_dns_zone_id                   = module.networking[0].openai_dns_zone_id
  search_dns_zone_id                   = module.networking[0].search_dns_zone_id
  
  tags = local.common_tags
  
  depends_on = [module.networking, module.storage, module.orchestrator_storage, module.data_ingestion_storage, module.keyvault, module.cosmosdb, module.ai_services, module.search, module.compute]
}

# VM Module (for network isolated environments)
module "vm" {
  source = "./modules/vm"
  
  network_isolation         = var.network_isolation
  deploy_vm                = var.deploy_vm
  vm_name                  = local.vm_name
  vm_user_name             = var.vm_user_name
  vm_user_password         = var.vm_user_initial_password
  vm_password_secret_name  = local.vm_kv_secret_name
  bastion_kv_name         = local.bastion_kv_name
  location                = var.location
  resource_group_name     = azurerm_resource_group.main.name
  ai_subnet_id            = local.ai_subnet_id
  bastion_subnet_id       = local.bastion_subnet_id
  principal_id            = var.principal_id != "" ? var.principal_id : data.azurerm_client_config.current.object_id
  tags                    = local.common_tags
  
  depends_on = [module.networking]
}

# IAM Module
module "iam" {
  source = "./modules/iam"
  
  principal_id                         = var.principal_id != "" ? var.principal_id : data.azurerm_client_config.current.object_id
  resource_group_name                  = azurerm_resource_group.main.name
  
  # Principal IDs from managed identities
  orchestrator_function_principal_id   = module.compute.orchestrator_function_principal_id
  data_ingestion_function_principal_id = module.compute.data_ingestion_function_principal_id
  frontend_app_principal_id            = module.compute.frontend_app_principal_id
  search_service_principal_id          = module.search.search_service_principal_id
  vm_principal_id                      = module.vm.vm_principal_id
  
  # Resource IDs
  key_vault_id                         = module.keyvault.key_vault_id
  storage_account_id                   = module.storage.storage_account_id
  orchestrator_storage_account_id      = module.orchestrator_storage.storage_account_id
  data_ingestion_storage_account_id    = module.data_ingestion_storage.storage_account_id
  cosmos_account_id                    = module.cosmosdb.cosmos_account_id
  cosmos_account_name                  = module.cosmosdb.cosmos_account_name
  openai_account_id                    = module.ai_services.openai_account_id
  ai_services_account_id               = module.ai_services.ai_services_account_id
  search_service_id                    = module.search.search_service_id
  orchestrator_function_id             = module.compute.orchestrator_function_id
  
  depends_on = [module.keyvault, module.storage, module.orchestrator_storage, module.data_ingestion_storage, module.cosmosdb, module.ai_services, module.search, module.compute, module.vm]
}

# Load Testing (Optional)
resource "azurerm_load_test" "main" {
  count               = var.provision_load_testing ? 1 : 0
  name                = local.load_testing_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags
}

# Load Testing Key Vault Access
resource "azurerm_role_assignment" "load_testing_kv_secrets_user" {
  count                = var.provision_load_testing ? 1 : 0
  scope                = module.keyvault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_load_test.main[0].identity[0].principal_id
}
