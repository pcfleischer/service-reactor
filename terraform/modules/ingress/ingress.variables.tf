variable "name" {}

variable "subdomain" {}

variable "environment_name" {}

variable "namespace" {}

variable "service_name" {}

variable "service_port" {}

variable "rewrite_target" {
  default = null
}

variable "ingress_class" {
  default = null
}

variable "path" {
  default = null
}

variable "app_root" {
  default = null
}


