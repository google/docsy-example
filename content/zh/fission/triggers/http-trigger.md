---
title: "HTTP Trigger"
date: 2019-12-17T14:38:00+08:00
weight: 1
---

An HTTP trigger invokes a function when there is an HTTP request.

You can specify the relative URL and HTTP method for a trigger:

```bash
$ fission httptrigger create --url /hello --method GET --function hello
trigger '94cd5163-30dd-4fb2-ab3c-794052f70841' created

$ curl http://$FISSION_ROUTER/hello
Hello World!
```

{{% notice info %}} 
FISSION_ROUTER is the externally-visible address of your
Fission router service.  For how to set up environment variable
`FISSION_ROUTER`, see [here]({{% relref "../installation/env_vars.zh.md" %}})
{{% /notice %}}

Also, we can create a trigger contains URL parameter by putting placeholders in value of `--url` flag.

```bash
$ fission httptrigger create --method GET \
    --url "/guestbook/messages/{id}" --function restapi-get
```

Since fission uses gorilla/mux as underlying URL router, you can write regular expression to filter out illegal API requests.

```bash
$ fission httptrigger create --method GET \
    --url "/guestbook/messages/{id:[0-9]+}" --function restapi-get
```

{{% notice info %}} 
Learn how to access URL parameters in function to develop a **REST API**, please visit [here]({{% relref "../usage/accessing-url-params.md" %}})
{{% /notice %}}

If you want to use Kubernetes Ingress for the HTTP Trigger, you can
provide the `--createingress` flag and a hostname.  If the hostname is
not provided, it defaults to "*", which indicates a wildcard host.

```bash
$ fission httptrigger create --url /hello --method GET --function hello --createingress --host acme.com
trigger '94cd5163-30dd-4fb2-ab3c-794052f70841' created

$ fission route list
NAME                                 METHOD HOST     URL      INGRESS FUNCTION_NAME
94cd5163-30dd-4fb2-ab3c-794052f70841 GET    acme.com /hello   true    hello
```

Please note that for ingress to work, you will have to deploy an ingress controller in Kubernetes cluster. Kubernetes currently supports and maintains the following ingress controllers:

- [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx)
- [GCE Ingress Controller](https://github.com/kubernetes/ingress-gce)

Other Ingress controllers exist, such as [F5 networks](http://clouddocs.f5.com/products/connectors/k8s-bigip-ctlr/v1.5/) and [Kong](https://konghq.com/blog/kubernetes-ingress-controller-for-kong/).
