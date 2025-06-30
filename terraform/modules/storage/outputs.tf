output "storage_account_id" {
  description = "Main storage account ID"
  value       = local.storage_account_id
}

output "storage_account_name" {
  description = "Main storage account name"
  value       = local.storage_account_name
}

output "storage_account_primary_key" {
  description = "Main storage account primary key"
  value       = var.storage_reuse ? data.azurerm_storage_account.existing[0].primary_access_key : azurerm_storage_account.main[0].primary_access_key
  sensitive   = true
}

output "storage_account_connection_string" {
  description = "Main storage account connection string"
  value       = local.storage_account_primary_connection_string
  sensitive   = true
}
  value       = azurerm_storage_account.data_ingestion.primary_connection_string
  sensitive   = true
}
