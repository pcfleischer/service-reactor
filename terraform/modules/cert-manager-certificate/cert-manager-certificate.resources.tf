# https://github.com/jetstack/cert-manager/tree/master/deploy/charts/cert-manager
# https://artifacthub.io/packages/helm/jetstack/cert-manager
resource "helm_release" "cert-manager-certificate" {
  name      = var.name
  chart     = "./../../../helm-charts/charts/cert-manager-certificate"
  namespace = var.namespace

  set {
    name  = "spec.commonName"
    value = var.common_name
  }

  set {
    name  = "spec.dnsNames"
    value = var.dns_names
  }

  set {
    name  = "spec.secretName"
    value = var.secret_name
  }

  set {
    name  = "spec.issuerRef"
    value = var.issuer_name
  }
}

output "output_name" {
  value = var.name
}
