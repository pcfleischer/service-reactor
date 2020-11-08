# service-reactor
service reactor project quickly assemble services with common kuberetes containers and helm charts

## using docker-desktop

```
kubectl config get-contexts
kubectl config use-context docker-desktop
```

## tfswitch
the terraform requires a specific version of terraform, we recommend using tf switch

```
╭─~/dev/git/service-reactor/service-reactor/terraform/environments/local on main using
╰─± tfswitch
Reading configuration from .tfswitch.toml
Switched terraform to version "0.13.5"
```

## kubernetes dashboard

If you use lens, you're in luck, this is setup for you...

You can also setup kubernetes web dashboard instead...

https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
```
# apply the deployment
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
# start a proxy
kubectl proxy --address 0.0.0.0 --accept-hosts '.*'
# open the proxy in browser and access dashboard service
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=default
# get your token
kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='default')].data.token}"| base64 --decode

```

## Keycloak

If you're using kubernetes proxy you can access the service via: 
http://localhost:8001/api/v1/namespaces/keycloak/services/keycloak-http:80/proxy/auth

## prometheus

If you apply terraform, prometheus chart will be installed by default.  If you use a kubernetes client like lens you may need to reload the application to view metrics.

You can also directly access prometheus through a proxy or by setting up a port forward:
```
kubectl --namespace=prometheus port-forward deploy/prometheus-server 9090
```

## nginx-ingress

The ingress is currently configured only to support the keycloak service.  When other services are added there will be more.

https://kubernetes.github.io/ingress-nginx/examples/rewrite/

https://kubernetes.github.io/ingress-nginx/deploy/
