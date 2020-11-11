module "prometheus" {
  source           = "../../modules/prometheus"
  environment_name = var.environment_name
}
