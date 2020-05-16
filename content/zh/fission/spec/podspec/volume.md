---
title: "Volume"
date: 2019-12-06T16:50:52+08:00
---

Functions are great for stateless things but there are use cases where functions deal with data, 
that is best attached as volume. For example, functions used in data pipelines would benefit a lot 
from volumes being attached to functions. 

With PodSpec you can now attach a volume to a function. You have to **define a volume** and then 
**mount it on specific container**. In the following example we create a simple volume with Kubernetes 
downward API which dumps information of labels in a file. The volume is then mounted on the function 
container at `/etc/funcdata`

```
apiVersion: fission.io/v1
kind: Environment
...
spec:
  podspec:
    # A container which will be merged with for pool manager
    containers:
    - name: nodep
      image: fission/node-env
      volumeMounts:
        - name: funcvol
          mountPath: /etc/funcdata
          readOnly: true
    volumes:
      - name: funcvol
        downwardAPI:
          items:
            - path: "labels"
              fieldRef:
                fieldPath: metadata.labels
```
