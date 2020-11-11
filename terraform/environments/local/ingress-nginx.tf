module "ingress-nginx" {
  source           = "../../modules/ingress-nginx"
  environment_name = var.environment_name
}

