resource "kubernetes_ingress" "ingress" {
  metadata {
    name      = "${var.service_name}-ingress"
    namespace = var.namespace

    annotations = {
      "kubernetes.io/ingress.class"                = var.ingress_class
      "nginx.ingress.kubernetes.io/app-root"       = var.app_root
      "nginx.ingress.kubernetes.io/rewrite-target" = var.rewrite_target
    }

    labels = {
      "app" = var.service_name
    }
  }

  spec {
    rule {
      host = "${var.environment_name}.servicereactor.io"
      http {
        path {
          path = var.path
          backend {
            service_name = var.service_name
            service_port = var.service_port
          }
        }
      }
    }
  }
}
