module "kibana" {
  source    = "../../modules/kibana"
  namespace = element([module.elasticsearch.output_name], 0)
}
