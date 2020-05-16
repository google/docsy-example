---
title: "Contributing to Fission"
weight: 250
description: >
  How to contribute to Fission 
---

{{% notice info %}}
You only need to do this if you're making Fission changes; if you're
just deploying Fission, use fission.yaml which points to prebuilt
images.
{{% /notice %}}

You'll need the `go` compiler and tools installed. You'll also need
[docker](https://docs.docker.com/install) for building images.

The server side is compiled as one binary ("fission-bundle") which
contains controller, executor, router and all other core components; 
it invokes the right one based on command-line arguments.

To clone the repo, install dependencies and build `fission-bundle` container image:

{{% notice info %}}
If you want to build the image with the docker inside
minikube, you'll need to set the proper environment variables with
`eval $(minikube docker-env)`
{{% /notice %}}

```sh
# Clone the repo
$ git clone https://github.com/fission/fission.git $GOPATH/src/github.com/fission/fission
$ cd $GOPATH/src/github.com/fission/fission

# Enable go module and get dependencies
$ export GO111MODULE=on
$ go mod vendor

# Run checks on your changes
$ ./hack/verify-gofmt.sh
$ ./hack/verify-govet.sh
```

You now need to build the container image for fission. You can push it to
a docker hub account. But it's easier to use minikube and its
built-in docker daemon:

```sh
$ eval $(minikube docker-env)
$ docker build -t minikube/fission-bundle:<tag> -f cmd/fission-bundle/Dockerfile.fission-bundle .
```
Replace the `<tag>` with any tag you want (e.g., minikube/fission-bundle:latest). 

Next, pull in the dependencies for the Helm chart:

```sh
$ helm dep update $GOPATH/src/github.com/fission/fission/charts/fission-all
```

Next, install fission with this image on your kubernetes cluster using the helm chart:

```sh
$ helm install --set "image=minikube/fission-bundle,imageTag=<tag>,pullPolicy=IfNotPresent,analytics=false" charts/fission-all
```
Replace `<tag>` with the tag used to build the `minikube/fission-bundle` image. 

And if you're changing the CLI too, you can build it with:

```sh
$ cd $GOPATH/src/github.com/fission/fission/cmd/fission-cli
$ go build -o $GOPATH/bin/fission
```

Finally, reset to the original current working directory:

```sh
$ popd
```
