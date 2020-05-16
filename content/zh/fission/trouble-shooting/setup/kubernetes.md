---
title: "Kubernetes"
weight: 1
description: >
  Troubleshoot your Kubernetes cluster setup 
---

In this section, we will cover how to troubleshoot the problems related to Kubernetes cluster setup.

# Check In-Cluster Dns Service

Fission utilizes in-cluster DNS to talk to other components, it's important to ensure that the in-cluster DNS
service is available. 

First, check that we have running DNS pod(s).

```bash
$ kubectl -n kube-system get pod|grep dns
coredns-fb8b8dccf-bjxmj                  1/1     Running   1          65m
```

Create a pod and use `nslookup` to check availability of DNS service. 

```
$ kubectl -n fission get svc
NAME                                       TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
executor                                   ClusterIP      10.103.121.81    <none>        80/TCP         2d

$ kubectl -n fission run busybox --image=busybox --restart=Never --tty -it
/ # nslookup executor
Server:		10.96.0.10
Address:	10.96.0.10:53

Name:	executor.fission.svc.cluster.local
Address: 10.103.121.81
```

The DNS service will return an address which matches the address shown in the previous command. 

For more debugging DNS resolution, see [here](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/). 

# KubeConfig for Connecting to Cluster

Make sure that `~/.kube/config` exists or assign the correct value to `KUBECONFIG`. 

```bash
# https://github.com/fission/fission/issues/1133
Fatal error: Error getting controller pod for port-forwarding
```

If you run the cluster on cloud provider, follow the platform steps to add token to `~/.kube/config` for connecting kubernetes cluster.

* GKE: https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl
* AWS: https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
* Azure: https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster

# Error Upgrading Connection

Please check the pod status & log when CLI prompts `error upgrading connection` error.

```bash
Fatal error: Error forwarding to port 51204: error upgrading connection: 
unable to upgrade connection: pod not found ("controller-b87cd7857-8n75g_fission")
```

# Dynamic Volume Provisioning

Package storage and Prometheus services need persistent volume to store data. 
See [here](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) to learn how to set up dynamic volume provisioning.
And you should be able to list `pvc` and `pv` as follows after setting up.

```bash
$ kubectl -n fission get pvc
NAME                                 STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
bald-otter-prometheus-alertmanager   Bound    pvc-733972f7-c2f2-11e9-9a83-025000000001   2Gi        RWO            hostpath       75m
bald-otter-prometheus-server         Bound    pvc-733cad91-c2f2-11e9-9a83-025000000001   8Gi        RWO            hostpath       75m
fission-storage-pvc                  Bound    pvc-733ec058-c2f2-11e9-9a83-025000000001   8Gi        RWO            hostpath       75m

$ kubectl -n fission get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                        STORAGECLASS   REASON   AGE
pvc-733972f7-c2f2-11e9-9a83-025000000001   2Gi        RWO            Delete           Bound    fission/bald-otter-prometheus-alertmanager   hostpath                75m
pvc-733cad91-c2f2-11e9-9a83-025000000001   8Gi        RWO            Delete           Bound    fission/bald-otter-prometheus-server         hostpath                75m
pvc-733ec058-c2f2-11e9-9a83-025000000001   8Gi        RWO            Delete           Bound    fission/fission-storage-pvc                  hostpath                75m
```

If the underlying platform the cluster running on doesn't support persistent volume, you can set `helm` variable as follows.

```bash
helm install --namespace fission --set persistence.enabled=false .....
```

# Function Doesn't Scale

Fission relies on Kubernetes autoscaling mechanism to scale replicas of function when workloads increase. To enable it,
you have to enable/install the metric server in your cluster. 

```bash
# minikube
$ minikube addons enable metrics-server
```

If you're not running on other platforms, see [metric-server](https://github.com/kubernetes-incubator/metrics-server).

# HPA with Unknown Status

You may see `<unknown>` status as follows. It's because it takes some time for metric-server to collect enough 
information to calculate the right number of replicas after installing metric server. 

```bash
$ kubectl get hpa
NAME         REFERENCE               TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   <unknown>/50%   1         10        1          3m3s
```

You can follow this [guide](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/) to verify the metric-server installation.
