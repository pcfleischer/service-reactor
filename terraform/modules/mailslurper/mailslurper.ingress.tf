module "mailslurper-ingress" {
  source           = "../../modules/ingress"
  name             = "mailslurper"
  subdomain        = "mailslurper"
  environment_name = var.environment_name
  namespace        = element([module.mailslurper-namespace.output_name], 0)
  service_name     = "mailslurper"
  service_port     = 8080
  ingress_class    = "nginx"
}

module "mailslurper-api-ingress" {
  source           = "../../modules/ingress"
  name             = "mailslurper-api"
  subdomain        = "mailslurper"
  environment_name = var.environment_name
  namespace        = element([module.mailslurper-namespace.output_name], 0)
  service_name     = "mailslurper"
  service_port     = 8888
  ingress_class    = "nginx"
  path             = "/api(/|$)(.*)"
  rewrite_target   = "/$2"
}
