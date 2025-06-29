output "app_service_plan_id" {
  description = "App Service Plan ID"
  value       = azurerm_service_plan.main.id
}

output "app_service_plan_name" {
  description = "App Service Plan name"
  value       = azurerm_service_plan.main.name
}

output "application_insights_name" {
  description = "Application Insights name"
  value       = var.provision_application_insights ? azurerm_application_insights.main[0].name : ""
}

output "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = var.provision_application_insights ? azurerm_application_insights.main[0].instrumentation_key : ""
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Application Insights connection string"
  value       = var.provision_application_insights ? azurerm_application_insights.main[0].connection_string : ""
  sensitive   = true
}

output "orchestrator_function_id" {
  description = "Orchestrator function app ID"
  value       = azurerm_linux_function_app.orchestrator.id
}

output "orchestrator_function_name" {
  description = "Orchestrator function app name"
  value       = azurerm_linux_function_app.orchestrator.name
}

output "orchestrator_function_principal_id" {
  description = "Orchestrator function app principal ID"
  value       = azurerm_linux_function_app.orchestrator.identity[0].principal_id
}

output "data_ingestion_function_id" {
  description = "Data ingestion function app ID"
  value       = azurerm_linux_function_app.data_ingestion.id
}

output "data_ingestion_function_name" {
  description = "Data ingestion function app name"
  value       = azurerm_linux_function_app.data_ingestion.name
}

output "data_ingestion_function_principal_id" {
  description = "Data ingestion function app principal ID"
  value       = azurerm_linux_function_app.data_ingestion.identity[0].principal_id
}

output "frontend_app_id" {
  description = "Frontend app service ID"
  value       = azurerm_linux_web_app.frontend.id
}

output "frontend_app_name" {
  description = "Frontend app service name"
  value       = azurerm_linux_web_app.frontend.name
}

output "frontend_app_principal_id" {
  description = "Frontend app service principal ID"
  value       = azurerm_linux_web_app.frontend.identity[0].principal_id
}

output "frontend_app_default_hostname" {
  description = "Frontend app service default hostname"
  value       = azurerm_linux_web_app.frontend.default_hostname
}
