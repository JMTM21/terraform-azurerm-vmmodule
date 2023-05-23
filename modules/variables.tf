##VM Config
variable "location" {
  type    = string
  default = "UK South"
}

variable "vmname" {
    type = string
  
}

variable "adminusern" {
  type = string

}

variable "adminpass" {
  type = string

}

variable "nics" {
  type = string

}

variable "size" {
  type = string

}

variable "tag" {
  type = string

}

#Source Image

variable "publisher" {
  type = string

}

variable "offer" {
  type = string

}

variable "sku" {
  type = string

}

variable "version" {
  type = string

}

##OS Disk

variable "caching" {
  type = string
}

variable "strgaccount" {
  type = string

}