module "kibana" {
  source             = "../../modules/kibana"
  environment_name   = var.environment_name
  namespace          = element([module.elasticsearch-namespace.output_name], 0)
}

module "kibana-ingress" {
  source           = "../../modules/ingress"
  environment_name = var.environment_name
  namespace        = element([module.elasticsearch-namespace.output_name], 0)
  service_name     = "kibana-kibana"
  service_port     = 5601
  ingress_class    = "nginx"
}