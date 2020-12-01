module "cert-manager" {
  source    = "../../modules/cert-manager"
  namespace = element([module.service-namespace.output_name], 0)
}
