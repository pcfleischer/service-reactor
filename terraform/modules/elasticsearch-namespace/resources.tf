resource "kubernetes_namespace" "elasticsearch" {
  metadata {
    annotations = {
      name = "elasticsearch"
    }

    labels = {
      "app"         = "elasticsearch"
      "environment" = var.environment_name
    }

    name = "elasticsearch"
  }
}

output "output_name" {
  value = "elasticsearch"
}
