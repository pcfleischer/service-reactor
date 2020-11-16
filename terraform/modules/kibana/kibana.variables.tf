variable "namespace" {}

variable "environment_name" {
  default = "local"
}

variable "limit_cpu" {
  default = 0.5
}

variable "limit_memory" {
  default = "1Gi"
}

variable "requests_cpu" {
  default = 0.1
}

variable "requests_memory" {
  default = "500Mi"
}
