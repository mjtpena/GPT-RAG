variable "cosmos_account_name" {
  description = "Cosmos DB account name"
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

variable "database_name" {
  description = "Cosmos DB database name"
  type        = string
}

variable "conversations_container_name" {
  description = "Conversations container name"
  type        = string
}

variable "datasources_container_name" {
  description = "Datasources container name"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID for storing secrets"
  type        = string
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
