module "prometheus-ingress" {
  source           = "../../modules/ingress"
  name             = "prometheus"
  subdomain        = "metrics"
  environment_name = var.environment_name
  namespace        = var.namespace
  service_name     = "prometheus-server"
  service_port     = 80
  ingress_class    = "nginx"
}

resource "helm_release" "prometheus" {
  name              = "prometheus"
  repository        = "https://prometheus-community.github.io/helm-charts"
  chart             = "prometheus"
  namespace         = var.namespace
  dependency_update = true
}
