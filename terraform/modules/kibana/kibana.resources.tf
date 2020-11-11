module "kibana-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "kibana"
}

module "kibana-ingress" {
  source           = "../../modules/ingress"
  environment_name = var.environment_name
  namespace        = element([module.kibana-namespace.output_name], 0)
  service_name     = "kibana-kibana"
  service_port     = 5601
  ingress_class    = "nginx"
  path             = "/admin/kibana(/|$)(.*)"
  rewrite_target = "/$2"
}

resource "helm_release" "kibana" {
  name              = "kibana"
  repository        = "https://helm.elastic.co"
  chart             = "kibana"
  namespace         = element([module.kibana-namespace.output_name], 0)
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

