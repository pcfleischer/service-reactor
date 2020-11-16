variable "environment_name" {
  default = "local"
}

variable "heap_options" {
  default = "-XX:+UseContainerSupport -XX:InitialRAMPercentage=40.0 -XX:MinRAMPercentage=25.0 -XX:MaxRAMPercentage=85.0"
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
