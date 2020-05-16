---
title: "Enabling Istio on Fission"
draft: false
weight: 62
---

This tutorial sets up Fission with [Istio](https://istio.io/) - a service mesh for Kubernetes. The tutorial was tried on GKE but should work on any equivalent setup. We will assume that you already have a Kubernetes cluster setp and working.


### Set up Istio

For installing Istio, please follow the setup guides [here](https://istio.io/docs/setup/kubernetes/install/). You can use a setup that works for you, we used the Helm install for Istio for this tutorial as [detailed here](https://istio.io/docs/setup/kubernetes/install/helm/)


### Install fission

Set default namespace for helm installation, here we use `fission` as example namespace.

```bash
$ export FISSION_NAMESPACE=fission
```

Create namespace & add label for Istio sidecar injection, this will ensure that the the Istio sidecar is auto injected with Fission pods.

```bash
$ kubectl create namespace $FISSION_NAMESPACE
$ kubectl label namespace $FISSION_NAMESPACE istio-injection=enabled
$ kubectl config set-context $(kubectl config current-context) --namespace=$FISSION_NAMESPACE
```

Follow the [installation guide]({{% relref "../installation/_index.zh.md" %}}) to install fission with flag `enableIstio` true.

```bash
$ helm install --namespace $FISSION_NAMESPACE --set enableIstio=true --name istio-demo <chart-fission-all-url>
```

### Create & test a function

Let's first create the environment for nodejs function we want to create:

```bash
$ fission env create --name nodejs --image fission/node-env:latest
```

Let's create a simple function with Node.js environment and a simple hello world example below:

```js
# hello.js
module.exports = async function(context) {
    console.log(context.request.headers);
    return {
        status: 200,
        body: "Hello, World!\n"
    };
}
```

```bash
$ fission fn create --name h1 --env nodejs --code hello.js --method GET
```

Now let's create route for the function

```bash
$ fission route create --method GET --url /h1 --function h1
```

Access function

```bash
$ curl http://$FISSION_ROUTER/h1
Hello, World!
```

### Under the hood

Now that a Fission function did work with Istio, let's check under the hood see how Istio is interacting with system seamlessly. After installation, you will see that all components such as executor, router etc. now have an additional sidecar for istio-proxy and they also had a istio-init as a init container.

```
$ kubectl get pods -nfission
NAME                                                     READY     STATUS             RESTARTS   AGE
buildermgr-86858f4f6c-drhlv                              2/2       Running            0          7m
controller-78cbdfc4fb-vdjsj                              2/2       Running            0          7m
executor-97c7fc96d-9tclp                                 2/2       Running            1          7m

```

```
  containers:
    name: executor
...
...
    image: docker.io/istio/proxyv2:1.0.6
    imagePullPolicy: IfNotPresent
    name: istio-proxy
```

Also all function pods now have 3 containers - the function container, fetcher and now additionally the the istio-proxy container and we can see the istio-proxy logs for function containers.

```
$ kubectl get pods -nfission-function
NAME                                                READY     STATUS    RESTARTS   AGE
newdeploy-hello-default-mmrlkoog-557678fdcd-gw7tz   3/3       Running   2          9m
poolmgr-node-default-esibbicv-65488fbc4d-2hdzc      3/3       Running   0          9m

$ kubectl $ff logs -f newdeploy-hello-default-mmrlkoog-557678fdcd-gw7tz -c istio-proxy
2019-04-02T17:02:42.944608Z info    Version root@464fc845-2bf8-11e9-b805-0a580a2c0506-docker.io/istio-1.0.6-98598f88f6ee9c1e6b3f03b652d8e0e3cd114fa2-Clean
2019-04-02T17:02:42.944647Z info    Proxy role: model.Proxy{ClusterID:"", Type:"sidecar", IPAddress:"10.16.62.23", ID:"newdeploy-hello-default-mmrlkoog-557678fdcd-gw7tz.fission-function", Domain:"fission-function.svc.cluster.local", Metadata:map[string]string(nil)}
2019-04-02T17:02:42.944966Z info    Effective config: binaryPath: /usr/local/bin/envoy
configPath: /etc/istio/proxy
connectTimeout: 10s
discoveryAddress: istio-pilot.istio-system:15007
discoveryRefreshDelay: 1s

```


### Install Istio Add-ons


Istio comes with additional add ons for features such as monitoring, distributed tracing etc. If you have installed Istio with Helm, you can decide which addons to enable in values.yaml:

```
#
# addon prometheus configuration
#
prometheus:
  enabled: true

#
# addon jaeger tracing configuration
#
tracing:
  enabled: true

#
# addon kiali tracing configuration
#
kiali:
  enabled: true

```

We will explore few add ons that we enabled and tried out in the following sections. For each of add-ons you can port-forward the service and watch the UI console of the respective service. For example for Jaeger, you can run the port-forward:

```
kubectl port-forward service/jaeger-query -nistio-system 3000:16686
```


#### Prometheus

Prometheus can scrapes the metrics from Fission and Istio components. Assuming Prometheus installation was done correctly and Fission components are being scraped by the Prometheus instance, you can see graphs related to Fission metrics in Prometheus graph:

![Prometheus](../assets/prometheus_fission.png)


### Grafana

Grafana is used for visualization of metrics and Istio installed Grafana comes with a few dashboards built in. We can see the visualization of mixer stats in below screenshot:

![Grafana](../assets/grafana.png)


### Jaeger

Jaeger allows distributed tracing of requests for function calls. We can see the details of each call to it's granular detail in Jaeger. You have to enable jaeger in Fission installation and point to appropriate URL of the Jaeger collector. You can find more details on [how to configure Jaeger to work with Fission here](https://blog.fission.io/posts/fission-opentracing/)

![jaeger min](../assets/jaeger.png)
