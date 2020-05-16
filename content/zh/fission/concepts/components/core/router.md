---
title: "Router"
weight: 4
description: >
  Bridge between triggers and functions
---

# Brief Intro

The router forwards HTTP requests to function pods. If there's no
running service for a function, it requests one from executor, while
holding on to the request; the router will forward the request to 
the pod once the function service is ready.

The router is the only stateless component and can be scaled up if needed, according to
load.

# Diagram

{{< img "../assets/router.png" "Fig.1 Router" "45em" "1" >}}

1. Client sends requests to a specific URL on the Router.
2. Router returns 404 if there is no matching HTTP Trigger exists. </br>
If a trigger exists, then check whether the function service record exists in cache. </br>
If cache hits, go to step 4; otherwise, go to step 3.
3. Ask Executor to provide the service address of the Function.
4. Router redirects requests to the address just returned.
