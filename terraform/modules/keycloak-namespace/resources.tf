resource "kubernetes_namespace" "keycloak" {
  metadata {
    annotations = {
      name = "keycloak"
    }

    labels = {
      "app"         = "keycloak"
      "environment" = var.environment_name
    }

    name = "keycloak"
  }
}

output "output_name" {
  value = "keycloak"
}
