# Helm

Most helm charts should be referred to by repository and customized using values files and property setters in terraform.

```
  name              = <deployment name>
  repository        = <helm chart repository url>
  chart             = <chart name>
  namespace         = var.namespace
  dependency_update = true

```

Manually installing a helm chart or a deployment will not be managed by terraform state management, should generally be used only for exploratory testing.

Charts may be added here temporarily for testing or customiaztion.  Long term customized charts for service reactor should instead be forked or checked into a separate helm chart repo.