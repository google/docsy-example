---
title: "Sidecar and Init Container"
date: 2019-12-06T16:52:08+08:00
---

# Init container

Functions could also benefit from an **initialization process** before actually executing the functions. 
The initialization could allow you to fetch data from a remote bucket, for example, before actually starting the processing. 

PodSpec allow you to **define init containers** and also use volumes like we did in the previous example.

```
apiVersion: fission.io/v1
kind: Environment
...
spec:
  runtime:
    podspec:
      initContainers:
      - name: init-py
        image: fission/python-env 
        command: ['sh', '-c', 'cat /etc/infopod/labels']
        volumeMounts:
          - name: infopod
            mountPath: /etc/infopod
            readOnly: false
      volumes:
        - name: infopod
          downwardAPI:
            items:
              - path: "labels"
                fieldRef:
                  fieldPath: metadata.labels
```

We can see that the init container runs first, before the actual function containers run:

```
$ kubectl -n fission-function get pod
NAME                                               READY     STATUS            RESTARTS   AGE
poolmgr-python-default-9eik2gxd-6fdc8d9696-hkkgn   0/2       Init:0/1          0          10s
poolmgr-python-default-9eik2gxd-6fdc8d9696-lpmgl   0/2       PodInitializing   0          10s
poolmgr-python-default-9eik2gxd-6fdc8d9696-tkmdc   0/2       PodInitializing   0          10s
```

And the init container here is simply printing the file which was mounted and we can verify the same by looking at logs of the init container:

```
$ kubectl -n fission-function logs -f poolmgr-python-default-9eik2gxd-6fdc8d9696-lpmgl -c init-py
environmentName="python"
environmentNamespace="default"
environmentUid="68e3f909-3e86-11e9-9378-42010aa00057"
executorInstanceId="dqaukdxy"
executorType="poolmgr"
pod-template-hash="2987485252"
```

# Sidecar container

You can also **add a sidecar** to the function container with PodSpec:

```
    podspec:
      # A container which will be merged with for pool manager
      Containers:
      - name: nodep
        image: fission/node-env
        volumeMounts:
          - name: funcvol
            mountPath: /etc/funcdata
            readOnly: true
      # A additional container in the pods
      - name: yanode
        image: fission/node-env
        command: ['sh', '-c', 'sleep 36000000000']
```
