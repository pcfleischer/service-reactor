# https://github.com/jetstack/cert-manager/tree/master/deploy/charts/cert-manager
# https://artifacthub.io/packages/helm/jetstack/cert-manager
resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = var.namespace

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "extraArgs"
    value = "{--enable-certificate-owner-ref=true}"
  }
}

# https://github.com/jetstack/cert-manager/tree/master/deploy/charts/cert-manager
# https://artifacthub.io/packages/helm/jetstack/cert-manager
resource "helm_release" "cert-manager-issuer" {
  name      = var.issuer_name
  chart     = "./../../../helm-charts/charts/cert-manager-issuer"
  namespace = var.namespace

  # depends_on = [  ]
}
