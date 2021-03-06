resource "helm_release" "mailslurper" {
  name      = "mailslurper"
  chart     = "./../../../helm-charts/charts/mailslurper"
  namespace = var.namespace

  values = [
    file("${path.module}/../../../helm-charts/charts/mailslurper/values.yaml"),
  ]

  set {
    name  = "image.repository"
    value = "phillipfleischer/mailslurper"
  }

  set {
    name  = "image.tag"
    value = "latest"
  }

  set {
    name  = "resources.limits.cpu"
    value = var.limit_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.limit_memory
  }

  set {
    name  = "resources.requests.cpu"
    value = var.requests_cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.requests_memory
  }

  set {
    name  = "application"
    value = "mailslurper"
  }

  set {
    name  = "costApplication"
    value = "utilities"
  }

  set {
    name  = "environment"
    value = var.environment_name
  }

  set {
    name  = "extraVolumes"
    value = <<EOF
- name: config-volume
  configMap:
    name: config-json
EOF
  }

  set {
    name  = "extraVolumeMounts"
    value = <<EOF
- name: config-volume
  mountPath: "/config.json"
  subPath: "config.json"
EOF
  }
}
