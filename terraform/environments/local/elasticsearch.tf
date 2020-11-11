module "elasticsearch" {
  source             = "../../modules/elasticsearch"
  environment_name   = var.environment_name
  limit_cpu        = 0.5
  limit_memory     = "1Gi"
  requests_cpu     = 0.1
  requests_memory  = "500Mi"
  volume_storage     = "10Gi"
  storage_class_name = "hostpath"
  replicas           = 1
}