---
title: "Python3"
weight: 10
---

Fission supports functions written in Python.  Both Python 2.x and
Python 3.x are supported.  In this usage guide we'll cover how to set
up and use a Python environment on Fission, write functions, and work
with dependencies.  We'll also cover basic troubleshooting.

## Before you start

We'll assume you have Fission and Kubernetes setup.  If not, head over
to the [installation guide]({{% relref "../installation/_index.zh.md" %}}).  Verify your Fission setup with:

```
$ fission version
```

## Add the Python environment to your cluster

Fission language support is enabled by creating an _Environment_.  An
environment is the language-specific part of Fission.  It has a
container image in which your function will run.

```
$ fission environment create --name python --image fission/python-env 
```

## Create a simple function in Python

Create a file named `hello.py`:

```python
def main():
    return "Hello, world!"
```

Create a Fission function (this uploads the file to Fission on the
cluster):

```bash
$ fission function create --name hello --env python --code hello.py 
```

Invoke this function through the Fission CLI:

```bash
$ fission function test --name hello
Hello, world!
```

You can also invoke this function by creating an HTTP trigger and
making an HTTP request to the Fission router.  Ensure you have your
router's address in the `FISSION_ROUTER` environment variable as 
[this guide describes]({{% relref "../installation/env_vars.zh.md" %}}#fission-router-address).
Then,

```bash
$ fission route create --method GET --url /hello --function hello 

$ curl $FISSION_ROUTER/hello
Hello, world!
```

## Function input and output interface

In this section we'll describe the input and output interfaces of
Python functions in Fission.  Fission's Python integration is built on
the Flask framework.  You can access HTTP requests and responses as
you do in Flask.  We'll provide some examples below.

### Accessing HTTP Requests

#### HTTP Headers

Write a simple `headers.py` with something like this:

```python
from flask import request

def main():
    try:
        myHeader = request.headers['x-my-header']
    except KeyError:
        return "Header 'x-my-header' not found"
    return "The header's value is '%s'" % myHeader
```

Create that function, assign it a route, and invoke it with an HTTP header:

```bash
$ fission function create --name headers --env python --code headers.py

$ fission route create --url /headers --function headers

$ curl -H "X-My-Header: Hello" $FISSION_ROUTER/headers 
The header's value is 'Hello'
```

#### Query parameters

HTTP Query parameters are the key-value pairs in a URL after the `?`.
They are also available through the request object:

Write a simple `query.py` with something like this:

```python
from flask import request

def main():
    queryParam = request.args.get('myKey')
    return "Value for myKey: %s" % queryParam
```

Create that function, assign it a route, and invoke it with a query parameter:

```bash
$ fission function create --name query --env python --code query.py

$ fission route create --url /query --function query 

$ curl $FISSION_ROUTER/query?myKey=myValue
Value for myKey: myValue
```

#### Body 

HTTP POST and PUT requests can have a request body.  Once again, you
can access this body through the request object.

For requests with a JSON Content-Type, you can directly get a parsed
object with `request.get_json()`
[[docs]](http://flask.pocoo.org/docs/1.0/api/#flask.Request.get_json).  

For form-encoded requests ( application/x-www-form-urlencoded), use
`request.form.get('key')`
[[docs]](http://flask.pocoo.org/docs/1.0/api/#flask.Request.form).

For all other requests, use `request.data`
[[docs]](http://flask.pocoo.org/docs/1.0/api/#flask.Request.data) to
get the full request body as a string of bytes.

You can find the full docs on the request object in [the flask
docs](http://flask.pocoo.org/docs/1.0/api/#incoming-request-data).

### Controlling HTTP Responses

The simplest way to return a response is to return a string.  This
implicitly says that your function succeeded with a status code of
200; the returned string becomes the body.  However, you can control
the response more closely using the Flask `response` object.

#### Setting Response Headers

```python
import flask

def main():
    resp = flask.Response("Hello, world!")
    resp.headers['X-My-Response-Header'] = 'Something'
    return resp
```

#### Setting Status Codes 

```python
import flask

def main():
    resp = flask.Response("Hello, world!")
    resp.status_code = 200
    return resp
```

#### HTTP Redirects

```python
import flask

def main():
    r = flask.redirect('/new-url', code=303)
    
    # Optional; set this to False to force a relative URL redirect.
    # Defaults to True, which converts the redirect to an absolute URL
    # that's only accessible within the cluster.
    r.autocorrect_location_header = False
    
    return r
```

### Logging

```python
from flask import current_app

def main():
    current_app.logger.info("This is a log message")
    return "Hello, world"
```

## Working with dependencies

The examples above show simple one-file functions with no
dependencies.  You can package dependencies with your function, and
even use Fission to download and package up the dependencies.

### Using the Python environment with the builder

Fission supports _builders_, which are language-specific containers
that know how to gather dependencies and build from a source zip file,
into a deployment zip file. 

To use a builder with your environment, create the environment with
the --builder flag:

```sh
$ fission env create --name python --image fission/python-env --builder fission/python-builder
```

### A function with depedencies

Let's take a simple python function which has a dependency on the
`pyyaml` module. We can specify the dependencies in `requirements.txt`
and a simple command to build from source. The tree structure of
directory and contents of the file would look like:

```bash
sourcepkg/
├── __init__.py
├── build.sh
├── requirements.txt
└── user.py
```
And the file contents:

* user.py

```python 
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
```

* requirements.txt

```python 
pyyaml
```

* build.sh

```bash
#!/bin/sh
pip3 install -r ${SRC_PKG}/requirements.txt -t ${SRC_PKG} && cp -r ${SRC_PKG} ${DEPLOY_PKG}
```

Make sure the `build.sh` file is executable:
```bash
$ chmod +x build.sh
```

* Archive these files:

```bash
$ zip -jr demo-src-pkg.zip sourcepkg/
  adding: __init__.py (stored 0%)
  adding: build.sh (deflated 24%)
  adding: requirements.txt (stored 0%)
  adding: user.py (deflated 25%)
```
Using the source archive creared in previous step, you can create a package in Fission:

```bash
$ fission package create --sourcearchive demo-src-pkg.zip --env python --buildcmd "./build.sh"
Package 'demo-src-pkg-zip-8lwt' created
```

Since we are working with a source package, we provided the build
command. Once you create the package, the build process will start and
you can see the build logs with the `fission package info` command:

```bash
$ fission pkg info --name demo-src-pkg-zip-8lwt
Name:        demo-src-pkg-zip-8lwt
Environment: python
Status:      succeeded
Build Logs:
Collecting pyyaml (from -r /packages/demo-src-pkg-zip-8lwt-v57qil/requirements.txt (line 1))
  Using cached PyYAML-3.12.tar.gz
Installing collected packages: pyyaml
  Running setup.py install for pyyaml: started
    Running setup.py install for pyyaml: finished with status 'done'
Successfully installed pyyaml-3.12
```

Using the package above you can create the function. Since this package
is already associated with a source archive, an environment and a
build command, you don't need to provide these while creating a
function from this package.

The only additional thing you'll need to provide is the Function's
entrypoint:

```bash
$ fission fn create --name srcpy --pkg demo-src-pkg-zip-8lwt --entrypoint "user.main"
function 'srcpy' created

# Run the function:
$ fission fn test --name srcpy
a: 1
b: {c: 3, d: 4}
```

## Modifying the runtime environment image

The base runtime image of the Python can also be modified to include
dependencies.  You can do this for dependencies that all your
functions need, thus reducing the size of your function packages (and
improving cold-start times).

First, get a copy of the Fission source, which includes the
Python environment:

```sh
$ git clone github.com/fission/fission
```

Get to the Python environment:

```sh
$ cd fission/environments/python
```

To add package dependencies, edit `requirements.txt` to add what you
need, and rebuild this image as follows:

Next, build and push the container image.  To push your image you'll
need access to a Docker registry.  Let's assume you have a DockerHub
account called "USER".  (You could use any other registry too.)

```sh
$ docker build -t USER/python-env .
$ docker push USER/python-env 
```

Now you can use this image as your function runtime.  You can
re-create the environment, pointing the runtime at this image:

```sh
$ fission env create --name python --image USER/python-env ...
```

Or just update it, if you already have an image:

```
$ fission env update --name python --image USER/python-env ...
```

After this, functions that have the env parameter set to "python" will
use this new customized image for running the functions.
