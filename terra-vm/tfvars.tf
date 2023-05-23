
#vmconfig
vmname         = "winvm-demo"
location       = "UK South"
size           = "Standard_F2"
adminusern     = "admindemo1"
tag            = "module-demo"
  
  #source image
  publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"

    #OS Disk
     caching              = "ReadWrite"
    strgaccount           = "Standard_LRS"
