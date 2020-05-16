---
title: "Executor"
weight: 3
description: >
  Component to spin up function pods
---

# Brief Intro

Executor is the component to spin up function pods for functions. When Router receives 
requests to a function, it checks whether a function service record exists in its cache. 
If cache misses, the function service record was found or expired, it asks Executor to 
provide a new one. Executor then retrieves function information from Kubernetes CRD and 
invokes one of the executor types to spin up function pods. Once the function pods are up, 
a function service record that contains the address of a service/pod will be returned.

Fission now supports two different executor types:

* PoolManager
* NewDeploy

These two executor types have different strategies to launch, specialize, and manage pod(s).
You should choose one of the executor types wisely based on the scenario.

# Diagram

{{< img "../assets/executor.png" "Fig.1 Executor" "40em" "1" >}}

1. Router asks the service address of a function.
2. Executor retrieves function information from CRD, and invokes one of executor type to get the address. 

# Executor Type

## PoolManager 

PoolManager manages **pools of generic containers** and function containers.

It watches the environment CRD changes and eagerly creates `generic pools
for environments`. The pool size of initial "warm" containers can be 
configured based on user needs. **Resource requirements are specified at 
environment level and are inherited by specialized function pods**.

The environment container runs in a pod with the `fetcher` container. 
Fetcher is a straightforward utility that downloads a URL sent to it 
and saves it at a configured location (shared volume).

The implementation chooses a generic pod from the pool, relabels it to
"orphan". The PoolManager invokes fetcher to copy the function 
into the pod and hit the specialize endpoint on the environment container. 
This causes the function to be loaded. The pod is now specific to that 
function and is used for subsequent requests for that function. If there are 
no more requests for a certain idle duration, then this pod is cleaned up. 
If a new requests come after the earlier specialized pod was cleaned up, 
then a new pod is specialised from the pool and used for execution.

PoolManager is great for functions that are **short-living** and requires a **short 
cold start time** [1].

However, PoolManager has certain limitations. It selects only one pod per function, 
which is not suitable for serving massive traffic. In such cases, you should consider
using NewDeploy as executor type of function.

[1] The cold start time depends on the package size of the function. If it's
a snippet of code, the cold start time usually is less then 100ms.

### Diagram

{{< img "../assets/poolmanager.png" "Fig.2 PoolManager" "50em" "1" >}}

1. PoolManager watches environment changes.
2. It creates/deletes the pool when an environment is created/deleted. 
3. Router asks the service address of a function.
4. Executor retrieves function information from CRD
5. Invoke PoolManager to spin up function pod.
6. PoolManager selects a generic pod from the warm pool.
7. Specialize the selected generic pod to make it a function pod.
8. The service address is returned to the Router. In this case, the address is the IP of the pod.
9. Router redirects requests to the address just returned.

## New-Deployment 

New-Deployment executor (referred to as NewDeploy) creates `a Kubernetes Deployment` along 
with `a Service and HorizontalPodAutoscaler(HPA)` for function execution. 

NewDeploy creates **a Kubernetes Deployment along with a Service and HorizontalPodAutoscaler(HPA)** 
for function execution and make it suitable for functions that handle massive traffic.

This enables autoscaling of function pods and load balancing the requests between pods. 
**Resource requirements can be specified at the function level and these requirements 
override those specified in the environment.**

NewDeploy will scale the replicas of a function deployment to the minimum feasible scale setting, 
if the minimum scale setting of a function is greater than 0. The 'fetcher' inside the pod uses a URL 
in the JSON payload, which is attached as a parameter to start fetcher, to download the 
function package instead of waiting for calls from NewDeploy.

When a function experiences a traffic spike, the service helps to distribute the requests to 
pods belonging to the function for better workload distribution and lower latency. Also, 
the HPA scales the replicas of the deployment based on the conditions set by the user.
If there are no requests for certain duration then the idle pods are cleaned up.
 
This approach though increases the cold time of a function, but also makes NewDeploy 
suitable for functions designed to **serve massive traffic**.

For requests where latency requirements are stringent, a minscale greater than zero can be set. 
This essentially keeps a minscale number of pods ready when you create a function. When the function 
is invoked, there is no delay since the pod is already created. Also minscale ensures that the pods 
are not cleaned up even if the function is idle. This is great for functions where lower latency is 
more important than saving resource consumption when functions are idle.

### Diagram

{{< img "../assets/newdeploy.png" "Fig.3 NewDeploy" "50em" "1" >}}

1. Router asks the service address of a function.
2. Executor retrieves function information from CRD
3. Invoke NewDeploy to spin up function pods.
4. NewDeploy creates three Kubernetes resources: Deployment, Service, HPA.
5. The Service's address is returned to the Router.
6. Router redirects requests to the address just returned.
7. Service load balance requests to pods.

# The latency vs. idle-cost tradeoff

The executors allow you as a user to decide between latency and a small idle cost trade-off. 
Depending on the need you can choose one of the combinations which is optimal for your use 
case. In future, a more intelligent dispatch mechanism will enable more complex combinations 
of executors.

| Executor Type | Min Scale | Latency | Idle cost |
|:--------------|:---------:|:-------:|:----------|
|Newdeploy      |0          |High     |Very low, pods get cleaned up after idle time|
|Newdeploy      |> 0         |Low      |Medium, min scale number of pods are always up|
|Poolmgr        |0          |Low      |Low, pool of pods are always up|

# Autoscaling

The new deployment based executor provides autoscaling for functions based on CPU usage. In future 
custom metrics will be also supported for scaling the functions. You can set the initial and maximum 
CPU for a function and target CPU at which autoscaling will be triggered. Autoscaling is useful for 
workloads where you expect intermittant spikes in workloads. It also enables optimal the usage of 
resources to execute functions, by using a baseline capacity with minimum scale and ability to burst 
up to maximum scale based on spikes in demand.

{{% notice info %}}
Learn more further usage/setup of **executor type** for functions, please see [here]({{% relref "../../../usage/executor.zh.md" %}}).
{{% /notice %}}
