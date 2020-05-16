---
title: "Pull an Image From a Private Registry"
weight: 6
---

With 1.7.0+, you can specify which credential to use for kubelet to pull images from the private registry.

First, you need to follow the [kubernetes guide](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) to create the secret.

{{% notice warning %}}
The secret must be created in the same namespace where the function pods created.<br>
For example, if the function pods are in the `fission-function` namespace, you need to create the secret in `fission-function` as well. 
{{% /notice %}}

Then, specify the secret when creating the environment. 

For example, if we want to create a nodejs environment and use secret `docker-secret` as credential.  

```bash
$ fission environment create --name nodejs --image fission/node-env \
    --imagepullsecret "docker-secret" 
```

You should see `imagePullSecrets` in the environment deployment like following.

```bash
$ kubectl -n fission-function get deploy -l environmentName=nodejs -o yaml

apiVersion: v1
items:
- apiVersion: extensions/v1beta1
  kind: Deployment
  metadata:
    name: poolmgr-nodejs-default-217063
    namespace: fission-function
    ...
  spec:
    ...
    template:
      ...
      spec:
        ...
        imagePullSecrets:
        - name: docker-secret

```

{{% notice warning %}}
Fission won't check if a secret exists nor examining whether the secret setting works as expected.<br>
You have to check the pod status to ensure everything works as expected. 
{{% /notice %}}
