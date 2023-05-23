#creates nic

resource "azurerm_network_interface" "az-nic" {

  name                = "modnic-demo"
  location            = azurerm_resource_group.az-rsg.location
  resource_group_name = azurerm_resource_group.az-rsg.name

  ip_configuration {
    name                          = "ipconfig-demo"
    subnet_id                     = azurerm_subnet.az-sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubip.id

  }
  tags = {
    enviroment = var.tag
  }

}

module "vmmod" {
  source      = "../modules/vm-module"
  vmname      = var.vmanem
  rsgname     = azurerm_resource_group.az-rsg.name
  location    = var.location
  nics        = [azurerm_network_interface.az-nic.id]
  size        = var.size
  adminusern  = var.adminusern
  adminpass   = data.azurerm_key_vault_secret.vm-secret.value
  publisher   = var.publisher
  offer       = var.offer
  sku         = var.sku
  vmversion   = var.vmversion
  caching     = var.caching
  strgaccount = var.strgaccount
  tag         = var.tag


}
