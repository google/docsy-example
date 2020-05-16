---
title: "Docker Desktop"
weight: 7
description: >
  Docker Desktop specific setup 
---

# Docker desktop with Kubernetes

[Docker desktop](https://www.docker.com/products/docker-desktop) allows you to run and manage Docker and Kubernetes on 
workstations for local development. This tutorial will walk through setting up and using Fission on Docker for desktop 
and known issues and workarounds.

You will need to enable Kubernetes by going to Kubernetes tab in preferences. If you are doing this first time then 
the downloading of Kubernetes binaries will take a few minutes. Once Kubernetes is fully running - you should see green 
icon and the text "Kubernetes is running" as shown in screenshot below.

![](../assets/docker-desktop.png)

It should also configure Kubectl installed on your machine. For more details check documentation 
specific to [Docker for Windows](https://docs.docker.com/docker-for-windows/) or [Docker for Mac](https://docs.docker.com/docker-for-mac/)

# Installing Fission

See [Fission installation]({{%relref "_index.zh.md" %}}) to learn more how to install Fission.

# Accessing Routes

If you look at router service - it is exposed as random NodePort on host machine. The port can be found with the command bellow:

```bash
$ export PORT=$(kubectl get svc router -n fission -o jsonpath='{.spec.ports[0].nodePort}')
```

So if we create a route to function, we should be able to access it as shown below:

```bash
$ fission route create --name helloscale --function helloscale --url helloscale
trigger 'helloscale' created

$ curl http://localhost:$PORT/helloscale
```

If you are using the `serviceType` as LoadBalancer, access router on its external IP address, by default using port `80`.

# Autoscaling

Docker for desktop by default does not ship with metric server. So if you create a function of newdeployment executor type, you will see that autoscaling does not work as expected. This is because the HPA does not get actual consumption of pods and the value remains <unknown>. This can be fixed by installing the metric server.

```bash
$ kubectl get hpa -nfission-function
NAME                                    REFERENCE                                          TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
newdeploy-helloscale-default-ql0uqiwp   Deployment/newdeploy-helloscale-default-ql0uqiwp   <unknown>/50%   1         6         1          20h
```

To install the metric server, clone the repo https://github.com/kubernetes-incubator/metrics-server and change the metric-server's command to use insecure certificates in YAMLs in deploy directory.

``` yaml
containers:
- name: metrics-server
  image: k8s.gcr.io/metrics-server-amd64:v0.3.3
  command:
    - /metrics-server
    - --kubelet-insecure-tls
```

Once you have changed the command create the metric server by applying the manifests:

```bash
$ kubectl apply -f deploy/1.8+/
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
serviceaccount/metrics-server created
deployment.extensions/metrics-server created
service/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
```

After a few minutes you can validate that metric server is working by running command:

```bash
$ kubectl top node
NAME                 CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
docker-for-desktop   662m         16%    1510Mi          79%
```

You will also notice that HPA has picked up the values from pod and now you can do autoscaling!

```bash
$ kubectl get hpa -nfission-function
NAME                                    REFERENCE                                          TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
newdeploy-helloscale-default-gkxdkl8y   Deployment/newdeploy-helloscale-default-gkxdkl8y   20%/50%   1         6         1          48s
```

Even after installing metric server if the HPA does not show the current usage of pod - please check if you have given limit as well as request limit for CPU while creating function:

```bash
$ fission fn create --name helloscale --env nodescale  --code hello.js --executortype newdeploy --minmemory 64 --maxmemory 128 --mincpu 100 --maxcpu 500 --minscale 1 --maxscale 6  --targetcpu 50
```
For more details on autoscaling please [check this section of documentation]({{% relref "../usage/executor.zh.md" %}}#autoscaling)
