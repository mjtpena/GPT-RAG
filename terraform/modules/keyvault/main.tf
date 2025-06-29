# Key Vault Module

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  public_network_access_enabled = var.network_isolation ? false : true
  
  # RBAC access policy
  enable_rbac_authorization = true
  
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = var.tags
}

# Key Vault Access Policy for the principal
resource "azurerm_role_assignment" "principal_kv_secrets_officer" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.principal_id
}

# Generate Flask secret key
resource "random_password" "flask_secret" {
  length  = 32
  special = true
}

# Store Flask secret in Key Vault
resource "azurerm_key_vault_secret" "flask_secret" {
  name         = "flaskSecretKey"
  value        = random_password.flask_secret.result
  key_vault_id = azurerm_key_vault.main.id
  
  depends_on = [azurerm_role_assignment.principal_kv_secrets_officer]
}

# VM Password secret (if network isolation is enabled)
resource "azurerm_key_vault_secret" "vm_password" {
  count        = var.network_isolation ? 1 : 0
  name         = var.vm_password_secret_name
  value        = var.vm_user_password
  key_vault_id = azurerm_key_vault.main.id
  
  depends_on = [azurerm_role_assignment.principal_kv_secrets_officer]
}
