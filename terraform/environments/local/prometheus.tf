module "prometheus-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "prometheus"
}

module "prometheus" {
  source    = "../../modules/prometheus"
  namespace = element([module.prometheus-namespace.output_name], 0)
}

