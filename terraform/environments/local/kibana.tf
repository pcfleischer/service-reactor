module "kibana" {
  source    = "../../modules/kibana"
  namespace = element([module.service-namespace.output_name], 0)
}
