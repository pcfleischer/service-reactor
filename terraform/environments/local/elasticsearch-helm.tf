module "elasticsearch" {
  source             = "../../modules/elasticsearch"
  environment_name   = var.environment_name
  namespace          = element([module.elasticsearch-namespace.output_name], 0)
  limit_cpu          = 0.5
  limit_memory       = "4Gi"
  requests_cpu       = 0.1
  requests_memory    = "4Gi"
  volume_storage     = "10Gi"
  storage_class_name = "hostpath"
}
