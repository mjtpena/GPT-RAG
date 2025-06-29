variable "network_isolation" {
  description = "Enable network isolation"
  type        = bool
}

variable "vnet_reuse" {
  description = "Reuse existing VNet"
  type        = bool
}

variable "deploy_vm" {
  description = "Deploy VM for bastion access"
  type        = bool
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address" {
  description = "Virtual network address space"
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

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}

variable "ai_subnet_name" {
  description = "AI subnet name"
  type        = string
}

variable "ai_subnet_prefix" {
  description = "AI subnet address prefix"
  type        = string
}

variable "app_int_subnet_name" {
  description = "App integration subnet name"
  type        = string
}

variable "app_int_subnet_prefix" {
  description = "App integration subnet address prefix"
  type        = string
}

variable "app_services_subnet_name" {
  description = "App services subnet name"
  type        = string
}

variable "app_services_subnet_prefix" {
  description = "App services subnet address prefix"
  type        = string
}

variable "database_subnet_name" {
  description = "Database subnet name"
  type        = string
}

variable "database_subnet_prefix" {
  description = "Database subnet address prefix"
  type        = string
}

variable "bastion_subnet_name" {
  description = "Bastion subnet name"
  type        = string
}

variable "bastion_subnet_prefix" {
  description = "Bastion subnet address prefix"
  type        = string
}
