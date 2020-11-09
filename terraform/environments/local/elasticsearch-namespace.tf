
module "elasticsearch-namespace" {
  source           = "../../modules/elasticsearch-namespace"
  environment_name = var.environment_name
}
