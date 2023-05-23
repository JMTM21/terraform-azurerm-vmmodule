/*
This config is mainly for creating a windows VM in Azure using mdoules
Also testing for Terraform Associate Exam
Author: Jack Meehan
*/


#create resource group
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
    destination_port_range     = "3389"
    source_address_prefix      = "86.1.92.18"
    destination_address_prefix = "*"
  }

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
  #creates subnet
  tags = {
    enviroment = var.tag
  }

}
resource "azurerm_subnet" "az-sub" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.az-rsg.name
  virtual_network_name = azurerm_virtual_network.az-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pubip" {

  name                = "azmvpublicip"
  resource_group_name = azurerm_resource_group.az-rsg.name
  location            = azurerm_resource_group.az-rsg.location
  allocation_method   = "Static"

  tags = {

    enviroment = var.tag

  }

}