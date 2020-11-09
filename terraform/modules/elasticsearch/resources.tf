resource "helm_release" "elasticsearch" {
  name              = "service-reactor-elasticsearch"
  chart             = "./../../../helm-charts/charts/elasticsearch"
  namespace         = var.namespace
  dependency_update = true

  values = [
    file("${path.module}/../../..//helm-charts/charts/elasticsearch/values.yaml"),
  ]

  set {
    name  = "resources.limits.cpu"
    value = var.limit_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.limit_memory
  }

  set {
    name  = "resources.requests.cpu"
    value = var.requests_cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.requests_memory
  }

  set {
    name  = "external.enabled"
    value = false
  }

  set {
    name  = "application"
    value = "elasticsearch"
  }

  set {
    name  = "costApplication"
    value = "service-reactor"
  }

  set {
    name  = "environment"
    value = var.environment_name
  }

  set {
    name    = "volumeClaimTemplate.resources.requests.storage"
    value   = var.volume_storage
  }

  set {
    name    = "volumeClaimTemplate.storageClassName"
    value   = var.storage_class_name
  }
}

