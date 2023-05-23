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
  source                = "../modules/vm-module"
  name                  = "winvm-demo"
  resource_group_name   = azurerm_resource_group.az-rsg.name
  location              = azurerm_resource_group.az-rsg.location
  network_interface_ids = [azurerm_network_interface.az-nic.id]
  size                  = "Standard_F2"
  admin_username        = var.admin_username
  admin_password        = data.azurerm_key_vault_secret.vm-secret.value
  #specifies image 
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"

  }

  #config disk 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  #config profile



  tags = {
    enviroment = var.tag
  }







}
