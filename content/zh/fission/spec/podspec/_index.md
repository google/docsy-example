---
title: "Add PodSpec to spec file"
date: 2019-12-06T13:39:39+08:00
---

# What is PodSpec

A pod in Kubernetes is basic unit of deployment. Like every Kubernetes resource the pod consists of the basic declaration, metadata, spec & status.

```
apiVersion: v1
kind: Pod
metadata:
  labels:
    svc-name: svc-name
  name: podname
spec:
  containers:
```

The spec in a pod, also known as PodSpec, defines [the specifications](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status) 
of many behaviors in a declarative manner. A PodSpec defines the containers, environment variables for the container and other properties such as the scheduler name, security context etc.

```
spec:
  containers:
    env:
    - name: ENV_NAME
      value: ENV_VALUE
    image: image_url
    imagePullPolicy: IfNotPresent
  dnsPolicy: ClusterFirst
  nodeName: nodename
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: fission-svc
```

In this section we will look at various use cases that are possible with PodSpec support in Fission. 
To learn more about how specs please check [this documentation link]({{% relref "_index.md"%}}).

# Many More!

Here are some ideas for how you can use PodSpec to enhance your function pods:

- You can add a **custom scheduler** to be used for specific functions.
- Additional security policies and settings can be set with **security context** field in PodSpec.
- Introduced in Kubernetes 1.11 **readiness gates** allow extra feedback to the pod status and enable advanced mechanism to signal to Kubernetes that the pod can now serve production traffic.
- **Priority and priority Class Name** are used with a custom admission controller so you can set the priorities of the pods and effectively allocate resources to pods/functions with higher priority.
- **Node selector** allows scheduling function pods on specific nodes of the cluster.
- **Image Pull Secrets** will enable using private registries for all your images!
