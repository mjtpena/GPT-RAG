# Terraform Outputs

output "AZURE_AI_SUBNET_NAME" {
  description = "AI subnet name"
  value       = local.ai_subnet_name
}

output "AZURE_AI_SUBNET_PREFIX" {
  description = "AI subnet prefix"
  value       = local.ai_subnet_prefix
}

output "AZURE_APP_INSIGHTS_NAME" {
  description = "Application Insights name"
  value       = local.app_insights_name
}

output "AZURE_APP_INT_SUBNET_NAME" {
  description = "App integration subnet name"
  value       = local.app_int_subnet_name
}

output "AZURE_APP_INT_SUBNET_PREFIX" {
  description = "App integration subnet prefix"
  value       = local.app_int_subnet_prefix
}

output "AZURE_APP_SERVICE_NAME" {
  description = "App Service name"
  value       = local.app_service_name
}

output "AZURE_APP_SERVICE_PLAN_NAME" {
  description = "App Service Plan name"
  value       = local.app_service_plan_name
}

output "AZURE_APP_SERVICES_SUBNET_NAME" {
  description = "App services subnet name"
  value       = local.app_services_subnet_name
}

output "AZURE_APP_SERVICES_SUBNET_PREFIX" {
  description = "App services subnet prefix"
  value       = local.app_services_subnet_prefix
}

output "AZURE_BASTION_KV_NAME" {
  description = "Bastion Key Vault name"
  value       = var.network_isolation ? local.bastion_kv_name : ""
}

output "AZURE_BASTION_SUBNET_PREFIX" {
  description = "Bastion subnet prefix"
  value       = local.bastion_subnet_prefix
}

output "AZURE_CHAT_GPT_DEPLOYMENT_CAPACITY" {
  description = "Chat GPT deployment capacity"
  value       = local.chat_gpt_deployment_capacity
}

output "AZURE_CHAT_GPT_DEPLOYMENT_NAME" {
  description = "Chat GPT deployment name"
  value       = local.chat_gpt_deployment_name
}

output "AZURE_CHAT_GPT_MODEL_NAME" {
  description = "Chat GPT model name"
  value       = local.chat_gpt_model_name
}

output "AZURE_CHAT_GPT_MODEL_VERSION" {
  description = "Chat GPT model version"
  value       = local.chat_gpt_model_version
}

output "AZURE_EMBEDDINGS_MODEL_NAME" {
  description = "Embeddings model name"
  value       = local.embeddings_model_name
}

output "AZURE_EMBEDDINGS_VERSION" {
  description = "Embeddings model version"
  value       = local.embeddings_model_version
}

output "AZURE_EMBEDDINGS_DEPLOYMENT_NAME" {
  description = "Embeddings deployment name"
  value       = local.embeddings_deployment_name
}

output "AZURE_EMBEDDINGS_VECTOR_SIZE" {
  description = "Embeddings vector size"
  value       = local.embeddings_vector_size
}

output "AZURE_AI_SERVICES_NAME" {
  description = "AI Services name"
  value       = local.ai_services_name
}

output "AZURE_AI_SERVICES_PE" {
  description = "AI Services private endpoint name"
  value       = local.ai_services_pe_name
}

output "AZURE_DB_ACCOUNT_PE" {
  description = "Cosmos DB account private endpoint name"
  value       = local.cosmos_pe_name
}

output "AZURE_DATA_INGEST_FUNC_NAME" {
  description = "Data ingestion function name"
  value       = local.data_ingestion_function_name
}

output "AZURE_DATA_INGEST_FUNC_RG" {
  description = "Data ingestion function resource group"
  value       = azurerm_resource_group.main.name
}

output "AZURE_DATA_INGESTION_PE" {
  description = "Data ingestion private endpoint name"
  value       = local.data_ingestion_pe_name
}

output "AZURE_DATABASE_SUBNET_NAME" {
  description = "Database subnet name"
  value       = local.database_subnet_name
}

output "AZURE_DATABASE_SUBNET_PREFIX" {
  description = "Database subnet prefix"
  value       = local.database_subnet_prefix
}

output "AZURE_DB_CONFIG" {
  description = "Database configuration"
  value = {
    db_account_name                = local.cosmos_account_name
    db_database_name               = local.cosmos_database_name
    conversation_container_name    = var.azure_db_config.conversation_container_name != "" ? var.azure_db_config.conversation_container_name : "conversations"
    datasources_container_name     = var.azure_db_config.datasources_container_name != "" ? var.azure_db_config.datasources_container_name : "datasources"
  }
}

output "AZURE_FRONTEND_PE" {
  description = "Frontend private endpoint name"
  value       = local.frontend_pe_name
}

output "AZURE_KV_NAME" {
  description = "Key Vault name"
  value       = local.key_vault_name
}

output "AZURE_KEY_VAULT_NAME" {
  description = "Key Vault name"
  value       = local.key_vault_name
}

output "AZURE_KEYVAULT_PE" {
  description = "Key Vault private endpoint name"
  value       = local.keyvault_pe_name
}

output "AZURE_LOAD_TESTING_NAME" {
  description = "Load testing name"
  value       = local.load_testing_name
}

output "AZURE_NETWORK_ISOLATION" {
  description = "Network isolation enabled"
  value       = var.network_isolation
}

output "AZURE_OPEN_AI_PE" {
  description = "OpenAI private endpoint name"
  value       = local.openai_pe_name
}

output "AZURE_OPENAI_SERVICE_NAME" {
  description = "OpenAI service name"
  value       = local.openai_service_name
}

output "AZURE_ORCHESTRATOR_FUNC_NAME" {
  description = "Orchestrator function name"
  value       = local.orchestrator_function_name
}

output "AZURE_ORCHESTRATOR_FUNC_RG" {
  description = "Orchestrator function resource group"
  value       = azurerm_resource_group.main.name
}

output "AZURE_ORCHESTRATOR_MESSAGES_LANGUAGE" {
  description = "Orchestrator messages language"
  value       = local.orchestrator_messages_language
}

output "AZURE_ORCHESTRATOR_PE" {
  description = "Orchestrator private endpoint name"
  value       = local.orchestrator_pe_name
}

output "AZURE_RESOURCE_GROUP_NAME" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "AZURE_RETRIEVAL_APPROACH" {
  description = "Retrieval approach"
  value       = local.retrieval_approach
}

output "AZURE_REUSE_CONFIG" {
  description = "Azure reuse configuration"
  value       = var.azure_reuse_config
}

output "AZURE_SEARCH_ANALYZER_NAME" {
  description = "Search analyzer name"
  value       = local.search_analyzer_name
}

output "AZURE_SEARCH_INDEX" {
  description = "Search index name"
  value       = local.search_index
}

output "AZURE_SEARCH_PE" {
  description = "Search private endpoint name"
  value       = local.search_pe_name
}

output "AZURE_SEARCH_PRINCIPAL_ID" {
  description = "Search service principal ID"
  value       = module.search.search_service_principal_id
}

output "AZURE_SEARCH_SERVICE_NAME" {
  description = "Search service name"
  value       = local.search_service_name
}

output "AZURE_SPEECH_RECOGNITION_LANGUAGE" {
  description = "Speech recognition language"
  value       = local.speech_recognition_language
}

output "AZURE_STORAGE_ACCOUNT_PE" {
  description = "Storage account private endpoint name"
  value       = local.storage_pe_name
}

output "AZURE_STORAGE_ACCOUNT_NAME" {
  description = "Storage account name"
  value       = local.storage_account_name
}

output "AZURE_STORAGE_CONTAINER_NAME" {
  description = "Storage container name"
  value       = local.storage_container_name
}

output "AZURE_SUBSCRIPTION_ID" {
  description = "Azure subscription ID"
  value       = data.azurerm_subscription.current.subscription_id
}

output "AZURE_TENANT_ID" {
  description = "Azure tenant ID"
  value       = data.azurerm_client_config.current.tenant_id
}

output "AZURE_USE_SEMANTIC_RERANKING" {
  description = "Use semantic reranking"
  value       = var.use_semantic_reranking
}

output "AZURE_VM_DEPLOY_VM" {
  description = "Deploy VM"
  value       = var.deploy_vm
}

output "AZURE_VM_KV_SEC_NAME" {
  description = "VM Key Vault secret name"
  value       = var.network_isolation ? local.vm_kv_secret_name : ""
}

output "AZURE_VM_NAME" {
  description = "VM name"
  value       = var.network_isolation ? local.vm_name : ""
}

output "AZURE_VM_USER_NAME" {
  description = "VM user name"
  value       = var.network_isolation ? var.vm_user_name : ""
}

output "AZURE_VNET_ADDRESS" {
  description = "VNet address"
  value       = local.vnet_address
}

output "AZURE_VNET_NAME" {
  description = "VNet name"
  value       = local.vnet_name
}

output "AZURE_ZERO_TRUST" {
  description = "Zero trust configuration"
  value       = var.network_isolation ? "TRUE" : "FALSE"
}

output "AZURE_SEARCH_USE_MIS" {
  description = "Search use managed identity"
  value       = var.search_use_mis
}

# Additional outputs for the frontend URL
output "FRONTEND_URL" {
  description = "Frontend application URL"
  value       = "https://${module.compute.frontend_app_default_hostname}"
}

output "ORCHESTRATOR_ENDPOINT" {
  description = "Orchestrator endpoint URL"
  value       = local.orchestrator_endpoint
}
