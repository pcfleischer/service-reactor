module "elasticsearch" {
  source             = "../../modules/elasticsearch"
  environment_name   = var.environment_name
  namespace          = element([module.elasticsearch-namespace.output_name], 0)
  limit_cpu          = "1000m"
  limit_memory       = "4Gi"
  requests_cpu       = "1000m"
  requests_memory    = "4Gi"
  volume_storage     = "10Gi"
  storage_class_name = "hostpath"
  replicas           = 1
}

module "elasticsearch-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name              = "elasticsearch"
}