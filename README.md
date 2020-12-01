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

### Kubernetes Management

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

## Namespaces

The goal of ServiceReactor namespace strategy is to eventually allow ephemeral environments to be created within shared cluster for continuous integration and delivery.

It is also worth noting there are several challenges with working across namespaces for networking (ingress, certificate binding)

## Services

### Kubernetes Ingress Controller

The kbernetes ingress controller is distribution of an nginx container that handles all the routing for ingress to the services on the cluster.  It is like a managed nginx instance instead of manually installing and configuring nginx.  Using this controller is the preferred way of ingress site binding for location (hostname) and path based routing.


`terraform apply --target module.ingress-nginx`

https://kubernetes.github.io/ingress-nginx/examples/rewrite/

https://kubernetes.github.io/ingress-nginx/deploy/

When working with this controller it is important to not confuse the kubernetes ingress controller with the nginx commercial ingress controller.  There are variety of options for ingress that offer many features that are worth checking out:

https://medium.com/flant-com/comparing-ingress-controllers-for-kubernetes-9b397483b46b

#### Path Site Binding

Browser apps may lack support for a "base url" for path based routing, this is because some resources may assume an absolute url for the host.

For example, if you attempt to use path based routing for a ui like the below...
http://local.servicereactor.io/admin/service-name/index.html

Will proxy to the service succesfully...
http://service-endpoint/index.html

However the resources in the static pages may not be aware of the proxy path and the browser will be unable to find the resources
Expected...
```
<script src="/admin/service-name/static/my-javascript.js"></script>
```
Actual...
```
<script src="/static/my-javascript.js"></script>
```

#### Location Site Binding

The default ingress binding is to use the service name as a subdomain.  

<service>.<environment>.servicereactor.io

The service reactor domain for local has a wildcard subdomain fo

*.local.servicereactor.io -> 127.0.0.1

```
╭─ ~/service-reactor/terraform/environments/local
╰─± ping test12345.local.servicereactor.io
PING test12345.local.servicereactor.io (127.0.0.1): 56 data bytes
```

Eventually we look to support a DNS provider (cloudflare, google, aws) and dynamic environments with tunnelling.

### Keycloak

Keycloak is an identity and access management solution. 

`terraform apply --target module.keycloak`

For a list of helm variables, see the chart repository on codecentric github repository.

https://github.com/codecentric/helm-charts/tree/master/charts/keycloak

Eventually we will move postgres to its own chart to manage separately.

#### Keycloak Ingress

Using the nginx ingress all traffic to keycloak.${env}.servicereactor.io will be routed to keycloak.  Additional ingress hostname and path combinations will be used to support accessing multiple services.

http://keycloak.local.servicereactor.io/auth/

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

Prometheus collects kubernetes metrics for the cluster, this allows users to view cpu and memory usage in tools like lens.

http://prometheus.local.servicereactor.io/graph

`terraform apply --target module.prometheus`

https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus

If you apply terraform, prometheus chart will be installed by default.  If you use a kubernetes client like lens you may need to reload the application to view metrics.

You can also directly access prometheus through a proxy or by setting up a port forward:
```
kubectl --namespace=prometheus port-forward deploy/prometheus-server 9090
```

### ElasticSearch

`terraform apply --target module.elasticsearch`

### Kibana

http://kibana.local.servicereactor.io/app/home#/

https://github.com/elastic/helm-charts/tree/master/kibana

`terraform apply --target module.kibana`

## Networking

### DNS

ServiceReactor is currently using externally mangaged Cloudflare to control domain servicereactor.io.  This is being currently managed by Terraform from a separate repository for security reasons.

A wildcard subdomain is being used for local and sandbox environments.


> *.local.servicereactor.io -> 127.0.0.1
> 
> *.sandbox.servicereactor.io -> google cloud

### TLS

In order to easily setup TLS, a cert-manager controller module is included.  This is currently setup to more easily manage certificate creating and binding to ingress controllers.

The terraform modules produce a wildcard default certificate for the environment/namespace.  This allows to easily add new service ingresses by subdomain without having to generate new certificates.

`*.${environment}.servicereactor.io`

For local and ephemeral environments, these will be self-signed certificates, you can trust them:

***Mac:***
```bash
# view the public key
openssl s_client -showcerts -connect local.servicereactor.io:443 </dev/null
# output public key to file
openssl s_client -showcerts -connect local.servicereactor.io:443 </dev/null 2>/dev/null | openssl x509 -outform PEM > local-servicereactor-io.pem

# optional: attempt to delete old versions
# sudo security remove-trusted-cert -d local-servicereactor-io.pem
# sudo security delete-certificate -c local.servicereactor.io

# add public key to 
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain local-servicereactor-io.pem
```

***Browsers***

Some browsers have varying policies on certificate management, firefox for example requires a configuration to be set to allow the browser to use the OS system settings for certificate trusts instead of its internal store.

Firefox: https://support.mozilla.org/bm/questions/1175296

`security.enterprise_roots.enabled` on the `about:config` page

### Tunneling

TODO:
* explore allowing ngrok or argo tunnels to local ephemeral machines
* explore ingress "external-dns" to automatically manage dns creation and mapping

### cloudflare / ngrok

https://developers.cloudflare.com/argo-tunnel/

brew install cloudflare/cloudflare/cloudflared

## Troubleshooting

* Docker Desktop Kubernetes - stuck "Starting"

Issue: https://github.com/docker/for-mac/issues/3649 has a workaround, but the result is the kubernetes is basically "reset", use with caution.
> Deleting the PKI folder (~/Library/Group Containers/group.com.docker/pki)

## Knnown Issues

* Dependencies on clean kubernetes
