provider "helm" {
  kubernetes {
    config_context   = "docker-desktop"
    load_config_file = true
  }
}

provider "kubernetes" {
  config_context   = "docker-desktop"
  load_config_file = true
}
