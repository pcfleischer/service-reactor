provider "helm" {
  kubernetes {
    config_context   = var.config_context
    load_config_file = true
  }
}

provider "kubernetes" {
  config_context   = var.config_context
  load_config_file = true
}
