output "search_service_id" {
  description = "Azure Search service ID"
  value       = azurerm_search_service.main.id
}

output "search_service_name" {
  description = "Azure Search service name"
  value       = azurerm_search_service.main.name
}

output "search_service_principal_id" {
  description = "Azure Search service principal ID"
  value       = azurerm_search_service.main.identity[0].principal_id
}

output "search_service_query_keys" {
  description = "Azure Search service query keys"
  value       = azurerm_search_service.main.query_keys
  sensitive   = true
}

output "search_service_primary_key" {
  description = "Azure Search service primary key"
  value       = azurerm_search_service.main.primary_key
  sensitive   = true
}
