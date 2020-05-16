---
title: "Accessing Secrets/ConfigMaps"
draft: false
weight: 4
---

Functions can access Kubernetes [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/) and [ConfigMaps](https://kubernetes.io/docs/concepts/storage/volumes/#configmap). Use secrets for things like API keys, authentication tokens, and so on. Use config maps for any other configuration that doesn't need to be a
secret.

# Create a Secret or a Configmap

You can create a Secret or ConfigMap with the Kubernetes CLI:

```bash
$ kubectl -n default create secret generic my-secret --from-literal=TEST_KEY="TESTVALUE"

$ kubectl -n default create configmap my-configmap --from-literal=TEST_KEY="TESTVALUE"
```

Or, use `kubectl create -f <filename.yaml>` to create these from a YAML file.

```yaml
apiVersion: v1
kind: Secret
metadata:
  namespace: default
  name: my-secret
data:
  TEST_KEY: VEVTVFZBTFVF # value after base64 encode
type: Opaque

---
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: default
  name: my-configmap
data:
  TEST_KEY: TESTVALUE
```

# Accessing Secrets and ConfigMaps

Secrets and configmaps are accessed similarly.  Each secret or
configmap is a set of key value pairs. Fission sets these up as files
you can read from your function.

```bash
# Secret path
/secrets/<namespace>/<name>/<key>

# ConfigMap path
/configs/<namespace>/<name>/<key>
```

From the previous example, the paths are:

```bash
# secret my-secret
/secrets/default/my-secret/TEST_KEY

# confimap my-configmap
/configs/default/my-configmap/TEST_KEY
```

Now, let's create a simple python function (leaker.py) that returns
the value of Secret `my-secret` and ConfigMap `my-configmap`.

```python
# leaker.py

def main():
    path = "/configs/default/my-configmap/TEST_KEY"
    f = open(path, "r")
    config = f.read()
    f.close()

    path = "/secrets/default/my-secret/TEST_KEY"
    f = open(path, "r")
    secret = f.read()
    f.close()

    msg = "ConfigMap: %s\nSecret: %s" % (config, secret)

    return msg, 200
```


Create an environment and a function:

```bash
# create python env
$ fission env create --name python --image fission/python-env

# create function named "leaker"
$ fission fn create --name leaker --env python --code leaker.py --secret my-secret --configmap my-configmap
```
You can provide multiple configmaps or secrets while creating a fission function through command line, below syntax can be used to provide more than one configmaps or secrets.
```
# Provide multiple Configmaps
$ fission fn create --name <fn-name> --env <env-name> --code <your-source> --configmap <configmap-one> --configmap <configmap-two>

# Provide multiple Secrets
$ fission fn create --name <fn-name> --env <env-name> --code <your-source> --secret <secret-one> --secret <secret-two>
```

Run the function, and the output should look like this:

```bash
$ fission function test --name leaker
ConfigMap: TESTVALUE
Secret: TESTVALUE
```

# Updating Secrets and ConfigMaps

{{% notice note %}}
If you have a large number of functions using a configmap or secret, updating that configmap or secret will cause a large number of pods getting re-created. Please make sure that the cluster has enough capacity to accommodate the short spike of many pods getting terminated and new once getting created.
{{% /notice %}}


If you update the configmap or secret - the same will be updated in the function pods and newer value of configmap/secret will be used for executing functions. The time it takes for the change to reflect depends on the time it takes for rolling update to finish.


{{% notice note %}}
In Fission version prior to 1.4, If the Secret or ConfigMap value is updated, the function will not get the updated and may get a cached older value.
{{% /notice %}}


