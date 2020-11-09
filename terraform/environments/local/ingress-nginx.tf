module "ingress-nginx-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "ingress-nginx"
}

module "ingress-nginx" {
  source    = "../../modules/ingress-nginx"
  namespace = element([module.ingress-nginx-namespace.output_name], 0)
}

