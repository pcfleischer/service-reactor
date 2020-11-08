resource "kubernetes_namespace" "terraform" {
  metadata {
    name = "terraform"
  }
}

terraform {
  backend "kubernetes" {
    load_config_file = true
    secret_suffix    = "state"
  }
}
