module "default-certificate" {
  source    = "../../modules/cert-manager-certificate"
  namespace = element([module.service-namespace.output_name], 0)
}
