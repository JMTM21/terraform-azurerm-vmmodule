#creates nic

resource "azurerm_network_interface" "az-nic" {

  name                = "modnic-demo"
  location            = azurerm_resource_group.az-rsg.location
  resource_group_name = azurerm_resource_group.az-rsg.name

  ip_configuration {
    name                          = "ipconfig-demo"
    subnet_id                     = azurerm_subnet.az-sub.id
    private_ip_address_allocation = "Dynamic"

  }
  tags = {
    enviroment = var.tag
  }

}

#creates VM
/*resource "azurerm_linux_virtual_machine" "az-vm" {
  name                            = "vm-demo"
  resource_group_name             = azurerm_resource_group.az-rsg.name
  location                        = azurerm_resource_group.az-rsg.location
  network_interface_ids           = [azurerm_network_interface.az-nic.id]
  size                            = "Standard_DS1_v2"
  admin_username                  = var.admin_username
  disable_password_authentication = false
  admin_password                  = data.azurerm_key_vault_secret.vm-secret.value
  #specifies image 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
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




}*/
