/*
This config is mainly for creating a windows VM in Azure using mdoules
Also testing for Terraform Associate Exam
Author: Jack Meehan
*/


#create resource group - empty subscription starting from scratch
resource "azurerm_resource_group" "az-rsg" {

  name     = "modrsg-demo"
  location = var.location
  tags = {
    enviroment = var.tag
  }

}

#creates network security group
resource "azurerm_network_security_group" "az-nsg" {

  name                = "modnsg-demo"
  location            = azurerm_resource_group.az-rsg.location
  resource_group_name = azurerm_resource_group.az-rsg.name

  #rules below Allowing rdp from 1 IP, Deny all else
  security_rule {
    name                       = "Allowrdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "86.1.92.18"
    destination_address_prefix = "*"
  }

  #denying all except my IP
  security_rule {
    name                       = "Denyall"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  tags = {
    enviroment = var.tag
  }


}

#creates vnet
resource "azurerm_virtual_network" "az-vnet" {

  name                = "modvnet-demo"
  location            = azurerm_resource_group.az-rsg.location
  resource_group_name = azurerm_resource_group.az-rsg.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    enviroment = var.tag
  }

}

##Creates Subnet
resource "azurerm_subnet" "az-sub" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.az-rsg.name
  virtual_network_name = azurerm_virtual_network.az-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "az-sbnsg" {
  subnet_id                 = azurerm_subnet.az-sub.id
  network_security_group_id = azurerm_network_security_group.az-nsg.id
}

##Creates Public IP for VM NIC
resource "azurerm_public_ip" "pubip" {

  name                = "azmvpublicip"
  resource_group_name = azurerm_resource_group.az-rsg.name
  location            = azurerm_resource_group.az-rsg.location
  allocation_method   = "Static"

  tags = {

    enviroment = var.tag

  }

}

##gets key vault id to pass through to get secret
data "azurerm_key_vault" "kv-demo" {

  name                = "testkv-terradb"
  resource_group_name = "kvrsg"
}

##gets secret for vm password
data "azurerm_key_vault_secret" "vm-secret" {

  name         = "vm-admin"
  key_vault_id = data.azurerm_key_vault.kv-demo.id

}

data "azurerm_key_vault_secret" "container-secret" {

  name         = "container-key"
  key_vault_id = data.azurerm_key_vault.kv-demo.id

}


#creates nic

resource "azurerm_network_interface" "az-nic" {

  name                = "modnic-demo"
  location            = azurerm_resource_group.az-rsg.location
  resource_group_name = azurerm_resource_group.az-rsg.name

  #Configures IP info and assigns public IP

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

##Calls Module to create VM

module "vmmod" {
  source      = "../modules/vm-module"
  vmname      = "winvm-demo"
  rsgname     = azurerm_resource_group.az-rsg.name
  vmlocation    = "UK South"
  nics        = [azurerm_network_interface.az-nic.id]
  size        = "Standard_F2"
  adminusern  = "admindemo1"
  adminpass   = data.azurerm_key_vault_secret.vm-secret.value
 #source image
publisher = "MicrosoftWindowsServer"
offer     = "WindowsServer"
sku       = "2016-Datacenter"
vmversion = "latest"

#OS Disk
caching     = "ReadWrite"
strgaccount = "Standard_LRS"
vmtag = "demo"


}


