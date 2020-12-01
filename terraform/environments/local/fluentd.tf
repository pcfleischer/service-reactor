module "fluentd" {
  source    = "../../modules/fluentd"
  namespace = element([module.service-namespace.output_name], 0)
}
