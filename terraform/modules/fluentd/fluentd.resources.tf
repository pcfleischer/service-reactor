resource "helm_release" "fluentd" {
  name              = "fluentd"
  repository        = "https://kokuwaio.github.io/helm-charts"
  chart             = "fluentd-elasticsearch"
  namespace         = var.namespace
  dependency_update = true

  set {
    name  = "application"
    value = "fluentd"
  }

  set {
    name  = "costApplication"
    value = "service-reactor"
  }

  set {
    name  = "environment"
    value = var.environment_name
  }

  set {
    name  = "elasticsearch.hosts"
    value = "elasticsearch-master.${var.namespace}.svc.cluster.local:9200"
  }

}
