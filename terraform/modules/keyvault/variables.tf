variable "key_vault_name" {
  description = "Key Vault name"
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

variable "principal_id" {
  description = "Principal ID for access policy"
  type        = string
}

variable "vm_user_password" {
  description = "VM user password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "vm_password_secret_name" {
  description = "VM password secret name in Key Vault"
  type        = string
  default     = "vmUserInitialPassword"
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
