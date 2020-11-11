# Service Reactor
Service Reactor is a project whose goal is to quickly assemble services with common containers and helm charts on any kubernetes provider.

# Table of Contents
1. [Getting Started](#getting-started)
2. [Terraform](#terraform)
3. [Kubernetes](#kubernetes)
4. [Services](#services)

# Getting Started

You'll need:

1. Kubernetes Provider
2. Terraform (tfswitch recommended)
3. Patience

## Terraform

Terraform is a state management deployment system for building, changing, and versioning resources with many community built providers for kubernetes, aws, gcp, azure. This project uses it heavily to coordinate deployments to k8s.

https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs

#### Kubectl Contexts

Terraform resources have k8s context variables which may use any kubernetes target.  Local environments should use docker desktop or minikube.

```
kubectl config get-contexts
kubectl config use-context docker-desktop
```

the terraform requires a specific version of terraform, we recommend using tf switch

```
╭─~/dev/git/service-reactor/service-reactor/terraform/environments/local on main using
╰─± tfswitch
Reading configuration from .tfswitch.toml
Switched terraform to version "0.13.5"
```

## Kubernetes

While the goal of this project is to target any kubernetes provider, the quickest, cheapest, and common way to get started is to use a local kubernetes instance using docker-desktop or minikube.  Feel free to try a different provider and log (and fix) issues.  

https://docs.docker.com/docker-for-mac/kubernetes/

## Kubernetes Management

If you use lens, you're in luck, just sit back and enjoy features like...
- clicking on service to open browser with proxy
- viewing metrics on kubernetes nodes, pods, etc.

You can also setup kubernetes web dashboard instead.

https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

**Apply dashboard deployment**
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
```
```
# start a proxy
kubectl proxy --address 0.0.0.0 --accept-hosts '.*'
# open the proxy in browser and access dashboard service
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=default
# get your token
kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='default')].data.token}"| base64 --decode
```

## Services

### Keycloak

Keycloak is an identity and access management solution. 

`terraform apply --target module.keycloak`

#### Keycloak Ingress

Using the nginx ingress all traffic to ${env}.servicereactor.io will be routed to keycloak.  Additional ingress hostname and path combinations will be used to support accessing multiple services.

http://local.servicereactor.io/auth/

The service can be accesed through a kubernetes proxy as well via: 
http://localhost:8001/api/v1/namespaces/keycloak/services/keycloak-http:80/proxy/auth

However, hostname ingress routing is recommended due to multiple site redirections within the keycloak service.


#### Default Administrator
Terraform generates a random password for the instance and stores it in kubernetes.  This secret is then read as an environment variable during initialization and a default admin is created.

In order to view the random password that Terrform has genereated, use lens or kubectl to extract the value.  It is recommended once the instance has been setup this admin user is removed.

```
kubectl get secret keycloak-user --namespace keycloak -o jsonpath='{.data.KEYCLOAK_PASSWORD}' | base64 --decod
```

### Prometheus

`terraform apply --target module.prometheus`

If you apply terraform, prometheus chart will be installed by default.  If you use a kubernetes client like lens you may need to reload the application to view metrics.

You can also directly access prometheus through a proxy or by setting up a port forward:
```
kubectl --namespace=prometheus port-forward deploy/prometheus-server 9090
```

### Nginx-Ingress

`terraform apply --target module.ingress-nginx`

The ingress is currently configured only to support the keycloak service.  When other services are added there will be more.

https://kubernetes.github.io/ingress-nginx/examples/rewrite/

https://kubernetes.github.io/ingress-nginx/deploy/

### ElasticSearch

`terraform apply --target module.elasticsearch`

### Kibana

`terraform apply --target module.ingress-nginx`

## Networking

TODO: allow external tunnels to local instance 

### cloudflare / ngrok

https://developers.cloudflare.com/argo-tunnel/

brew install cloudflare/cloudflare/cloudflared