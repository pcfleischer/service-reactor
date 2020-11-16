module "keycloak-namespace" {
  source           = "../../modules/kubernetes-namespace"
  environment_name = var.environment_name
  name             = "keycloak"
}

module "keycloak-ingress" {
  source           = "../../modules/ingress"
  name             = "keycloak"
  subdomain        = "keycloak"
  environment_name = var.environment_name
  namespace        = element([module.keycloak-namespace.output_name], 0)
  service_name     = "keycloak-http"
  service_port     = 80
  ingress_class    = "nginx"
}

resource "random_password" "keycloak-password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "kubernetes_secret" "keycloak_user" {
  metadata {
    name      = "keycloak-user"
    namespace = element([module.keycloak-namespace.output_name], 0)
  }

  data = {
    KEYCLOAK_USER     = "admin"
    KEYCLOAK_PASSWORD = random_password.keycloak-password.result
  }
}

resource "helm_release" "keycloak" {
  name              = "keycloak"
  repository        = "https://codecentric.github.io/helm-charts"
  chart             = "keycloak"
  namespace         = element([module.keycloak-namespace.output_name], 0)
  dependency_update = true

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
    name  = "extraEnv"
    value = <<EOF
- name: JAVA_OPTS
  value: >-
    ${var.heap_options}
    -Djava.net.preferIPv4Stack=true
    -Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS
    -Djava.awt.headless=true
EOF
  }

  set {
    name  = "extraEnvFrom"
    value = <<EOF
- secretRef:
      name: 'keycloak-user'
EOF
  }
}

