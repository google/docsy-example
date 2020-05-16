---
title: "Toleration"
date: 2019-12-06T16:48:14+08:00
---

**Taints and tolerations** are mechanisms to influence scheduling of pods in Kubernetes. There are use cases where 
you want to schedule specific pods onto machines with certain hardware or specific capabilities such as CPU intensive 
instances. The basic mechanism works by applying taints on nodes of a cluster and tolerations on pods. The pods with 
tolerations matching a certain taint can get scheduled on those nodes. 

Now you can specify tolerations on functions in the function specification. Let's start with tainting two nodes with 
"reservation=fission" and two nodes with "reservation=microservices" as shown below. The intent is that two nodes are 
optimized for functions and other two nodes in cluster are better optimized for long running microservices. We want to 
schedule functions on nodes with taints meant for functions.

```
$ kubectl taint nodes gke-fission-dev-default-pool-87c8b616-549c \
    gke-fission-dev-default-pool-87c8b616-5q2c reservation=fission:NoSchedule
node "gke-fission-dev-default-pool-87c8b616-549c" tainted
node "gke-fission-dev-default-pool-87c8b6aCloud16-5q2c" tainted

$ kubectl taint nodes gke-fission-dev-default-pool-87c8b616-pg05 \
    gke-fission-dev-default-pool-87c8b616-t5q1 reservation=microservices:NoSchedule
node "gke-fission-dev-default-pool-87c8b616-pg05" tainted
node "gke-fission-dev-default-pool-87c8b616-t5q1" tainted
```

First, we create a nodejs environment spec file.

```sh
$ fission env create --spec --name nodejs --image fission/node-env --builder fission/node-builder
```

Let's add PodSpec and toleration for "reservation=fission" to `.spec.runtime`

```yaml
apiVersion: fission.io/v1
kind: Environment
...
spec:
  runtime:
    podspec:
      tolerations:
      - key: "reservation"
        operator: "Equal"
        value: "fission"
        effect: "NoSchedule"
```

You should env have an environment spec file like this

```yaml
apiVersion: fission.io/v1
kind: Environment
metadata:
  creationTimestamp: null
  name: nodejs
  namespace: default
spec:
  builder:
    command: build
    image: fission/node-builder
  imagepullsecret: ""
  keeparchive: false
  poolsize: 3
  resources: {}
  runtime:
    image: fission/node-env
    podspec:
      tolerations:
      - key: "reservation"
        operator: "Equal"
        value: "fission"
        effect: "NoSchedule"
  version: 2
```

Once we apply fission specs and run the function - you will notice that the pods go only on nodes with taints that match the toleration:

```
$ kubectl -n fission-function get pod -o wide
NAME                                                 READY     STATUS    RESTARTS   AGE       IP             NODE
newdeploy-pyfunc-default-kgsuik0l-66cd755675-jgjj6   2/2       Running   0          51s       10.16.177.16   gke-fission-dev-default-pool-87c8b616-549c
poolmgr-python-default-okhvkdsv-57b866b774-hbz7q     2/2       Running   0          49s       10.16.176.34   gke-fission-dev-default-pool-87c8b616-5q2c
poolmgr-python-default-okhvkdsv-57b866b774-hqnl2     2/2       Running   0          49s       10.16.176.35   gke-fission-dev-default-pool-87c8b616-5q2c
poolmgr-python-default-okhvkdsv-57b866b774-pmtzv     2/2       Running   0          49s       10.16.177.17   gke-fission-dev-default-pool-87c8b616-549c
```
