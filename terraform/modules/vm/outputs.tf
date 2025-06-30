output "vm_id" {
  description = "VM resource ID"
  value       = var.network_isolation && var.deploy_vm ? azurerm_linux_virtual_machine.test_vm[0].id : ""
}

output "vm_principal_id" {
  description = "VM managed identity principal ID"
  value       = var.network_isolation && var.deploy_vm ? azurerm_linux_virtual_machine.test_vm[0].identity[0].principal_id : ""
}

output "bastion_kv_id" {
  description = "Bastion Key Vault ID"
  value       = var.network_isolation && var.deploy_vm ? azurerm_key_vault.bastion[0].id : ""
}

output "bastion_kv_name" {
  description = "Bastion Key Vault name"
  value       = var.network_isolation && var.deploy_vm ? azurerm_key_vault.bastion[0].name : ""
}
