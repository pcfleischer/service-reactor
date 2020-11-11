module "kibana-ingress" {
  source           = "../../modules/ingress"
  name             = "kibana"
  environment_name = var.environment_name
  namespace        = var.namespace
  service_name     = "kibana-kibana"
  service_port     = 5601
  ingress_class    = "nginx"
}

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
}

