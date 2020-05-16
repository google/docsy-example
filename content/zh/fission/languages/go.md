---
title: "Go"
weight: 10
---

With Go plugin mechanism, fission supports Go as one of function languages.

In this usage guide we'll cover how to use this environment, write functions, and work with dependencies.

## Before you start

We'll assume you have Fission and Kubernetes setup.  If not, head over
to the [install guide]({{% relref "../installation/_index.zh.md" %}}).  Verify your Fission setup with:

``` bash
$ fission version
```

## Add the Go environment to your cluster

Unlike Python, Go is a compiled language that means we need to compile source code before running it. 
Fortunately, builder manager within fission does all this hard work automatically when a Go function/package is created.
The Go builder will convert a source package into a deployable package. 

Due to the Go plugin mechanism, the Go plugin can only be loaded by the server with the exact same Go 
version. Please use the `fission release version` as image tag instead of `latest` when adding a Go environment,
so that you won't experience the compatibility issue once we bump up the Go version.
**(Remember, the image tag of runtime and builder should always be the same.)**

```bash
$ fission environment create --name go --image fission/go-env:<release-version> --builder fission/go-builder:<release-version>

# Example
$ fission environment create --name go --image fission/go-env-1.12:{{% release-version %}} --builder fission/go-builder-1.12:{{% release-version %}}
```

You can find all images and image tags at following table.

### Go environment image list

| Go Version | Image | Builder Image | Go Module Support |
|------------|------------|-----------|----------| 
|  1.9 | [fission/go-env](https://hub.docker.com/r/fission/go-env/tags) | [fission/go-builder](https://hub.docker.com/r/fission/go-builder/tags) |  | 
|  1.11.4 | [fission/go-env-1.11.4](https://hub.docker.com/r/fission/go-env-1.11.4/tags) | [fission/go-builder-1.11.4](https://hub.docker.com/r/fission/go-builder-1.11.4/tags) | | |
|  1.12 | [fission/go-env-1.12](https://hub.docker.com/r/fission/go-env-1.12/tags) | [fission/go-builder-1.12](https://hub.docker.com/r/fission/go-builder-1.12/tags) | V |
|  1.13 | [fission/go-env-1.13](https://hub.docker.com/r/fission/go-env-1.13/tags) | [fission/go-builder-1.13](https://hub.docker.com/r/fission/go-builder-1.13/tags) | V |

## Write a simple function in Go

Here is a hello world example (hw.go) in Go:

```go
// Due to go plugin mechanism,
// the package of function handler must be main package
package main

import (
    "net/http"
)

// Handler is the entry point for this fission function
func Handler(w http.ResponseWriter, r *http.Request) {
    msg := "Hello, world!\n"
    w.Write([]byte(msg))
}
```

The entrypoint of function let go server to know how to load-in plugin file correctly.
Here, our first hello world function's entrypoint is simply the name of function: `Handler`.

```bash
# Create golang env with builder image to build go plugin
$ fission fn create --name helloworld --env go --src hw.go --entrypoint Handler
```

Before accessing function, need to ensure deploy package of function is in _succeeded_ state. 

```bash
$ fission pkg info --name <pkg-name>
```

Now, let's test our first Go function with `test` command

```bash
$ fission fn test --name <function-name>
```

{{% notice info %}} 
See [here]({{% relref "../triggers/_index.md" %}}) for how to setup different trigger for Go function. 
{{% /notice %}} 

## HTTP requests and HTTP responses

From the sample above we know that go server passes HTTP `Request` and `ResponseWriter` to user function for
further processing.

``` go
func Handler(w http.ResponseWriter, r *http.Request) {
    ...
}
```

Following we will go through steps for how to accessing/controlling the requests/responses. 

### Accessing HTTP Requests

#### Headers

```go
package main

import (
    "fmt"
    "net/http"
    "net/textproto"
)

func Handler(w http.ResponseWriter, r *http.Request) {

    // recommend
    v1 := r.Header.Get("HEADER_KEY_1")

    // need to convert string cases manually
    key := textproto.CanonicalMIMEHeaderKey("HEADER_KEY_2")
    // v2 type is []string
    v2, _ := r.Header[key]

    w.Write([]byte(fmt.Sprintf("v1: %s, v2: %v", v1, v2)))
}
```

Let's create a HTTP trigger for the function we created above.

```bash
$ fission httptrigger create --method GET --url "/<url>" --function <fn-namne>
```

```bash
$ curl -X GET http://$FISSION_ROUTER/<url> -H 'HEADER_KEY_1: foo' -H 'HEADER_KEY_2: bar'
v1: foo, v2: [bar]
```

One thing worth to notice is all header key will be converted to the canonical format of the MIME header key.
You can access to header value by calling `request.Header.Get()`. However, if you prefer to access
the value by map index you must convert key format with `textproto.CanonicalMIMEHeaderKey()`.

#### Query string

```go
package main

import (
    "net/http"
)

func Handler(w http.ResponseWriter, r *http.Request) {
    v := r.URL.Query().Get("key-name")
    w.Write([]byte(v))
}
```

```bash
$ curl -X GET http://$FISSION_ROUTER/<url>?key-name=123
123
```

#### Request Body

**PLAIN TEXT**

```go
package main

import (
    "io/ioutil"
    "net/http"
)

func Handler(w http.ResponseWriter, r *http.Request) {
    reqBody, err := ioutil.ReadAll(r.Body)
    if err != nil {
        w.WriteHeader(http.StatusBadRequest)
        w.Write([]byte(err.Error()))
    }

    body := string(reqBody)

    w.Write([]byte(body))
}
```

```bash
$ curl -X POST http://$FISSION_ROUTER/<url> -d foobar
foobar
```


**JSON**

```go
package main

import (
    "encoding/json"
    "net/http"
    "io/ioutil"
)

type msg struct {
    Content string `json:"content"`
}

func Handler(w http.ResponseWriter, r *http.Request) {
    reqBody, err := ioutil.ReadAll(r.Body)
    if err != nil {
        w.WriteHeader(http.StatusBadRequest)
        w.Write([]byte(err.Error()))
    }

    m := msg{}
    err = json.Unmarshal(reqBody, &m)
    if err != nil {
        w.WriteHeader(http.StatusBadRequest)
        w.Write([]byte(err.Error()))
    }

    respBody, err := json.Marshal(m)
    if err != nil {
        w.WriteHeader(http.StatusInternalServerError)
        w.Write([]byte(err.Error()))
    }

    w.Write([]byte(respBody))
}
```

```bash
curl -X POST http://$FISSION_ROUTER/<url> -d '{"content": "foobar"}'
{"content":"foobar"}
```

### Controlling HTTP Responses 

#### Setting Response Headers

```go
package main

import (
    "net/http"
)

func setCORS(w http.ResponseWriter) http.ResponseWriter {
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Headers", "*")
    w.Header().Set("Access-Control-Allow-Credentials", "true")
    w.Header().Set("Access-Control-Allow-Methods", "*")
    w.Header().Set("Access-Control-Expose-Headers", "*")
    return w
}

func Handler(w http.ResponseWriter, r *http.Request) {
    w = setCORS(w)
    w.WriteHeader(http.StatusOK)
}
```

```bash
$ curl -i -X GET "http://$FISSION_ROUTER/<url>"
HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Headers: *
Access-Control-Allow-Methods: *
Access-Control-Allow-Origin: *
Access-Control-Expose-Headers: *
Content-Length: 0
Content-Type: text/plain; charset=utf-8
Date: Sat, 27 Oct 2018 15:00:14 GMT
```

#### Setting Status Codes 

{{% notice warning %}}
**Always write response status code before writing response body!** Otherwise, the client may receive unexpected status code.
{{% /notice %}}

You can set response status code by calling function `writer.WriteHeader()`. However, one thing wroth to notice is
if a function writes response body before status code, the client will receive HTTP 200 OK no matter what actual status code
is. 

```go
package main

import (
    "net/http"
)

func Handler(w http.ResponseWriter, r *http.Request) {
    // DONT
    // w.Write([]byte("foobar"))
    // w.WriteHeader(http.StatusBadRequest)

    // DO
    http.Error(w, "dummy error", http.StatusBadRequest)

    // or DO
    // w.WriteHeader(http.StatusBadRequest)
    // w.Write([]byte("foobar"))
}
```

## Working with dependencies

See full image list [here](#go-environment-image-list)

### Go module support

Please use image version equal or after `fission/go-env-1.12`.

Initialize your project

```bash
$ go mod init "<module>"

# Example
$ go mod init "github.com/fission/fission/examples/go/go-module-example"
```

Follow the [official guide](https://github.com/golang/go/wiki/Modules#daily-workflow) to add project dependencies. 
To clean and verify the dependencies you can:

```bash
$ go mod tidy
$ go mod verify
```

Archive and create package as usual

```bash
$ zip -r go.zip .
    adding: go.mod (deflated 26%)
    adding: go.sum (deflated 1%)
    adding: README.md (deflated 37%)
    adding: main.go (deflated 30%)
    
$ fission pkg create --env go --src go.zip
```

### Add dependencies to vendor directory

**`This part is for the old Go environment that doesn't support Go Moudle`**

Unlike pip for Python has been widely adopted by community, there are various dependency management tools for Go like *gb*, *dep* and *glide*.
Hence fission Go builder image doesn't contain a default tool for downloading dependencies during build processes. 

In order to support 3rd party dependencies, users need to put all necessary packages to `vendor` directory and archive it into source archive.

Following I will use **glide** to demonstrate how to add dependencies to source archive.

```bash
$ mkdir example
$ pushd example
$ glide init --non-interactive
$ glide get "github.com/golang/example/stringutil"
$ curl https://raw.githubusercontent.com/fission/fission/master/examples/go/vendor-example/main.go > main.go
$ zip -r example.zip .
$ fission fn create --name foobar --src example.zip --entrypoint Handler
# wait for package build process
$ fission fn test --name foobar
```

## Custom builds

If no custom build script included in source archive, by default builder manager will execute the [build.sh](https://github.com/fission/fission/tree/master/environments/go/builder)
in go builder image. In this part, we will go through how to run custom build script during the build process.

Before we write our own script, we need to dive into the original build script to see what's useful inside.

```bash
#!/bin/sh

set -eux

srcDir=${GOPATH}/src/$(basename ${SRC_PKG})

trap "rm -rf ${srcDir}" EXIT

if [ -d ${SRC_PKG} ]
then
    echo "Building in directory ${srcDir}"
    ln -sf ${SRC_PKG} ${srcDir}
elif [ -f ${SRC_PKG} ]
then
    echo "Building file ${SRC_PKG} in ${srcDir}"
    mkdir -p ${srcDir}
    cp ${SRC_PKG} ${srcDir}/function.go
fi

cd ${srcDir}
go build -buildmode=plugin -i -o ${DEPLOY_PKG} .
```

There are environment variables as shown above:

1. $SRC_PKG: The path to the source code directory/file.
2. $DEPLOY_PKG: The path to the deploy directory/executable binary.

The steps of build script are:

1. Check the $SRC_PKG is a file or directory
2. Copy/Link source code to $GOPATH
3. Change location to $SRC_PKG, build source code into plugin file then output to $DEPLOY_PKG

For example, we want to add git commit SHA or build timestamp to go binaries like following.

```go
package main

import (
    "fmt"
    "net/http"
)

var (
    Timestamp string
)

// Handler is the entry point for this fission function
func Handler(w http.ResponseWriter, r *http.Request) {
    msg := fmt.Sprintf("Build timestamp: %v", Timestamp)
    w.Write([]byte(msg))
}
```

To set build timestamp we can set it through `ldflags` during build process. But it's not supported with original build script.

Since we understand how a build script (customBuild.sh) works, let's try to modify it a little bit. 

```bash
#!/bin/sh

set -eux

srcDir=${GOPATH}/src/$(basename ${SRC_PKG})

trap "rm -rf ${srcDir}" EXIT

if [ -d ${SRC_PKG} ]
then
    echo "Building in directory ${srcDir}"
    ln -sf ${SRC_PKG} ${srcDir}
elif [ -f ${SRC_PKG} ]
then
    echo "Building file ${SRC_PKG} in ${srcDir}"
    mkdir -p ${srcDir}
    cp ${SRC_PKG} ${srcDir}/function.go
fi


pkgpath=$(basename ${SRC_PKG})
timestamp=$(date +%s)

cd ${srcDir}
go build -ldflags "-X ${pkgpath}.Timestamp=$timestamp" -buildmode=plugin -i -o ${DEPLOY_PKG} .
```

At this moment, the directory structure would be like

```bash
.
├── customBuild.sh
└── main.go
```

Archive source package.

```bash
$ chmod +x customBuild.sh
$ zip -r example.zip .
```

After editing custom build script, next step is to assign a build command for builder to know what command to run with. 

```bash
$ fission fn create --name foobar --env go --src example.zip --entrypoint Handler --buildcmd "./customBuild.sh"
$ fission fn test --name foobar
Build timestamp: 1540566887
```

## Modifying/Rebuild the environment images

For how to rebuild environment image, please visit [here](https://github.com/fission/fission/blob/master/environments/go/README.md)

## Resource usage 

By default, a function can use all resource on node it run on, however, other functions will be affected once a function 
takes too much resources. To prevent this, Fission allows users to specify a resource limitation for function. 

Following are flags to manage function resource usage limitation.

```bash
--mincpu value                         Minimum CPU to be assigned to pod (In millicore, minimum 1)
--maxcpu value                         Maximum CPU to be assigned to pod (In millicore, minimum 1)
--minmemory value                      Minimum memory to be assigned to pod (In megabyte)
--maxmemory value                      Maximum memory to be assigned to pod (In megabyte)
``` 

And you can specify them when creating/updating a function.

```bash
$ fission fn create --name g1 --env go --src example.zip --entrypoint Handler --mincpu 20 --maxcpu 100 --minmemory 128 --maxmemory 256
```

So what's the reasonable resource setting for a function? It really depends on what type of your function is. 

Here's a tip, use `kubectl top` to get actual resource consumption of pod when doing benchmarking. Then you will know what's the best setting for a Go function.

```bash
$ kubectl -n fission-function top pod -l functionName=g1
NAME                                                              CPU(cores)   MEMORY(bytes)
go-1ef65ed0-d5eb-11e8-91e8-080027114863-9x7y4xmh-569bfdd9bhmlrf   112m           6Mi
```


