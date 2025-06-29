output "openai_account_id" {
  description = "Azure OpenAI account ID"
  value       = azurerm_cognitive_account.openai.id
}

output "openai_account_name" {
  description = "Azure OpenAI account name"
  value       = azurerm_cognitive_account.openai.name
}

output "openai_endpoint" {
  description = "Azure OpenAI endpoint"
  value       = azurerm_cognitive_account.openai.endpoint
}

output "ai_services_account_id" {
  description = "AI Services account ID"
  value       = azurerm_cognitive_account.ai_services.id
}

output "ai_services_account_name" {
  description = "AI Services account name"
  value       = azurerm_cognitive_account.ai_services.name
}

output "ai_services_endpoint" {
  description = "AI Services endpoint"
  value       = azurerm_cognitive_account.ai_services.endpoint
}
