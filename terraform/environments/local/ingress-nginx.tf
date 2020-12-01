module "ingress-nginx" {
  source    = "../../modules/ingress-nginx"
  namespace = element([module.service-namespace.output_name], 0)
}
