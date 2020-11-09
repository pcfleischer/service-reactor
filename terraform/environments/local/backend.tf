terraform {
  backend "kubernetes" {
    config_context   = "docker-desktop"
    load_config_file = true
    secret_suffix    = "state"
  }
}
