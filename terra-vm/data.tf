data "azurerm_key_vault" "kv-demo" {

  name                = "testkv-terradb"
  resource_group_name = "kvrsg"
}

data "azurerm_key_vault_secret" "vm-secret" {

  name         = "vm-admin"
  key_vault_id = data.azurerm_key_vault.kv-demo.id

}

output "kvoutput" {

  description = "outputs keyvault id"
  value       = "Key vault id = ${data.azurerm_key_vault.kv-demo.id}"

}