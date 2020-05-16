---
title: "KubeWatcher"
weight: 3
description: >
  Hawkeye to watch resource changes in Kubernetes cluster
---

# Brief Intro

Kubewatcher watches the Kubernetes API and invokes functions
associated with watches, sending the watch event to the function.

The controller keeps track of the user's requested watches and associated
functions. Kubewatcher watches the API based on these requests; when
a watch event occurs, it serializes the object and calls the function
via the router.

While a few simple retries are done, there isn't yet a reliable
message bus between Kubewatcher and the function. Work for this is
tracked in issue #64.

# Diagram

{{< img "../assets/kubewatcher.png" "Fig.1 KubeWatcher Trigger" "30em" "1" >}}

1. KubeWatcher watches the changes of the resource defined by the user.
2. Invoke functions if anything changed.
