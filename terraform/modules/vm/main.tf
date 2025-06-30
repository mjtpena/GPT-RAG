# VM Module for Zero Trust configuration

# Create a separate key vault for VM credentials when network isolation is enabled
resource "azurerm_key_vault" "bastion" {
  count                      = var.network_isolation && var.deploy_vm ? 1 : 0
  name                       = var.bastion_kv_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.principal_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]
  }

  tags = var.tags
}

# Store VM password in bastion key vault
resource "azurerm_key_vault_secret" "vm_password" {
  count        = var.network_isolation && var.deploy_vm ? 1 : 0
  name         = var.vm_password_secret_name
  value        = var.vm_user_password
  key_vault_id = azurerm_key_vault.bastion[0].id

  depends_on = [azurerm_key_vault.bastion]
}

# Network Interface for VM
resource "azurerm_network_interface" "vm" {
  count               = var.network_isolation && var.deploy_vm ? 1 : 0
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.ai_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# VM for accessing network isolated environment
resource "azurerm_linux_virtual_machine" "test_vm" {
  count               = var.network_isolation && var.deploy_vm ? 1 : 0
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2s"
  admin_username      = var.vm_user_name

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.vm[0].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "microsoft-dsvm"
    offer     = "ubuntu-1804"
    sku       = "1804-gen2"
    version   = "latest"
  }

  admin_password = var.vm_user_password

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Bastion Host for secure VM access
resource "azurerm_public_ip" "bastion" {
  count               = var.network_isolation && var.deploy_vm ? 1 : 0
  name                = "${var.vm_name}-bastion-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_bastion_host" "main" {
  count               = var.network_isolation && var.deploy_vm ? 1 : 0
  name                = "${var.vm_name}-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }

  tags = var.tags
}

data "azurerm_client_config" "current" {}
