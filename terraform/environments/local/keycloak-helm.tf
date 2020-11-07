module "keycloak" {
  source           = "../../modules/keycloak"
  environment_name = var.environment_name
  namespace        = element([module.keycloak-namespace.output_name], 0)
  heap_options     = "-XX:+UseContainerSupport -XX:InitialRAMPercentage=40.0 -XX:MinRAMPercentage=25.0 -XX:MaxRAMPercentage=85.0"
  limit_cpu        = 0.5
  limit_memory     = "1Gi"
  requests_cpu     = 0.1
  requests_memory  = "500Mi"
}
