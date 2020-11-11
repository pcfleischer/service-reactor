module "prometheus-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "prometheus"
}

module "prometheus-ingress" {
  source           = "../../modules/ingress"
  name             = "prometheus"
  environment_name = var.environment_name
  namespace        = element([module.prometheus-namespace.output_name], 0)
  service_name     = "prometheus-server"
  service_port     = 80
  ingress_class    = "nginx"
}

resource "helm_release" "prometheus" {
  name              = "prometheus"
  repository        = "https://prometheus-community.github.io/helm-charts"
  chart             = "prometheus"
  namespace         = element([module.prometheus-namespace.output_name], 0)
  dependency_update = true
}
