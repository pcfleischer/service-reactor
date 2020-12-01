resource "kubernetes_config_map" "config-json" {
  metadata {
    name      = "config-json"
    namespace = var.namespace
  }

  data = {
    "config.json" = <<EOF
{
  "wwwAddress": "0.0.0.0",
  "wwwPort": 8080,
  "serviceAddress": "0.0.0.0",
  "servicePort": 8888,
  "wwwPublicURL": "https://mailslurper.${var.environment_name}.servicereactor.io",
  "servicePublicURL": "https://mailslurper.${var.environment_name}.servicereactor.io/api",
  "smtpAddress": "0.0.0.0",
  "smtpPort": 25,
  "dbEngine": "SQLite",
  "dbHost": "",
  "dbPort": 0,
  "dbDatabase": "./mailslurper.db",
  "dbUserName": "",
  "dbPassword": "",
  "maxWorkers": 1000,
  "keyFile": "",
  "certFile": "",
  "adminKeyFile": "",
  "adminCertFile": "",
  "authenticationScheme": "",
  "authSecret": "",
  "authSalt": "",
  "authTimeoutInMinutes": 120,
  "credentials": {}
}
EOF
  }
}

output "output_name" {
  value = kubernetes_config_map.config-json.metadata[0].name
}
