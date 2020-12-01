variable "namespace" {}

variable "name" {}

variable "subdomain" {}

variable "service_name" {}

variable "service_port" {}

variable "environment_name" {
  default = "local"
}

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

variable "tls_secret_name" {
  default = null
}

variable "domain" {
  default = "servicereactor.io"
}
