variable "app_service_plan_name" {
  description = "App Service Plan name"
  type        = string
}

variable "app_insights_name" {
  description = "Application Insights name"
  type        = string
}

variable "orchestrator_function_name" {
  description = "Orchestrator function app name"
  type        = string
}

variable "data_ingestion_function_name" {
  description = "Data ingestion function app name"
  type        = string
}

variable "app_service_name" {
  description = "Frontend app service name"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "network_isolation" {
  description = "Enable network isolation"
  type        = bool
}

variable "provision_application_insights" {
  description = "Provision Application Insights"
  type        = bool
}

variable "app_integration_subnet_id" {
  description = "App integration subnet ID"
  type        = string
  default     = null
}

variable "func_app_runtime_version" {
  description = "Function app Python runtime version"
  type        = string
}

variable "app_service_runtime_version" {
  description = "App service Python runtime version"
  type        = string
}

variable "orchestrator_storage_account_name" {
  description = "Orchestrator storage account name"
  type        = string
}

variable "orchestrator_storage_account_key" {
  description = "Orchestrator storage account key"
  type        = string
  sensitive   = true
}

variable "data_ingestion_storage_account_name" {
  description = "Data ingestion storage account name"
  type        = string
}

variable "data_ingestion_storage_account_key" {
  description = "Data ingestion storage account key"
  type        = string
  sensitive   = true
}

variable "orchestrator_app_settings" {
  description = "Orchestrator function app settings"
  type        = map(string)
  default     = {}
}

variable "data_ingestion_app_settings" {
  description = "Data ingestion function app settings"
  type        = map(string)
  default     = {}
}

variable "frontend_app_settings" {
  description = "Frontend app service settings"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
