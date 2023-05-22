terraform {
  required_version = ">=1.3.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.57.0"
    }

    random = {

      source  = "hashicorp/random"
      version = ">=3.5.1"
    }

    local = {
      source  = "hashicorp/local"
      version = ">=2.4.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">=4.0.0"
    }
  }
}

#Can specify certain features below, not essential but block has to be there

provider "azurerm" {
  features {}

}