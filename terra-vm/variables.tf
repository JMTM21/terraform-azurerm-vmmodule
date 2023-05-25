variable "location" {
  type = list(string)
  default = [
    "Uk South",
    "Uk West"
  ]
  description = "sets location for resources, not incl vm called from module"
}

variable "rsg" {
  type = map(any)
  default = {

    prod = {
      name = "az-rsgprod"

    }
    dev = {
      name = "az-rsgdev"

    }

  }


}

variable "tag" {
  type        = string
  description = "sets tags for resources, not incl vm called from module"
  default     = "module-demo"
}

variable "security_rule" {
  type = map(object(
    {
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string

    }
  ))
  default = {
    "allow" = {
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
    "deny" = {
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
  }




}


