module "default-certificate" {
  source      = "../../modules/cert-manager-certificate"
  namespace   = element([module.service-namespace.output_name], 0)
  issuer_name = element([module.cert-manager.issuer_name], 0)
}
