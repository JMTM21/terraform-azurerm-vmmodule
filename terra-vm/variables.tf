
variable "location" {
  type    = string
  default = "UK South"
  description = "sets location for resources, not incl vm called from module"
}

variable "tag" {
  type = string
  description = "sets tags for resources, not incl vm called from module"
  default = "module-demo"
}

