variable "network_isolation" {
  description = "Enable network isolation"
  type        = bool
}

variable "deploy_vm" {
  description = "Deploy VM for testing"
  type        = bool
}

variable "vm_name" {
  description = "VM name"
  type        = string
}

variable "vm_user_name" {
  description = "VM user name"
  type        = string
}

variable "vm_user_password" {
  description = "VM user password"
  type        = string
  sensitive   = true
}

variable "vm_password_secret_name" {
  description = "VM password secret name in Key Vault"
  type        = string
}

variable "bastion_kv_name" {
  description = "Bastion Key Vault name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "ai_subnet_id" {
  description = "AI subnet ID for VM"
  type        = string
}

variable "bastion_subnet_id" {
  description = "Bastion subnet ID"
  type        = string
}

variable "principal_id" {
  description = "Principal ID for Key Vault access"
  type        = string
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
