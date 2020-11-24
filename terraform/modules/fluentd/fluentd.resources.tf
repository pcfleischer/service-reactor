module "fluentd-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "fluentd"
}

resource "helm_release" "fluentd" {
  name              = "fluentd"
  repository        = "https://kokuwaio.github.io/helm-charts"
  chart             = "fluentd-elasticsearch"
  namespace         = element([module.fluentd-namespace.output_name], 0)
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
    value = "elasticsearch-master.elasticsearch.svc.cluster.local:9200"
  }

}