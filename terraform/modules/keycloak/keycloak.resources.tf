
resource "random_password" "keycloak-password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "kubernetes_secret" "keycloak_user" {
  metadata {
    name = "keycloak-user"
    namespace = var.namespace
  }

  data = {
    KEYCLOAK_USER = "admin"
    KEYCLOAK_PASSWORD = random_password.keycloak-password.result
  }
}

resource "helm_release" "keycloak" {
  name              = "keycloak"
  chart             = "./../../../helm-charts/charts/keycloak"
  namespace         = var.namespace
  dependency_update = true

  values = [
    file("${path.module}/../../..//helm-charts/charts/keycloak/values.yaml"),
  ]

  set {
    name  = "image.repository"
    value = "docker.io/jboss/keycloak"
  }

  set {
    name  = "image.tag"
    value = ""
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
    value = "keycloak"
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
    name = "extraEnvFrom"
    value = <<EOF
- secretRef:
      name: 'keycloak-user'
EOF
  }
}

