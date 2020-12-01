module "mailslurper" {
  source    = "../../modules/mailslurper"
  namespace = element([module.service-namespace.output_name], 0)
}
