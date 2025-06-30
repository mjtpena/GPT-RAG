# IAM Module - Role Assignments and Permissions

# Key Vault Access for Function Apps and App Service
resource "azurerm_role_assignment" "orchestrator_kv_secrets_user" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.orchestrator_function_principal_id
}

resource "azurerm_role_assignment" "data_ingestion_kv_secrets_user" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.data_ingestion_function_principal_id
}

resource "azurerm_role_assignment" "frontend_kv_secrets_user" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.frontend_app_principal_id
}

# Storage Account Access
resource "azurerm_role_assignment" "orchestrator_storage_blob_data_reader" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.orchestrator_function_principal_id
}

resource "azurerm_role_assignment" "data_ingestion_storage_blob_data_contributor" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.data_ingestion_function_principal_id
}

resource "azurerm_role_assignment" "frontend_storage_blob_data_reader" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.frontend_app_principal_id
}

resource "azurerm_role_assignment" "search_storage_blob_data_contributor" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.search_service_principal_id
}

# Function App Storage Account Access
resource "azurerm_role_assignment" "orchestrator_func_storage_blob_data_contributor" {
  scope                = var.orchestrator_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.orchestrator_function_principal_id
}

resource "azurerm_role_assignment" "data_ingestion_func_storage_blob_data_contributor" {
  scope                = var.data_ingestion_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.data_ingestion_function_principal_id
}

# Cosmos DB Access
resource "azurerm_cosmosdb_sql_role_assignment" "orchestrator_cosmos_data_contributor" {
  resource_group_name = var.resource_group_name
  account_name        = var.cosmos_account_name
  role_definition_id  = "${var.cosmos_account_id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002" # Cosmos DB Built-in Data Contributor
  principal_id        = var.orchestrator_function_principal_id
  scope               = var.cosmos_account_id
}

# OpenAI Access
resource "azurerm_role_assignment" "orchestrator_openai_user" {
  scope                = var.openai_account_id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = var.orchestrator_function_principal_id
}

resource "azurerm_role_assignment" "data_ingestion_openai_user" {
  scope                = var.openai_account_id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = var.data_ingestion_function_principal_id
}

resource "azurerm_role_assignment" "search_openai_user" {
  scope                = var.openai_account_id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = var.search_service_principal_id
}

# AI Services Access
resource "azurerm_role_assignment" "data_ingestion_ai_services_user" {
  scope                = var.ai_services_account_id
  role_definition_name = "Cognitive Services User"
  principal_id         = var.data_ingestion_function_principal_id
}

resource "azurerm_role_assignment" "frontend_ai_services_user" {
  scope                = var.ai_services_account_id
  role_definition_name = "Cognitive Services User"
  principal_id         = var.frontend_app_principal_id
}

# Search Service Access
resource "azurerm_role_assignment" "orchestrator_search_index_data_reader" {
  scope                = var.search_service_id
  role_definition_name = "Search Index Data Reader"
  principal_id         = var.orchestrator_function_principal_id
}

resource "azurerm_role_assignment" "data_ingestion_search_index_data_contributor" {
  scope                = var.search_service_id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = var.data_ingestion_function_principal_id
}

# Function App Invocation Access
resource "azurerm_role_assignment" "frontend_orchestrator_function_contributor" {
  scope                = var.orchestrator_function_id
  role_definition_name = "Website Contributor"
  principal_id         = var.frontend_app_principal_id
}

# Principal (User/Service Principal) Access for post-deployment
resource "azurerm_cosmosdb_sql_role_assignment" "principal_cosmos_data_contributor" {
  count               = var.principal_id != "" ? 1 : 0
  resource_group_name = var.resource_group_name
  account_name        = var.cosmos_account_name
  role_definition_id  = "${var.cosmos_account_id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002" # Cosmos DB Built-in Data Contributor
  principal_id        = var.principal_id
  scope               = var.cosmos_account_id
}

resource "azurerm_role_assignment" "principal_search_service_contributor" {
  count                = var.principal_id != "" ? 1 : 0
  scope                = var.search_service_id
  role_definition_name = "Search Service Contributor"
  principal_id         = var.principal_id
}

resource "azurerm_role_assignment" "principal_orchestrator_storage_blob_data_contributor" {
  count                = var.principal_id != "" ? 1 : 0
  scope                = var.orchestrator_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}

# VM Search Service Access (when VM is deployed for network isolation)
resource "azurerm_role_assignment" "vm_search_service_contributor" {
  count                = var.vm_principal_id != "" ? 1 : 0
  scope                = var.search_service_id
  role_definition_name = "Search Service Contributor"
  principal_id         = var.vm_principal_id
}
