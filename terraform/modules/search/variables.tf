variable "search_service_name" {
  description = "Azure Search service name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "search_service_sku_name" {
  description = "Azure Search service SKU"
  type        = string
}

variable "network_isolation" {
  description = "Enable network isolation"
  type        = bool
}

variable "use_semantic_reranking" {
  description = "Enable semantic reranking"
  type        = bool
}

variable "key_vault_id" {
  description = "Key Vault ID for storing secrets"
  type        = string
}

variable "resource_token" {
  description = "Unique resource token"
  type        = string
}

variable "openai_resource_id" {
  description = "Azure OpenAI resource ID"
  type        = string
  default     = ""
}

variable "storage_account_id" {
  description = "Storage account ID"
  type        = string
  default     = ""
}

variable "data_ingestion_function_id" {
  description = "Data ingestion function app ID"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
