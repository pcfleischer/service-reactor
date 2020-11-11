module "elasticsearch-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "elasticsearch"
}

resource "helm_release" "elasticsearch" {
  name              = "elasticsearch"
  repository        = "https://helm.elastic.co"
  chart             = "elasticsearch"
  namespace         = element([module.elasticsearch-namespace.output_name], 0)
  dependency_update = true

  set {
    name  = "replicas"
    value = var.replicas
  }

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
    name  = "application"
    value = "elasticsearch"
  }

  set {
    name  = "environment"
    value = var.environment_name
  }

  set {
    name  = "volumeClaimTemplate.resources.requests.storage"
    value = var.volume_storage
  }

  set {
    name  = "volumeClaimTemplate.storageClassName"
    value = var.storage_class_name
  }
}

output "output_name" {
  value = element([module.elasticsearch-namespace.output_name], 0)
}