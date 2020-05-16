---
title: "Create Function"
draft: false
weight: 2
---

This section walks through working with functions, for controlling execution of functions please refer to [Controlling Function Execution]({{% relref "./executor.zh.md" %}})

### Create a function

Before creating a function, you'll need an environment; read
[environments]({{% relref "environments.zh.md" %}}) if you
haven't already.

Let's create an environment for our function. 
```bash
$ fission env create --name node --image fission/node-env
```

Let's create a simple code snippet in NodeJS which will output the
string "Hello, world!":

```js
module.exports = async function(context) {
    return {
        status: 200,
        body: "Hello, world!\n"
    };
}
```

Let's create this function on the cluster.  This only registers the
function with Fission, it doesn't run it yet.

```bash
$ fission fn create --name hello --code hello.js --env node
```

Next, let's create a route for the function which can be used for making HTTP requests:

```bash
$ fission route create --function hello --url /hello
trigger '5327e9a7-6d87-4533-a4fb-c67f55b1e492' created
```

Setup [FISSION_ROUTER]({{% relref "../installation/env_vars.zh.md" %}}) environment variable if you haven't already.

When you hit this function's URL, you get the expected response:

```bash
$ curl http://${FISSION_ROUTER}/hello
Hello, world!
```

You can also create a function with executor type "newdeploy" and
provide the minimum and maximum number of instances of the function.

```bash
$ fission fn create --name hello2 --code hello.js --env node --minscale 1 --maxscale 5  --executortype newdeploy
```

### View & update function source code

You can look at the source code associated with given function:

```js
$ fission fn get --name hello
module.exports = async function(context) {
    return {
        status: 200,
        body: "Hello, world!\n"
    };
}
```

Let's say you want to update the function to output "Hello Fission" instead of "Hello world". 

```js
module.exports = async function(context) {
    return {
        status: 200,
        body: "Hello, Fission!\n"
    };
}
```
You can update the source file and update the source code for function:

```bash
$ fission fn update --name hello --code hello.js 
package 'hello-js-ku9s' updated
function 'hello' updated
```

Let's verify that the function now responds with a different output
than it did earlier:

```bash
$ curl http://${FISSION_ROUTER}/hello
Hello, Fission!
```

### Test and debug function

You can run a function using the test command. If the function call succeeds, it will output the function's response. 
```bash
$ fission fn test --name hello
Hello, Fission!
```

But if there is an error in the function's execution (it returns HTTP >= 300), then the logs of function execution are displayed:
```bash
$ fission fn test --name hello
Error calling function hello: 500 Internal server error (fission)

> fission-nodejs-runtime@0.1.0 start /usr/src/app
> node server.js

Codepath defaulting to  /userfunc/user
Port defaulting to 8888
user code load error: SyntaxError: Unexpected token function
::ffff:10.8.1.181 - - [16/Feb/2018:08:44:33 +0000] "POST /specialize HTTP/1.1" 500 2 "-" "Go-http-client/1.1"
```

You can also look at function execution logs explicitly:
```bash
$ fission fn logs --name hello
[2018-02-16 08:41:43 +0000 UTC] 2018/02/16 08:41:43 fetcher received fetch request and started downloading: {1 {hello-js-rqew  default    0 0001-01-01 00:00:00 +0000 UTC <nil> <nil> map[] map[] [] nil [] }   user [] []}
[2018-02-16 08:41:43 +0000 UTC] 2018/02/16 08:41:43 Successfully placed at /userfunc/user
[2018-02-16 08:41:43 +0000 UTC] 2018/02/16 08:41:43 Checking secrets/cfgmaps
[2018-02-16 08:41:43 +0000 UTC] 2018/02/16 08:41:43 Completed fetch request
[2018-02-16 08:41:43 +0000 UTC] 2018/02/16 08:41:43 elapsed time in fetch request = 89.844653ms
[2018-02-16 08:41:43 +0000 UTC] user code loaded in 0sec 4.235593ms
[2018-02-16 08:41:43 +0000 UTC] ::ffff:10.8.1.181 - - [16/Feb/2018:08:41:43 +0000] "POST /specialize HTTP/1.1" 202 - "-" "Go-http-client/1.1"
[2018-02-16 08:41:43 +0000 UTC] ::ffff:10.8.1.182 - - [16/Feb/2018:08:41:43 +0000] "GET / HTTP/1.1" 200 16 "-" "curl/7.54.0"
```

### Fission builds & compiled artifacts

Most real world functions will require more than one source files. It is also easier to simply provide source files and let Fission take care of building from source files. Fission provides first class support for building from source as well as using compiled artifacts to create functions.

You can attach the source/deployment packages to a function or explicitly create packages and use them across functions. Check documentation for [package]({{% relref "./package.zh.md" %}}) for more information.

#### Building functions from source

Let's take a simple python function which has dependency on a python pyyaml module. We can specify the dependencies in requirements.txt and a simple command to build from source. The tree structure of directory looks like:

```plaintext
sourcepkg/
├── __init__.py
├── build.sh
├── requirements.txt
└── user.py
```

And the file contents:

```bash
$ cat user.py 

import sys
import yaml

document = """
  a: 1
  b:
    c: 3
    d: 4
"""

def main():
    return yaml.dump(yaml.load(document))

$ cat requirements.txt 
pyyaml

$ cat build.sh 
#!/bin/sh
pip3 install -r ${SRC_PKG}/requirements.txt -t ${SRC_PKG} && cp -r ${SRC_PKG} ${DEPLOY_PKG}
```

Make sure the `build.sh` file is executable:
```bash
$ chmod +x build.sh
```

You first need to create an environment with environment image and python-builder image specified:

```bash
$ fission env create --name python --image fission/python-env:latest --builder fission/python-builder:latest --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 2
```
Now let's zip the directory containing the source files and create a function with source package:

```bash
$ zip -jr demo-src-pkg.zip sourcepkg/
  adding: __init__.py (stored 0%)
  adding: build.sh (deflated 24%)
  adding: requirements.txt (stored 0%)
  adding: user.py (deflated 25%)

$ fission fn create --name hellopy --env python --src demo-src-pkg.zip  --entrypoint "user.main" --buildcmd "./build.sh"
function 'hellopy' created

$ fission route create --function hellopy --url /hellopy
```
Once we create the function, the build process is started. You can check logs of the builder in fission-builder namespace:

```bash
$ kubectl -n fission-builder logs -f py3-4214348-59555d9bd8-ks7m4 builder
2018/02/16 11:44:21 Builder received request: {demo-src-pkg-zip-ninf-djtswo ./build.sh}
2018/02/16 11:44:21 Starting build...

=== Build Logs ===command=./build.sh
env=[PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin HOSTNAME=py3-4214348-59555d9bd8-ks7m4 PYTHON_4212095_PORT_8000_TCP_PROTO=tcp PY3_4214348_SERVICE_HOST=10.11.250.161 KUBERNETES_PORT=tcp://10.11.240.1:443 PYTHON_4212095_PORT=tcp://10.11.244.134:8000 PYTHON_4212095_PORT_8000_TCP=tcp://10.11.244.134:8000 PYTHON_4212095_PORT_8001_TCP_PROTO=tcp PYTHON_4212095_PORT_8001_TCP_ADDR=10.11.244.134 PY3_4214348_SERVICE_PORT=8000 PY3_4214348_SERVICE_PORT_BUILDER_PORT=8001 PY3_4214348_PORT_8001_TCP=tcp://10.11.250.161:8001 KUBERNETES_PORT_443_TCP_PORT=443 KUBERNETES_PORT_443_TCP_ADDR=10.11.240.1 PY3_4214348_SERVICE_PORT_FETCHER_PORT=8000 PY3_4214348_PORT_8000_TCP=tcp://10.11.250.161:8000 PY3_4214348_PORT_8001_TCP_PORT=8001 PYTHON_4212095_SERVICE_PORT_FETCHER_PORT=8000 PYTHON_4212095_PORT_8000_TCP_ADDR=10.11.244.134 KUBERNETES_SERVICE_HOST=10.11.240.1 PY3_4214348_PORT=tcp://10.11.250.161:8000 PYTHON_4212095_SERVICE_PORT_BUILDER_PORT=8001 PYTHON_4212095_PORT_8001_TCP=tcp://10.11.244.134:8001 PY3_4214348_PORT_8000_TCP_PROTO=tcp PY3_4214348_PORT_8000_TCP_PORT=8000 KUBERNETES_SERVICE_PORT_HTTPS=443 KUBERNETES_PORT_443_TCP=tcp://10.11.240.1:443 PYTHON_4212095_PORT_8001_TCP_PORT=8001 PY3_4214348_PORT_8000_TCP_ADDR=10.11.250.161 PY3_4214348_PORT_8001_TCP_PROTO=tcp KUBERNETES_SERVICE_PORT=443 PYTHON_4212095_SERVICE_PORT=8000 PYTHON_4212095_PORT_8000_TCP_PORT=8000 PY3_4214348_PORT_8001_TCP_ADDR=10.11.250.161 KUBERNETES_PORT_443_TCP_PROTO=tcp PYTHON_4212095_SERVICE_HOST=10.11.244.134 HOME=/root SRC_PKG=/packages/demo-src-pkg-zip-ninf-djtswo DEPLOY_PKG=/packages/demo-src-pkg-zip-ninf-djtswo-c40gfu]
Collecting pyyaml (from -r /packages/demo-src-pkg-zip-ninf-djtswo/requirements.txt (line 1))
  Downloading PyYAML-3.12.tar.gz (253kB)
Installing collected packages: pyyaml
  Running setup.py install for pyyaml: started
    Running setup.py install for pyyaml: finished with status 'done'
Successfully installed pyyaml-3.12
==================
2018/02/16 11:44:24 elapsed time in build request = 3.460498847s
```

Once the build has succeeded, you can hit the function URL to test the function:
```bash
$curl http://$FISSION_ROUTER/hellopy
a: 1
b: {c: 3, d: 4}
```

If you're using Fission with source code, be sure to read about the
recommended [development workflow]({{%relref "../spec/_index.md" %}}).

#### Using compiled artifacts with Fission

In some cases you have a pre-built deployment package which you need to deploy to Fission. For this example let's use a simple python file as a deployment package but in practice it can be any other compiled package.

We will use a simple python file in a directory and turn it into a deployment package:

```bash
$ cat testDir/hello.py
def main():
    return "Hello, world!"

$zip -jr demo-deploy-pkg.zip testDir/

```
Let's use the deployment package to create a function and route and then test it.

```bash
$ fission fn create --name hellopy --env python --deploy demo-deploy-pkg.zip --entrypoint "hello.main"
function 'hellopy' created

$ fission route create --function hellopy --url /hellopy

$ curl http://$FISSION_ROUTER/hellopy
Hello, world!
```

### View function information

You can retrieve metadata information of a single function or list all functions to look at basic information of functions:

```bash
$ fission fn getmeta --name hello
NAME  UID                                  ENV
hello 34234b50-12f5-11e8-85c9-42010aa00010 node

$ fission fn list
NAME   UID                                  ENV  EXECUTORTYPE MINSCALE MAXSCALE TARGETCPU
hello  34234b50-12f5-11e8-85c9-42010aa00010 node poolmgr      0        1        80
hello2 e37a46e3-12f4-11e8-85c9-42010aa00010 node newdeploy    1        5        80
```
