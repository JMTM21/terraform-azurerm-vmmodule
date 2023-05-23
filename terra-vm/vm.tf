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
  vmname      = "winvm-demo"
  rsgname     = azurerm_resource_group.az-rsg.name
  vmlocation    = "UK South"
  nics        = [azurerm_network_interface.az-nic.id]
  size        = "Standard_F2"
  adminusern  = "admindemo1"
  adminpass   = data.azurerm_key_vault_secret.vm-secret.value
 
publisher = "MicrosoftWindowsServer"
offer     = "WindowsServer"
sku       = "2016-Datacenter"
vmversion = "latest"

#OS Disk
caching     = "ReadWrite"
strgaccount = "Standard_LRS"
vmtag = "demo"
}
