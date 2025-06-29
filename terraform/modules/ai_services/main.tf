# AI Services Module - Azure OpenAI and Cognitive Services

# Azure OpenAI Service
resource "azurerm_cognitive_account" "openai" {
  name                = var.openai_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "OpenAI"
  sku_name            = "S0"

  public_network_access_enabled = var.network_isolation ? false : true

  tags = var.tags
}

# Azure OpenAI Deployments
resource "azurerm_cognitive_deployment" "chat_gpt" {
  name                 = var.chat_gpt_deployment_name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = var.chat_gpt_model_name
    version = var.chat_gpt_model_version
  }

  sku {
    name     = var.chat_gpt_deployment_type
    capacity = var.chat_gpt_deployment_capacity
  }
}

resource "azurerm_cognitive_deployment" "embeddings" {
  name                 = var.embeddings_deployment_name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = var.embeddings_model_name
    version = var.embeddings_model_version
  }

  sku {
    name     = var.embeddings_deployment_type
    capacity = var.embeddings_deployment_capacity
  }
}

# AI Services (Cognitive Services Multi-Service)
resource "azurerm_cognitive_account" "ai_services" {
  name                = var.ai_services_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "CognitiveServices"
  sku_name            = "S0"

  public_network_access_enabled = var.network_isolation ? false : true

  tags = var.tags
}

# Store OpenAI key in Key Vault
resource "azurerm_key_vault_secret" "openai_key" {
  name         = "azureOpenAIKey"
  value        = azurerm_cognitive_account.openai.primary_access_key
  key_vault_id = var.key_vault_id
}

# Store Form Recognizer key in Key Vault
resource "azurerm_key_vault_secret" "form_rec_key" {
  name         = "formRecKey"
  value        = azurerm_cognitive_account.ai_services.primary_access_key
  key_vault_id = var.key_vault_id
}

# Store Speech key in Key Vault
resource "azurerm_key_vault_secret" "speech_key" {
  name         = "speechKey"
  value        = azurerm_cognitive_account.ai_services.primary_access_key
  key_vault_id = var.key_vault_id
}
