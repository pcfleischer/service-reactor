module "mailslurper-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "mailslurper"
}

module "mailslurper-ingress" {
  source           = "../../modules/ingress"
  name             = "mailslurper"
  subdomain        = "mailslurper"
  environment_name = var.environment_name
  namespace        = element([module.mailslurper-namespace.output_name], 0)
  service_name     = "mailslurper"
  service_port     = 8080
  ingress_class    = "nginx"
}

module "mailslurper-api-ingress" {
  source           = "../../modules/ingress"
  name             = "mailslurper-api"
  subdomain        = "mailslurper"
  environment_name = var.environment_name
  namespace        = element([module.mailslurper-namespace.output_name], 0)
  service_name     = "mailslurper"
  service_port     = 8888
  ingress_class    = "nginx"
  path             = "/api(/|$)(.*)"
  rewrite_target   = "/$2"
}

resource "helm_release" "mailslurper" {
  name      = "mailslurper"
  chart     = "./../../../helm-charts/charts/mailslurper"
  namespace = element([module.mailslurper-namespace.output_name], 0)

  values = [
    file("${path.module}/../../../helm-charts/charts/mailslurper/values.yaml"),
  ]

  set {
    name  = "image.repository"
    value = "phillipfleischer/mailslurper"
  }

  set {
    name  = "image.tag"
    value = "latest"
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
    value = "mailslurper"
  }

  set {
    name  = "costApplication"
    value = "utilities"
  }

  set {
    name  = "environment"
    value = var.environment_name
  }
}
