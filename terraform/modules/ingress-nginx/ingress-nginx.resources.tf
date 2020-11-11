module "ingress-nginx-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "ingress-nginx"
}

resource "helm_release" "ingress-nginx" {
  name              = "ingress-nginx"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  namespace         = element([module.ingress-nginx-namespace.output_name], 0)
  dependency_update = true
}

