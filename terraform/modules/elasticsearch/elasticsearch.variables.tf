variable "namespace" {}

variable "environment_name" {
  default = "local"
}

variable "limit_cpu" {
  default = 0.5
}

variable "limit_memory" {
  default = "3Gi"
}

variable "requests_cpu" {
  default = 0.1
}

variable "requests_memory" {
  default = "1.5Gi"
}

variable "storage_class_name" {
  default = "hostpath"
}

variable "replicas" {
  default = 1
}

variable "volume_storage" {
  default = "10Gi"
}
