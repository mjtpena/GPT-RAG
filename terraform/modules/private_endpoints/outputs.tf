output "storage_private_endpoint_id" {
  description = "Storage private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.storage[0].id : null
}

output "cosmos_private_endpoint_id" {
  description = "Cosmos DB private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.cosmos[0].id : null
}

output "keyvault_private_endpoint_id" {
  description = "Key Vault private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.keyvault[0].id : null
}

output "openai_private_endpoint_id" {
  description = "OpenAI private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.openai[0].id : null
}

output "ai_services_private_endpoint_id" {
  description = "AI Services private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.ai_services[0].id : null
}

output "search_private_endpoint_id" {
  description = "Search service private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.search[0].id : null
}

output "orchestrator_private_endpoint_id" {
  description = "Orchestrator function private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.orchestrator[0].id : null
}

output "data_ingestion_private_endpoint_id" {
  description = "Data ingestion function private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.data_ingestion[0].id : null
}

output "frontend_private_endpoint_id" {
  description = "Frontend app private endpoint ID"
  value       = var.network_isolation ? azurerm_private_endpoint.frontend[0].id : null
}
