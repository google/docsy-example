---
title: "Node.js"
weight: 10
---

Fission supports functions written in Nodejs. Current fission nodejs runtime environment supports node version greater than 7.6.0. In this usage guide we'll cover how to use this environment, write functions, and work with dependencies.

## Before you start

We assume you have Fission and Kubernetes setup. If not, head over to the [install guide]({{% relref "../installation/_index.zh.md" %}}).  Verify your Fission setup with:

```bash
$ fission version
```

## Add the Nodejs runtime environment to your cluster

Fission language support is enabled by creating an _Environment_.  An
environment is the language-specific part of Fission.  It has a
container image in which your function will run.

```bash
$ fission environment create --name nodejs --image fission/node-env
```

## Write a simple function in Nodejs

Create a file helloWorld.js with the following content

```js
module.exports = async function(context) {
    return {
        status: 200,
        body: "hello, world!\n"
    };
}
```

Create a function with the following command. Note that the value for `--env` flag is `nodejs` which was created with `fission env create` command above.

```bash
$ fission function create --name hello-world --code helloWorld.js --env nodejs
```

Test the function with the below command and you should see "hello, world!" in the output

```bash
$ fission fn test --name hello-world
```

## HTTP requests and HTTP responses

### Accessing HTTP Requests

This section gives a few examples of invoking nodejs functions with HTTP requests and how HTTP request components can be extracted inside the function.
While these examples give you a rough idea of the usage, there are more real world examples [here](https://github.com/fission/fission/tree/master/examples/nodejs)

#### Headers

Here's an example of extracting HTTP headers from the HTTP request.

Create a file hello.js with the following content. Here the function tries to access the value associated with header with name 'x-internal-token' and it could potentially do some authentication and authorization on the token before returning the response.

```js
module.exports = async function(context) {
    console.log(context.request.headers);
    var token = context.request.headers['x-internal-token'];
    console.log("Token presented : ", token);

    // do some authn and authz based on token received
    
    return {
        status: 200,
        body: "hello world!"
    }
}
```

Create a function with the following command.

```bash
$ fission function create --name hello-world --code hello.js --env nodejs
```

Create an HTTP trigger to invoke the function

```bash
fission httptrigger create --url /hello-world --function hello-world
```

Test the function with the below command and you should see "hello, world!" in the output

```bash
$ curl HTTP://$FISSION_ROUTER/hello-world -H "X-Internal-Token: abcdefghtsdfjsldjf123"
```

#### Query string

Here's an example of extracting the query string from the HTTP request.

Create a file helloUser.js with the following content. Here the function tries to read the value of query parameter user and returns "hello <value supplied as user parameter>". 

```js
var url = require('url');

module.exports = async function(context) {
    console.log(context.request.url)

    var url_parts = url.parse(context.request.url, true);
    var query = url_parts.query;

    console.log("query user : ", query.user);

    return {
        status: 200,
        body: "hello " + query.user + "!"
    }
}
```

Create a function with the following command.

```bash
$ fission function create --name hello-user --code helloUser.js --env nodejs
```

Create an HTTP trigger to invoke the function

```bash
$ fission httptrigger create --url /hello-user --function hello-user
```

Test the function with the below command and you should see "hello, foo!" in the output

```bash
$ curl HTTP://$FISSION_ROUTER/hello-user?user=foo
```

#### Body 

First lets see an example of a function which extracts a request body in JSON format.

Create a file jobStatus.js with the following content. Here the function tries to extract the 'job_id' and the 'job_status' from the HTTP request body and could potentially persist the status somewhere.   

```js
module.exports = async function(context) {
    const job = context.request.body.job_id;
    const jobStatus = context.request.body.job_status;

    // do some db write if required to save the status

    return {
        status: 200,
        body: "Successfully saved job status for job ID: " + job
    };
}
```

Create a function with the following command. 

```bash
$ fission function create --name job-status --code jobStatus.js --env nodejs
```

Create an HTTP trigger to invoke the function

```bash
$ fission httptrigger create --url /job-status --function job-status --method POST 
```

Invoke the function with a POST HTTP request with the appropriate JSON body and you will see the response "Successfully saved job status for job ID: 1234"

```bash
$ curl -XPOST HTTP://$FISSION_ROUTER/job-status -d '{"job_id" : "1234", "job_status": "Passed"}'
```

Next lets see an example of writing a function which extracts a request body in the Plain Text format

Create a file wordCount.js with the following content. Here the function tries to extract a request body and returns the word count of the input text.   

```js
module.exports = async function(context) {
    var splitStringArray = context.request.body.split(" ");

    return {
        status: 200,
        body: "word count " + splitStringArray.length
    };
}
```

Create a function with the following command. 

```bash
$ fission function create --name word-count --code wordCount.js --env nodejs
```

Create an HTTP trigger to invoke the function

```bash
$ fission httptrigger create --url /word-count --function word-count --method POST 
```

Invoke the function with a POST HTTP request with a text body and you will see the count of number of words in the HTTP response.

```bash
$ curl -XPOST -H "Content-Type: text/plain" HTTP://$FISSION_ROUTER/word-count -d '{"It's a beautiful day!"}'
```

### Controlling HTTP Responses 

This section gives a few examples of invoking nodejs functions with HTTP requests and how the function can return various values as part of HTTP response headers and body.

#### Setting Response Headers

Create a file functionMetadata.js with the following content. Here the function returns the fission function metadata added by Fission Router as part of the HTTP response header to the user.   

```js
module.exports = async function(context) {
    console.log(context.request.headers);
    
    return {
        status: 200,
        headers: {
            'x-fission-function-name': context.request.headers['x-fission-function-name'],
            'x-fission-function-namespace': context.request.headers['x-fission-function-namespace'],
            'x-fission-function-resourceversion': context.request.headers['x-fission-function-resourceversion'],
            'x-fission-function-uid': context.request.headers['x-fission-function-uid'],
        },
        body: "hello world!"
    }
}
```

Create a function with the following command. 

```bash
$ fission function create --name function-metadata --code functionMetadata.js --env nodejs
```

Create an HTTP trigger to invoke the function

```bash
$ fission httptrigger create --url /function-metadata --function function-metadata --method GET
```

Invoke the function with a '-v' flag on curl command to display all headers

```bash
$ curl HTTP://$FISSION_ROUTER/function-metadata -v
```

We can see the headers in the output as below

```plaintext
*   Trying 0.0.0.0
.
.
.
< HTTP/1.1 200 OK
< Content-Length: 12
< Content-Type: text/html; charset=utf-8
< Date: Tue, 23 Oct 2018 19:01:55 GMT
< Etag: W/"c-QwzjTQIHJO11oZbfwq1nx3dy0Wk"
< X-Fission-Function-Name: header-example
< X-Fission-Function-Namespace: default
< X-Fission-Function-Resourceversion: 19413500
< X-Fission-Function-Uid: 0014884b-d6e7-11e8-afb7-42010a800194
< X-Powered-By: Express
< 
* Connection #0 to host 0.0.0.0 left intact
hello world!
```

#### Setting Status Codes 

Create a file validateInput.js with the following content. Here the function tries to validate an input parameter "job_id" and sends a HTTP response code 400 when validation fails.   

```js
module.exports = async function(context) {
    const job = context.request.body.job_id;
    const jobStatus = context.request.body.job_status;

    console.log("Received CI job id: " + job + " job status: " + jobStatus );

    if (!job) {
        return {
            status: 400,
            body: "job_id cannot be empty"
        };
    }

    return {
        status: 200,
        body: "Successfully saved CI job status for job ID: " + job
    };
}
```

Create a function with the following command. 

```bash
$ fission function create --name error-handling --code validateInput.js --env nodejs
```

Create an HTTP trigger to invoke the function

```bash
$ fission httptrigger create --url /error-handling --function error-handling --method POST 
```

Invoke the function with this curl command where job_id is empty and you should see "job_id cannot be empty"

```bash
$ curl -XPOST HTTP://$FISSION_ROUTER/error-handling -d '{"job_status": "Passed"}'
```

## Working with dependencies

There may be instances where functions need to require node modules that are not packed into the nodejs runtime environment. In such instances, nodejs builder image could be used to `npm install` those modules.
This section describes ways in which this can be achieved.

### Using fission nodejs builder image

#### Example of using the nodejs builder image

fission docker hub has a nodejs builder image `fission/node-builder`. Here's an example of using this image.

First, create an environment with runtime image and builder image as follows 
 
```bash
$ fission environment create --name nodejs --image fission/node-env --builder fission/node-builder
```

Next, create a file momentExample.js with the following content. This file requires 'moment' node_module that is not packed into the fission runtime image. Also create a package.json with 'moment' listed in dependencies section.

```js
const momentpackage = require('moment')

module.exports = async function(context) {

    return {
        status: 200,
        body: momentpackage().format()
    };
}  
```

Sample package.json 

```json
{
  "name": "fission-nodejs-runtime",
  "engines": {
    "node": ">=7.6.0"
  },
  "dependencies": {
    "moment": "*"
  }
}
```

Next, create a zip archive of these 2 files with `zip node-source-example.zip momentExample.js package.json`.

Now create a fission source package with the zip file just created. This command outputs the name of the package created. 

```bash
$ fission package create --src node-source-example.zip --env nodejs
```

Next, create a fission function with the package created above, let's assume the package name is 'node-source-example-abcd'

```bash
$ fission function create --name node-builder-example --pkg node-source-example-abcd --env nodejs --entrypoint "momentExample"
```

If everything was successful so far, then, build status of the source package will be set to 'succeeded'. This can be checked with the following command.

```bash
$ fission package info --name node-source-example-abcd
```

Next, test your function with the following and the output should have the current time.

```bash
$ fission fn test --name node-builder-example
```

#### Details of the fission nodejs builder image

The builder has a build.sh script that performs an `npm install` of the node modules listed in user provided package.json. The builder image runs this script and packages the result into an archive.   
When the function is invoked, one of the pods running the runtime image is specialized. What this means is that the archive created by the builder is fetched and extracted in the file system.
Next, the user function is loaded according to the entry point specified with `fission fn create command`

### Creating a custom nodejs builder image 

If you'd like to do more than just `npm install` in the build step, you could customize the build.sh.
Here's the link to the source code of fission [nodejs builder](https://github.com/fission/fission/tree/master/environments/nodejs/builder)

As you can see, the build.sh performs a `npm install` inside a directory defined by the environment variable SRC_PKG and copies the built archive into a directory defined by environment variable DEPLOY_PKG 
You could create a customized version of this build.sh with whatever additional commands needed to be run during the build step.

Finally the image can be built with `docker build -t <USER>/nodejs-custom-builder .` and pushed to docker hub with `docker push <USER>/nodejs-custom-builder`

Now you are ready to create a nodejs env with your custom builder image supplied to `--builder` flag

## Modifying the nodejs runtime image

If you wish to modify the nodejs runtime image to add more dependencies without using/creating a builder image, you can do so too.

Here's the link to the source code of fission [nodejs runtime](https://github.com/fission/fission/tree/master/environments/nodejs)

As you can see, there is a package.json in the directory with a list of node modules listed under dependencies section. 
You can add the node modules required to this list and then build the docker image with `docker build -t <USER>/nodejs-custom-runtime .` and push the image `docker push <USER>/nodejs-custom-runtime`

You are now ready to create a nodejs env with your image supplied to `--image` flag

## Resource usage 

Currently the nodejs environment containers are run with default memory limit of 512 MiB and a memory request of 256 MiB. Also, a default CPU limit of 1 and a CPU request of 0.5 cores.

If you wish to create functions with higher resource requirements, you could supply `--mincpu`, `--maxcpu`, `--minmemory` and `--maxmemory` flags during `fission fn create`. Also supply `--executortype newdeploy` to the CLI.


