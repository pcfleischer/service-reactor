module "fluentd" {
  source           = "../../modules/fluentd"
  environment_name = var.environment_name
}