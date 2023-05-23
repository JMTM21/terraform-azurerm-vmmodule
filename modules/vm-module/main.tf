
#creates VM
resource "azurerm_windows_virtual_machine" "az-winvm" {
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