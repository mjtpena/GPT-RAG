variable "principal_id" {
  description = "Principal ID for user/service principal access"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

# Principal IDs from managed identities
variable "orchestrator_function_principal_id" {
  description = "Orchestrator function app principal ID"
  type        = string
}

variable "data_ingestion_function_principal_id" {
  description = "Data ingestion function app principal ID"
  type        = string
}

variable "frontend_app_principal_id" {
  description = "Frontend app service principal ID"
  type        = string
}

variable "search_service_principal_id" {
  description = "Search service principal ID"
  type        = string
}

# Resource IDs
variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "storage_account_id" {
  description = "Storage account ID"
  type        = string
}

variable "orchestrator_storage_account_id" {
  description = "Orchestrator storage account ID"
  type        = string
}

variable "data_ingestion_storage_account_id" {
  description = "Data ingestion storage account ID"
  type        = string
}

variable "cosmos_account_id" {
  description = "Cosmos account ID"
  type        = string
}

variable "cosmos_account_name" {
  description = "Cosmos account name"
  type        = string
}

variable "openai_account_id" {
  description = "OpenAI account ID"
  type        = string
}

variable "ai_services_account_id" {
  description = "AI Services account ID"
  type        = string
}

variable "search_service_id" {
  description = "Search service ID"
  type        = string
}

variable "orchestrator_function_id" {
  description = "Orchestrator function ID"
  type        = string
}
