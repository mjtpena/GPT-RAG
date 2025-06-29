output "vnet_id" {
  description = "Virtual network ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_virtual_network.main[0].id : null
}

output "vnet_name" {
  description = "Virtual network name"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_virtual_network.main[0].name : null
}

output "ai_subnet_id" {
  description = "AI subnet ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_subnet.ai[0].id : null
}

output "app_integration_subnet_id" {
  description = "App integration subnet ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_subnet.app_integration[0].id : null
}

output "app_services_subnet_id" {
  description = "App services subnet ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_subnet.app_services[0].id : null
}

output "database_subnet_id" {
  description = "Database subnet ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_subnet.database[0].id : null
}

output "bastion_subnet_id" {
  description = "Bastion subnet ID"
  value       = var.network_isolation && !var.vnet_reuse && var.deploy_vm ? azurerm_subnet.bastion[0].id : null
}

# Private DNS Zone IDs
output "blob_dns_zone_id" {
  description = "Blob private DNS zone ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_private_dns_zone.blob[0].id : null
}

output "documents_dns_zone_id" {
  description = "Documents private DNS zone ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_private_dns_zone.documents[0].id : null
}

output "vault_dns_zone_id" {
  description = "Vault private DNS zone ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_private_dns_zone.vault[0].id : null
}

output "websites_dns_zone_id" {
  description = "Websites private DNS zone ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_private_dns_zone.websites[0].id : null
}

output "cognitiveservices_dns_zone_id" {
  description = "Cognitive services private DNS zone ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_private_dns_zone.cognitiveservices[0].id : null
}

output "openai_dns_zone_id" {
  description = "OpenAI private DNS zone ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_private_dns_zone.openai[0].id : null
}

output "search_dns_zone_id" {
  description = "Search private DNS zone ID"
  value       = var.network_isolation && !var.vnet_reuse ? azurerm_private_dns_zone.search[0].id : null
}
