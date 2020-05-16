---
title: "Host, Path, Annotations and TLS"
weight: 2
---

## Annotations (`--ingressannotation`)

You can specify annotations to ingress when creating the HTTP trigger.  If you want to disable TLS auto redirect and enable regular expression matching in [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx),
you can add annotations such as:

```bash
$ fission route create --name foo \
    --url /foo --function foofn --createingress \
    --ingressannotation "nginx.ingress.kubernetes.io/ssl-redirect=false" \
    --ingressannotation "nginx.ingress.kubernetes.io/use-regex=true"
```

**NOTE**: The format of annotation depends on the underlying ingress controller being used. You should check the respective documentation for details.

## Host Rule (`--ingressrule`)

The format of rule is `host=path`, you have to give host and API endpoint path with delimiter `=` between them.  If the rule is not provided, fission uses path specified by `--url` and allows requests from all hosts. For example, if you want to expose your function to the path **/foobar** and allow access from all hosts, you can do 

```
$ fission route create --name foobar --method GET --function nodejs --url "/foobar" --createingress --ingressrule "*=/foobar"
```  

Which results in ingress definition like below:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: foobar
  namespace: fission
  ...
spec:
  rules:
  - http:
      paths:
      - backend:
          serviceName: router
          servicePort: 80
        path: /foobar
```

If you want to limit the accessibility of function to a specific hosts, specify the host rule like `--ingressrule "example.com=/foobar"` 

```
spec:
  rules:
  - host: example.com
    http:
      paths:
      - backend:
          serviceName: router
          servicePort: 80
        path: /foobar
```  
 
**NOTE**: The format of rule depends on the underlying ingress controller you are using.

In case of [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx) for example, to support wildcard path you need to:
 
* Enable regular expression matching by adding annotation to the Ingress. 
* Specify the router URL as `/foo/{bar}` and set path to `/foo/*`. ([Issue](https://github.com/fission/fission/issues/1158))

```bash
$ fission route create --name foo \
        --url /foo/{bar} --function foofn --createingress \
        --ingressannotation "nginx.ingress.kubernetes.io/use-regex=true" \
        --ingressrule "*=/foo/*"
```

## TLS (`--ingresstls`)

To enable TLS termination, you need to follow the [guide](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) to create the secret that contains TLS private key and certificate. For Fission you just have to specify the secret name when creating HTTP trigger.

```bash
$ fission route create --name foo \
    --url /foo/{bar} --function foofn --createingress \
    --ingressannotation "nginx.ingress.kubernetes.io/ssl-redirect=false" \
    --ingressannotation "nginx.ingress.kubernetes.io/use-regex=true" \
    --ingressrule "*=/foo/*"
    --ingresstls "foobartls"
```

For details, see [PR#1325](https://github.com/fission/fission/pull/1284) and [PR#1326](https://github.com/fission/fission/pull/1326).
