resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations = {
      name = var.name
    }

    labels = {
      "app"         = var.name
      "environment" = var.environment_name
    }

    name = var.name
  }
}

output "output_name" {
  value = var.name
}
