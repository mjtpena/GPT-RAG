variable "storage_account_name" {
  description = "Storage account name"
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

variable "network_isolation" {
  description = "Enable network isolation"
  type        = bool
}

variable "documents_container_name" {
  description = "Documents container name"
  type        = string
}

variable "images_container_name" {
  description = "Images container name"
  type        = string
  default     = ""
}

variable "nl2sql_container_name" {
  description = "NL2SQL container name"
  type        = string
  default     = ""
}

variable "storage_reuse" {
  description = "Whether to reuse existing storage account"
  type        = bool
  default     = false
}

variable "existing_storage_resource_group_name" {
  description = "Resource group name of existing storage account"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
