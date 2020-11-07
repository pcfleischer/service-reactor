resource "helm_release" "keycloak" {
  name              = "service-reactor-keycloak"
  chart             = "./../../../helm-charts/charts/keycloak"
  namespace         = var.namespace
  dependency_update = true

  values = [
    file("${path.module}/../../..//helm-charts/charts/keycloak/values.yaml"),
  ]

  set {
    name  = "image.repository"
    value = "docker.io/jboss/keycloak"
  }

  set {
    name  = "image.tag"
    value = ""
  }

  set {
    name  = "service.port"
    value = "8004"
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
    name  = "external.enabled"
    value = false
  }

  set {
    name  = "application"
    value = "keycloak"
  }

  set {
    name  = "costApplication"
    value = "service-reactor"
  }

  set {
    name  = "environment"
    value = var.environment_name
  }
}

