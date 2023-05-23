
#vmconfig
vmname     = "winvm-demo"
vmlocation = "UK South"
location   = "UK South"
size       = "Standard_F2"
adminusern = "admindemo1"
vmtag      = "module-demo"
tag        = "module-demo"

#source image

publisher = "MicrosoftWindowsServer"
offer     = "WindowsServer"
sku       = "2016-Datacenter"
vmversion = "latest"

#OS Disk
caching     = "ReadWrite"
strgaccount = "Standard_LRS"
