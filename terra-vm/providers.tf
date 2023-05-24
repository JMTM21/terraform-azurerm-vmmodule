terraform {
  #gets Terraform version - anything over 1.3.2
  required_version = ">=1.3.2"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JMTM21"
    workspaces {
      name = "azure-new"
    }
  }

  required_providers {

    #gets azure provider - anything over 3.57.0
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.57.0"
    }


    #gets random provider - anything over 3.5.1
    random = {

      source  = "hashicorp/random"
      version = ">=3.5.1"
    }
    #gets local provider - anything over 2.4.0
    local = {
      source  = "hashicorp/local"
      version = ">=2.4.0"
    }
    #gets tls provider - anything over 4.0.0
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