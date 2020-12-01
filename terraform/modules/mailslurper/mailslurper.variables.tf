variable "namespace" {}

variable "environment_name" {
  default = "local"
}

variable "limit_cpu" {
  default = 0.5
}

variable "limit_memory" {
  default = "512Mi"
}

variable "requests_cpu" {
  default = 0.05
}

variable "requests_memory" {
  default = "64Mi"
}
