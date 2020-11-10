variable "namespace" {}

variable "environment_name" {}

variable "limit_cpu" {}

variable "limit_memory" {}

variable "requests_cpu" {}

variable "requests_memory" {}

variable "storage_class_name" {}

variable "replicas" {
  default = 3
}

variable "volume_storage" {
  default = "30Gi"
}