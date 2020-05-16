---
title: "OpenShift"
weight: 5
description: >
  OpenShift specific setup 
---

# Installing Fission

See [Fission installation]({{%relref "_index.zh.md" %}}) to learn more how to install Fission.

# Run Logger as privileged container

The reason to run Logger pods as privileged container is because Fission mounts `hostPath` volume to FluentBit to
read container log files and data persistence. 

The persistence is for FluentBit [tail plugin](https://github.com/fluent/fluent-bit-docs/blob/master/input/tail.md) 
to read/write it’s own sqlite database. Fission itself doesn’t persist anything.

```
Optionally a database file can be used so the plugin can have a history of tracked 
files and a state of offsets, this is very useful to resume a state if the service is restarted. 
```

Once the logger restarted, it ensures no duplicate logs will be sent to log database.

You may need to add `privileged` permission to service account `fission-svc`. 

```bash
oc adm policy add-scc-to-user privileged -z fission-svc
```

* Reference: https://github.com/fluent/fluentd-kubernetes-daemonset#running-on-openshift

# Prometheus

* Follow [this guide](https://docs.openshift.com/container-platform/4.2/monitoring/cluster-monitoring/configuring-the-monitoring-stack.html#creating-cluster-monitoring-configmap_configuring-monitoring) 
to deploy Prometheus to OpenShift cluster. 

* Get Prometheus server URL by following [Accessing Prometheus, Alertmanager, and Grafana](https://docs.openshift.com/container-platform/4.2/monitoring/cluster-monitoring/prometheus-alertmanager-and-grafana.html#monitoring-accessing-prometheus-alertmanager-grafana-directly_accessing-prometheus). 

For example, if we have `https://prometheus-k8s-openshift-monitoring.apps._url_.openshift.com` as Prometheus server URL, encode following config with base64

```sh
$ base64 <<EOF
canary:
  enabled: true
  prometheusSvc: "https://prometheus-k8s-openshift-monitoring.apps._url_.openshift.com"
EOF
```

Patch configmap `feature-config` in `fission` namespace with output from previous step

```sh
$ kubectl -n fission patch configmap feature-config \
    -p '{"data":{"config.yaml":"Y2FuYXJ5OgogIGVuYWJsZWQ6IHRydWUKICBwcm9tZXRoZXVzU3ZjOiAiaHR0cHM6Ly9wcm9tZXRoZXVzLWs4cy1vcGVuc2hpZnQtbW9uaXRvcmluZy5hcHBzLl91cmxfLm9wZW5zaGlmdC5jb20iCg"}}'
```

Delete controller pod to enforce it to reload the config.

```sh
$ kubectl -n fission delete pod -l svc=controller
``` 
