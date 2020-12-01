module "elasticsearch" {
  source    = "../../modules/elasticsearch"
  namespace = element([module.service-namespace.output_name], 0)
}
