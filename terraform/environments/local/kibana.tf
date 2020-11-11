module "kibana" {
  source           = "../../modules/kibana"
  namespace        = element([module.elasticsearch.output_name], 0)
  environment_name = var.environment_name
  limit_cpu        = 0.5
  limit_memory     = "1Gi"
  requests_cpu     = 0.1
  requests_memory  = "500Mi"
}