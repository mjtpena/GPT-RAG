variable "network_isolation" {
  description = "Enable network isolation"
  type        = bool
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

# Subnet IDs
variable "ai_subnet_id" {
  description = "AI subnet ID"
  type        = string
  default     = ""
}

variable "database_subnet_id" {
  description = "Database subnet ID"
  type        = string
  default     = ""
}

variable "app_services_subnet_id" {
  description = "App services subnet ID"
  type        = string
  default     = ""
}

# Private endpoint names
variable "storage_pe_name" {
  description = "Storage private endpoint name"
  type        = string
}

variable "cosmos_pe_name" {
  description = "Cosmos DB private endpoint name"
  type        = string
}

variable "keyvault_pe_name" {
  description = "Key Vault private endpoint name"
  type        = string
}

variable "openai_pe_name" {
  description = "OpenAI private endpoint name"
  type        = string
}

variable "ai_services_pe_name" {
  description = "AI Services private endpoint name"
  type        = string
}

variable "search_pe_name" {
  description = "Search service private endpoint name"
  type        = string
}

variable "orchestrator_pe_name" {
  description = "Orchestrator function private endpoint name"
  type        = string
}

variable "data_ingestion_pe_name" {
  description = "Data ingestion function private endpoint name"
  type        = string
}

variable "frontend_pe_name" {
  description = "Frontend app private endpoint name"
  type        = string
}

# Resource IDs
variable "storage_account_id" {
  description = "Storage account ID"
  type        = string
}

variable "cosmos_account_id" {
  description = "Cosmos account ID"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
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

variable "data_ingestion_function_id" {
  description = "Data ingestion function ID"
  type        = string
}

variable "frontend_app_id" {
  description = "Frontend app ID"
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

# DNS Zone IDs
variable "blob_dns_zone_id" {
  description = "Blob DNS zone ID"
  type        = string
  default     = ""
}

variable "documents_dns_zone_id" {
  description = "Documents DNS zone ID"
  type        = string
  default     = ""
}

variable "vault_dns_zone_id" {
  description = "Vault DNS zone ID"
  type        = string
  default     = ""
}

variable "websites_dns_zone_id" {
  description = "Websites DNS zone ID"
  type        = string
  default     = ""
}

variable "cognitiveservices_dns_zone_id" {
  description = "Cognitive services DNS zone ID"
  type        = string
  default     = ""
}

variable "openai_dns_zone_id" {
  description = "OpenAI DNS zone ID"
  type        = string
  default     = ""
}

variable "search_dns_zone_id" {
  description = "Search DNS zone ID"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
