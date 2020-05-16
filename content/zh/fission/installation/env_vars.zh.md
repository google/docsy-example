---
title: Environment Variables
weight: 3
description: >
  Environment variables used by Fission CLI
---

# Namespace

{{% notice info %}}
You only need to set this if there are multiple
Fission installations in **different namespaces** within the same
Kubernetes cluster.
{{% /notice %}}

Set `FISSION_NAMESPACE` to the namespace where the Fission
installed. 

``` bash
$ export FISSION_NAMESPACE <namespace>
```

# Fission Router Address

{{% notice info %}}
You don't need to set this if you're simply running `fission function test --name <fn>`, because 
Fission CLI uses **local port-forward** mechanism to talk to router pod.  
{{% /notice %}}

{{% notice warning %}}
Fission CLI uses value in `FISSION_ROUTER` if it's not empty instead of using local port-forward mechanism. </br>
You need to ensure that the IP address in it is **accessible** from the public network.
{{% /notice %}}

It's convenient to set the `FISSION_ROUTER` environment variable to the
**externally-visible** address of the Fission router.

## Clusters Only Support NodePort

Here we use minikube for example.

``` bash
$ export FISSION_ROUTER=$(minikube ip):$(kubectl -n fission get svc router -o jsonpath='{...nodePort}')
```

Above line translates to IP (from minikube):PORT (from the fission router) e.g., 192.168.99.110:30722. This address is stored in FISSION_ROUTER environment variable. 

## Cloud Hosted Clusters 

If you want to expose the router to the internet, the service type of
router service must be set to `LoadBalancer`.  This is the default in
the helm chart.

```bash
$ kubectl --namespace fission get svc
NAME             TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
router           LoadBalancer   10.107.80.21     <pending>     80:31314/TCP     11d
```

If the field `EXTERNAL-IP` shows `<pending>`, it means that kubernetes
is waiting for cloud provider to allocate the public IP address. It
often takes a few minutes to get an IP address. Then:

``` bash
# AWS
$ export FISSION_ROUTER=$(kubectl --namespace fission get svc router -o=jsonpath='{..hostname}')

# GCP
$ export FISSION_ROUTER=$(kubectl --namespace fission get svc router -o=jsonpath='{..ip}')
```

Check whether there are **firewall rules** that block you from accessing the IP address.

## Troubleshooting

If your cluster is running in an environment that does not support external load balancer (e.g., minikube), the EXTERNAL-IP of fission router will stay in pending state.

```bash
$ kubectl --namespace fission get svc router
NAME      TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
router    LoadBalancer   10.39.253.73   <pending>   80:31377/TCP   27d
```

In this case, you can use the port-forward method instead:

``` bash
# Port-forward
$ kubectl --namespace fission port-forward $(kubectl --namespace fission get pod -l svc=router -o name) <local port>:8888 &
$ export FISSION_ROUTER=127.0.0.1:<local port>
```

Now, `curl http://${FISSION_ROUTER}/` will open a connection that goes
through the port forward you just created.  This is useful for local
testing of your function.
