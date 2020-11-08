
module "keycloak-namespace" {
  source           = "../../modules/keycloak-namespace"
  environment_name = var.environment_name
}
