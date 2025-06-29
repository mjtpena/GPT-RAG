output "storage_account_id" {
  description = "Main storage account ID"
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "Main storage account name"
  value       = azurerm_storage_account.main.name
}

output "storage_account_primary_key" {
  description = "Main storage account primary key"
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}

output "storage_account_connection_string" {
  description = "Main storage account connection string"
  value       = azurerm_storage_account.main.primary_connection_string
  sensitive   = true
}

output "orchestrator_storage_account_id" {
  description = "Orchestrator storage account ID"
  value       = azurerm_storage_account.orchestrator.id
}

output "orchestrator_storage_account_name" {
  description = "Orchestrator storage account name"
  value       = azurerm_storage_account.orchestrator.name
}

output "orchestrator_storage_account_connection_string" {
  description = "Orchestrator storage account connection string"
  value       = azurerm_storage_account.orchestrator.primary_connection_string
  sensitive   = true
}

output "data_ingestion_storage_account_id" {
  description = "Data ingestion storage account ID"
  value       = azurerm_storage_account.data_ingestion.id
}

output "data_ingestion_storage_account_name" {
  description = "Data ingestion storage account name"
  value       = azurerm_storage_account.data_ingestion.name
}

output "data_ingestion_storage_account_connection_string" {
  description = "Data ingestion storage account connection string"
  value       = azurerm_storage_account.data_ingestion.primary_connection_string
  sensitive   = true
}
