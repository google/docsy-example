---
title: "Exposing Functions With Ingress"
draft: false
weight: 5
---

Ingress is a Kubernetes built-in resource that allows accessing Kubernetes services from outside of cluster with help of a ingress controller. There are many ingress controllers available to use [webpage](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/#additional-controllers).

This tutorial will walk you through exposing a function using an ingress controller (You can read more about ingress and ingress controller [here](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-controllers)). We will make the function available on a fully qualified domain name (FQDN) using Fission's route and ingress controller setup in a cloud environment.

# Setup & pre-requisites

You will need a Kubernetes cluster with Fission installed (Please
check [installation page]({{% relref "../../installation/" %}}) for details). This tutorial uses a cloud load balancer, but if you are using Minikube you might want [to take a look at details here](https://github.com/kubernetes/minikube/issues/496)

Later parts of this tutorial use a FQDN to reach the function. If you plan to go along in this section, you will need a domain name setup and access to modify the NS records and create A record in the zone of the domain name you have. The tutorial uses Google cloud to walk through the tutorial but you can use any cloud you prefer to. Also the changes in name server can take 24-48 hours so you may want to use an already created domain name.

# Setup an Ingress Controller

First thing we will need is an ingress controller and we will use Nginx ingress controller in this tutorial. Based on your setup you can choose [one of the multiple ways to install Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/). This setup should work with other ingress controllers also but has not been tested.

Let's verify that the installation succeeded:

```bash
$ kubectl get all -n ingress-nginx
NAME                                           READY     STATUS    RESTARTS   AGE
po/default-http-backend-66b447d9cf-4q8f7       1/1       Running   0          19d
po/nginx-ingress-controller-58fcfdc6fd-2cwts   1/1       Running   0          19d

NAME                       CLUSTER-IP      EXTERNAL-IP      PORT(S)                      AGE
svc/default-http-backend   10.11.243.109   <none>           80/TCP                       19d
svc/ingress-nginx          10.11.245.254   35.200.150.175   80:31000/TCP,443:30666/TCP   19d

NAME                              DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/default-http-backend       1         1         1            1           19d
deploy/nginx-ingress-controller   1         1         1            1           19d

NAME                                     DESIRED   CURRENT   READY     AGE
rs/default-http-backend-66b447d9cf       1         1         1         19d
rs/nginx-ingress-controller-58fcfdc6fd   1         1         1         19d

```

Following are key points to validate that ingress controller installation succeeded (Please refer to output of a successful installation above)

- The ingress controller pod is up and running
- The ingress-nginx service has a external IP address populated
- If you hit the external IP address of the ingress-nginx, you get the default backend page:

```bash
$ curl http://35.200.150.175

default backend - 404
```

 Deploying Function with ingress

An ingress resource allows traffic from outside the cluster to reach the services inside the cluster. The ingress is fulfilled by an ingress controller. In following sections we will create a function and enable traffic outside the cluster to reach the function.

# Create a function

We will create an environment, a function and test that it works:

```bash
$ fission env create --name nodejs --image fission/node-env
environment 'nodejs' created

$ cat hello.js 
module.exports = async function(context) {
    return {
        status: 200,
        body: "Hello, Fission!\n"
    };
}

$ fission fn create --name hello --env nodejs --code hello.js 
function 'hello' created

$ fission fn test --name hello
Hello, Fission!
```

# Create a internal route

Let's create a route which is not exposed via the ingress controller so that it can be consumed by resources inside the cluster only.

Currently since functions are also exposed via the Fission router, the function can be accessed from outside the cluster but in future the router may not expose all functions outside the cluster.

```bash
$ fission route create --url /ihello --function hello
trigger '249838c9-9ae3-492a-bba1-b0464ae65671' created

$ fission route list
NAME                                 METHOD HOST URL     INGRESS FUNCTION_NAME
249838c9-9ae3-492a-bba1-b0464ae65671 GET         /ihello false   hello
```

This route will be accessible at `http://$FISSION_ROUTER/ihello` but if tried to access on the ingress controller address `http://<INGRESS-CONTROLLER-EXTERNAL-IP>/ihello` you will get a default backend page. This is expected result as we did not create an ingress for this route.

# Create a external route

Now let's create a route which we will expose over ingress controller. We will create a route with `createingress` flag enabled:

```bash
$ fission route create --url /hello --function hello --createingress
trigger '301b3cb0-5ac1-4211-a1ed-2b0ad9143e34' created

$ fission route list
NAME                                 METHOD HOST URL     INGRESS FUNCTION_NAME
249838c9-9ae3-492a-bba1-b0464ae65671 GET         /ihello false   hello
301b3cb0-5ac1-4211-a1ed-2b0ad9143e34 GET         /hello  true    hello
```
If you check the ingress controller pod logs, you will notice that the ingress controller has re-loaded the configuration for the newly created ingress resource:

```plaintext
I0604 12:47:08.983567       5 controller.go:168] backend reload required
I0604 12:47:08.985535       5 event.go:218] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"fission", Name:"301b3cb0-5ac1-4211-a1ed-2b0ad9143e34", UID:"64bffe8c-67f5-11e8-98e8-42010aa00018", APIVersion:"extensions", ResourceVersion:"18017617", FieldPath:""}): type: 'Normal' reason: 'CREATE' Ingress fission/301b3cb0-5ac1-4211-a1ed-2b0ad9143e34
I0604 12:47:09.117629       5 controller.go:177] ingress backend successfully reloaded...
```

If you now hit the function at ingress controller's IP and the path (`http://<INGRESS-CONTROLLER-EXTERNAL-IP>/hello`), you will get function's response. Depending on your setup and settings, you will have to try HTTP or HTTPS. Some ingress controllers enable SSL redirect by default and hence the HTTPS URL has to be accessed.

```bash
$ curl -k  https://35.200.150.175/hello
Hello, Fission!
```

# Create a FQDN route

This is an optional step and pre-requisites should be fulfilled before proceeding. You can map the FQDN to function if you have DNS setup and access. You need to do a few steps:

- Map the domain name's name server to your cloud provider. For example we used domain name fission.sh and mapped the name server to google cloud (Since this tutorial setup is on Google cloud). The instructions are specific to your domain name provider, please check the documentation of the provider.

- Create a zone for the root domain in the cloud provider (Created a zone for fission.sh in google cloud)

- Create a sub-domain A record that maps to the IP address of Ingress Controller load balancer. In this tutorial we created a A record in the zone above for ing.fission.sh and pointed to the IP of ingress controller load balancer i.e. 35.200.150.175 (A records can take 30 minutes to 4 hours to update)

- If all these steps are configured properly, we can hit the function at FQDN like below:

```bash
$ curl -k  https://ing.fission.sh/hello
Hello, Fission!
```
