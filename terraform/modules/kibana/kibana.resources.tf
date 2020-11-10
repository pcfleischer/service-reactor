resource "helm_release" "kibana" {
  name              = "kibana"
  repository        = "https://helm.elastic.co"
  chart             = "kibana"
  namespace         = var.namespace
  dependency_update = true

  set {
    name  = "application"
    value = "kibana"
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

