variable "namespace" {}

variable "name" {
  default = "tls-default"
}

variable "common_name" {
  default = "local.servicereactor.io"
}

variable "dns_names" {
  default = "{local.servicereactor.io,*.local.servicereactor.io}"
}

variable "secret_name" {
  default = "tls-default"
}

variable "issuer_name" {
  default = "self-signed-cert-manager-issuer"
}

variable "environment_name" {
  default = "local"
}
