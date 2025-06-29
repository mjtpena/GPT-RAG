variable "openai_service_name" {
  description = "Azure OpenAI service name"
  type        = string
}

variable "ai_services_name" {
  description = "AI Services account name"
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

variable "chat_gpt_deployment_name" {
  description = "Chat GPT deployment name"
  type        = string
}

variable "chat_gpt_model_name" {
  description = "Chat GPT model name"
  type        = string
}

variable "chat_gpt_model_version" {
  description = "Chat GPT model version"
  type        = string
}

variable "chat_gpt_deployment_type" {
  description = "Chat GPT deployment type"
  type        = string
}

variable "chat_gpt_deployment_capacity" {
  description = "Chat GPT deployment capacity"
  type        = number
}

variable "embeddings_deployment_name" {
  description = "Embeddings deployment name"
  type        = string
}

variable "embeddings_model_name" {
  description = "Embeddings model name"
  type        = string
}

variable "embeddings_model_version" {
  description = "Embeddings model version"
  type        = string
}

variable "embeddings_deployment_type" {
  description = "Embeddings deployment type"
  type        = string
}

variable "embeddings_deployment_capacity" {
  description = "Embeddings deployment capacity"
  type        = number
}

variable "key_vault_id" {
  description = "Key Vault ID for storing secrets"
  type        = string
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
