##Outputs Key Vault ID (Test purposes)
output "kvoutput" {
  description = "outputs keyvault id"
  value       = "Key vault id = ${data.azurerm_key_vault.kv-demo.id}"

}