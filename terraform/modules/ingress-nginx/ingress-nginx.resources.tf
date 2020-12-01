# https://medium.com/flant-com/comparing-ingress-controllers-for-kubernetes-9b397483b46b
# this: https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx
# not this: https://github.com/nginxinc/kubernetes-ingress/tree/master/deployments/helm-chart
# https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/
resource "helm_release" "ingress-nginx" {
  name              = "ingress-nginx"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  namespace         = var.namespace
  dependency_update = true

  set {
    name  = "controller.extraArgs.default-ssl-certificate"
    value = "local/tls-default"
  }
}
