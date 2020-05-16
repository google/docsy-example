---
title: "Environment Variable"
date: 2019-12-06T17:02:55+08:00
---

Functions sometimes require to pass-in parameter through environment variable to control
internal behavior of a function like `GOMAXPROCS` for Go or you may want to expose
secret/configmap as environment variable. In such cases, we can add `env` to PodSpec.

{{% notice info %}}
As Docker doesn't support to change configuration of a container once it's created. 
To ensure different executor types have consistent behavior, Fission only supports to 
set environment variable at Environment-level now.
{{% /notice %}}

# Add environment variable

Let's try to add environment variable setting to `fetcher` container  

```yaml
apiVersion: fission.io/v1
kind: Environment
...
spec:
  runtime:
    podspec:
      containers:
      - name: fetcher
        env:
        - name: LOG_LEVEL
          value: info
```

Now, you shall see the environment variable in container 

```sh
$ kubectl -n fission-function exec -it <pod> -c fetcher sh
/ # env
LOG_LEVEL=info
```

# Expose Secret/ConfigMap as environment variable

Let's create a ConfigMap called `my-configmap`.

```yaml
$ kubectl -n fission-function create configmap my-configmap --from-literal=TEST_KEY="TESTVALUE"
```

And add PodSpec with `configMapKeyRef` to environment spec file.

```yaml
apiVersion: fission.io/v1
kind: Environment
...
spec:
  runtime:
    podspec:
      containers:
      - name: fetcher
        env:
          - name: TEST_KEY
            valueFrom:
              configMapKeyRef:
                name: my-configmap
                key: TEST_KEY
```

```sh
$ kubectl -n fission-function exec -it <pod> -c fetcher sh
/ # env
TEST_KEY=TESTVALUE
```
