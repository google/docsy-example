---
title: "Packaging source code"
draft: false
weight: 35
---

### Creating a Source Package

Before you create a package, you need to create an environment with an
associated builder image:

```bash
$ fission env create --name pythonsrc --image fission/python-env:latest --builder fission/python-builder:latest --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 2
environment 'pythonsrc' created
```

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

Now create an archive before creating the package:

```
$zip -jr demo-src-pkg.zip sourcepkg/
  adding: __init__.py (stored 0%)
  adding: build.sh (deflated 24%)
  adding: requirements.txt (stored 0%)
  adding: user.py (deflated 25%)
```
Using the source archive created in previous step, you can create a package in Fission:

```bash
$ fission package create --sourcearchive demo-src-pkg.zip --env pythonsrc --buildcmd "./build.sh"
Package 'demo-src-pkg-zip-8lwt' created
```

Since we are working with a source package, we provided the build
command. Once you create the package, the build process will start and
you can see the build logs with the `fission package info` command:

```bash
$ fission pkg info --name demo-src-pkg-zip-8lwt
Name:        demo-src-pkg-zip-8lwt
Environment: pythonsrc
Status:      succeeded
Build Logs:
Collecting pyyaml (from -r /packages/demo-src-pkg-zip-8lwt-v57qil/requirements.txt (line 1))
  Using cached PyYAML-3.12.tar.gz
Installing collected packages: pyyaml
  Running setup.py install for pyyaml: started
    Running setup.py install for pyyaml: finished with status 'done'
Successfully installed pyyaml-3.12
```

Using the package above you can create the function. Since package
already is associated with a source package, environment and build
command, these will be ignored when creating a function. 

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

### Creating a Deployment Package

Before you create a package you need to create an environment with the builder image:
```bash
$ fission env create --name pythondeploy --image fission/python-env:latest --builder fission/python-builder:latest --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 2
environment 'pythondeploy' created
```

We will use a simple Python example which outputs "Hello World!" in a directory to create a deployment archive:

```bash
$ cat testDir/hello.py
def main():
    return "Hello, world!"

$zip -jr demo-deploy-pkg.zip testDir/

```
Using the archive and environments created previously, you can create a package:

```bash
$ fission package create --deployarchive demo-deploy-pkg.zip --env pythondeploy
Package 'demo-deploy-pkg-zip-whzl' created
```

Since it is a deployment archive, there is no need to build it, so the build logs for the package will be empty:

```bash
$ fission package info --name demo-deploy-pkg-zip-whzl
Name:        demo-deploy-pkg-zip-xlaw
Environment: pythondeploy2
Status:      succeeded
Build Logs:
```

Finally you can create a function with the package and test the function:

```bash
$ fission fn create --name deploypy --pkg demo-deploy-pkg-zip-whzl --entrypoint "hello.main"

$ fission fn test --name deploypy
Hello, world!
```

While these examples illustrate how to use packages, you don't have to
use them every time you need to build your source code.  A better way
is to use [Specifications]({{% relref "../spec/_index.md" %}}).
