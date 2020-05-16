---
title: "Declarative Specifications (Spec)"
weight: 60
description: >
  Source Code Organization and Your Development Workflow
---

You've made a Hello World function in your favorite language, and
you've run it on your Fission deployment.  What's next?

How should you organize source code when you have lots of functions?
How should you automate deployment into the cluster?  What about
version control?  How do you test before deploying?

The answers to these questions start from a common first step: how do
you ***specify an application***?

# Spec

Instead of invoking the Fission CLI commands, you can specify your
functions in a set of YAML files.  This is better than scripting the
`fission` CLI, which is meant as a user interface, not a programming
interface.

You'll usually want to track these YAML files in version control along
with your source code.  Fission provides CLI tools for generating
these specification files, validating them, and "applying" them to a
Fission installation.

What does it mean to _apply_ a specification?  It means putting
specification to effect: figuring out the things that need to be
changed on the cluster, and updating them to make them the same as the
specification.

Applying a Fission spec goes through these steps:

 * Resources (functions, triggers, etc) that are in the specification
   but don't exist on the cluster are created.  Local source files are
   packaged and uploaded.
   
 * Resources that are both in the specs and on the cluster are
   compared.  If they're different, the ones on the cluster are
   changed to match the spec.
   
 * Resources present only on the cluster and not in the spec are
   destroyed.  (This deletion is limited to resources that were
   created by a previous _apply_; this makes sure that Fission doesn't
   delete unrelated resources.  See below for how this calculation
   works.)

Note that running _apply_ more than once is equivalent to running it
once: in other words, it's ***idempotent***.

# Usage Summary

Start using Fission's declarative application specifications in 3 steps:

 1. Initialize a directory of specs: `fission spec init`
 1. Generate some YAMLs: `fission function create --spec ...`
 1. Apply them to a cluster: `fission spec apply --wait`

You can also deploy continuously with `fission spec apply --watch`.

We'll see examples of all these commands in the tutorial below.

# Tutorial

This tutorial assumes you've already set up Fission, and tested a
simple hello world function to make sure everything's working.  To
learn how to do that, head over to the [installation
guide]({{% relref "../installation" %}}).

We'll make a small calculator app with one python environment and two
functions, all of which will be declaratively specified using YAML
files.  This is a somewhat contrived example, but it is just meant as
an illustration.

## Make an empty directory

```bash
$ mkdir spec-tutorial
$ cd spec-tutorial
```

## Initialize the specs directory

```bash
$ fission spec init
```

This creates a `specs/` directory.  You'll see a `fission-config.yaml`
in there.  This file has a unique ID (deployment ID) in it; everything created on the cluster from these specs 
will be annotated with that deployment ID.

Note that the deployment ID is generated automatically whenever you initialized the specs directory. 
In some cases you may want to do initialization for multiple times. In order to update
to the same set of resources, you can specify the deployment ID by adding `--deployid`.

```bash
$ fission spec init --deployid xxxx-yyyy-zzzz
```

## Setup a Python environment

```bash
$ fission env create --spec --name python --image fission/python-env --builder fission/python-builder
```

This command creates a YAML file under specs called `specs/env-python.yaml`.

## Code two functions

We will create two functions in python along with an empty `requirements.txt` file so that builder is able to build the code. We will put the functions in their own directory with the requirements.txt file.

```bash
.
├── eval
│   ├── eval.py
│   └── requirements.txt
├── form
│   ├── form.py
│   └── requirements.txt
└── specs

```

First function simply returns a simple web form, here are the contents of the file `form.py`:

```python
def main():
    return """
       <html>
         <body>
           <form action="/eval" method="GET">
             Number 1 : <input name="num_1"/>
             <br>
             Number 2: <input name="num_2"/>
             <br>
             Operator: <input name="operator"/>
             <input type="submit" value="submit">
           </form>
         </body>
       </html>
    """
```

The form accepts a simple arithmetic expression.  When it is
submitted, it makes a request to the second function, which calculates
the expression entered.

The second function `eval.py` is pretty simple too:

```python
from flask import request

def main():
    num_1 = int(request.args.get('num_1'))
    num_2 = int(request.args.get('num_2'))
    operator = request.args.get('operator')

    if operator == '+':
        result = num_1 + num_2
    elif operator == '-':
        result = num_1 - num_2
        
    return "%s %s %s = %s" % (num_1, operator, num_2, result)
```

## Create specs for these functions

Let's create a specification for each of these functions.  This
specifies the function name, where the code lives, and associates the
function with the python environment:

```bash
$ fission function create --spec --name calc-form --env python --src "form/*" --entrypoint form.main
$ fission function create --spec --name calc-eval --env python --src "eval/*" --entrypoint eval.main
```

You can see the generated YAML files in
`specs/function-calc-form.yaml` and `specs/function-calc-eval.yaml`.

## Create HTTP trigger specs

```bash
$ fission route create --spec --method GET --url /form --function calc-form
$ fission route create --spec --method GET --url /eval --function calc-eval
```

This creates YAML files specifying that GET requests on /form and /eval
invoke the functions calc-form and calc-eval respectively.

## Validate your specs

Spec validation does some basic checks: it makes sure there are no
duplicate functions with the same name, and that references between
various resources are correct.

```bash
$ fission spec validate
```

You should see no errors.

## Apply: deploy your functions to Fission

You can simply use apply to deploy the environment, functions and HTTP
triggers to the cluster. This command will wait for builds of both functions to complete before exiting:

```bash
$ fission spec apply --wait
1 environment created: python
2 packages created: python-1543660299-o4e9, python-1543660287-byam
2 functions created: calc-eval, calc-form
2 HTTPTriggers created: bac55924-03a8-42e1-81b9-8079a8885f3a, f16c8459-3c23-46ad-901f-9312f38cec2a
--- Build SUCCEEDED ---
--- Build SUCCEEDED ---
```

If the build fails, you can rebuild the package using rebuild command: 

```
--- Build FAILED: ---
Build timeout due to environment builder not ready
------
$ fission package rebuild --name python-1543660299-o4e9
```

## Test a function

You can check the function is working with `fission fn test` but since this function returns a HTML, it is best to open in browser.

```bash
$ fission function test --name calc-form
```

Open the URL of the Fission router service suffixed by the name of route at which form function is exposed. For more details on getting the address of Fission router please check [the link](https://docs.fission.io/latest/installation/env_vars/#fission-router-address)

```
http://$FISSION_ROUTER/form
```

You can enter two number and operator and see the results. Currently this function only supports addition and subtraction.

(If you don't know the address of the Fission router, you can find it
with kubectl: `kubectl -n fission get service router`.)

## Modify the function and re-deploy it

Let's try modifying a function: let's change the `calc-eval` function
to support multiplication, too.

```python
    ...

    elif operator == '*':
        result = num_1 * num_2

    ...
```

You can add the above lines to `eval.py`. To deploy your changes, simply apply the specs again:

```bash
$ fission spec apply --wait
```

This should output something like:

```
1 archive updated: calc-eval-xyz
1 package updated: calc-eval-xyz
1 function updated: calc-eval
```

Your new updated function is deployed! Test it out by entering a `*` for the operator in the form!

## Add dependencies to the function

Let's say you'd like to add a pip dependency in `requirements.txt` to your function,
and include some libraries in it, so you can `import` them in your
functions. Add a library to the requirements.txt and modify the ArchiveUploadSpec inside specs/function-<name>.yaml. Once again, deploying is the same:

```bash
$ fission spec apply --wait
```

This command figures out that one function has changed, uploads the
source to the cluster, and waits until the Fission builder on the
cluster finishes rebuilding this updated source code.

# A bit about how this works

Kubernetes manages its state as a set of _resources_.  Deployments,
Pod, Services are examples of resources.  They represent a target
state, and Kubernetes then does the work to ensure this target state
is met.

Kubernetes resources can be extended, using _Custom Resources_.
Fission runs on top of Kubernetes and sets up your functions,
environments and triggers as Custom Resources.  You can see even these
custom resources from `kubectl`: try `kubectl get
customeresourcedefinitions` or `kubectl get function.fission.io`

Your specs directory is, basically, set of resources plus a bit of
configuration.  Each YAML file contains one or more resources.  They
are separated by a "---" separator.  The resources are functions,
environments, triggers.

There's a special resource there, _ArchiveUploadSpec_.  This is in
fact not a resource, just looks like one in the YAML files.  It is
used to specify and name a set of files that will be uploaded to the
cluster.  `fission spec apply` uses these `ArchiveUploadSpec`s to
create archives locally and upload them.  The specs reference these
archives using `archive://` URLs.  These aren't "real" URLs; they are
replaced by http URLs by the `fission spec` implementation after the
archives are uploaded to the cluster.  On the cluster, Archives are
tracked with checksums; the Fission CLI only uploads archives when
their checksum has changed.

# Improve Portability of Spec (1.7.0+)

Sometimes you may want to release spec files only without the function source code or the compiled binary. To improve
the portability, you can specify a URL that points to the target archive by following the step described in [here]({{% relref "../usage/url-as-archive-source.md" %}}).

# More Examples

For more specs example, visit https://github.com/fission/fission/tree/master/examples/spec-example
