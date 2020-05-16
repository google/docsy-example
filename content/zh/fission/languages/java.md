---
title: "Java"
weight: 10
---

Fission supports functions written in Java and runs then on JVM. Current JVM environment is based on openjdk8 and uses Spring Boot as framework.

## Before you start

We'll assume you have Fission and Kubernetes setup.  If not, head over
to the [install guide]({{% relref "../installation/_index.zh.md" %}}). Verify your Fission setup with:

``` sh
$ fission version
```

## Add JVM environment to your cluster

Fission language support is enabled by creating an _Environment_.  An environment is the language-specific part of Fission.  It has a container image in which your function will run.

``` sh
$ fission environment create --name java --image fission/jvm-env --builder fission/jvm-builder
```

## Write a simple function in Java

A function needs to implement the `io.fission.Function` class and override the `call` method. The call method receives the `RequestEntity` and `Context` as inputs and needs to return `ResponseEntity` object. Both `RequestEntity` and `ResponseEntity` are from `org.springframework.http` package and provide a fairly high level and rich API to interact with request and response objects. The function code responds with "Hello World" in response body looks as shown below:

```java
package io.fission;

import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;

import io.fission.Function;
import io.fission.Context;

public class HelloWorld implements Function {

	@Override
	public ResponseEntity<?> call(RequestEntity req, Context context) {
		return ResponseEntity.ok("Hello World!");
	}

}
```

## HTTP requests and HTTP responses

Java function provides easy access to the Request and Response using Spring framework's `RequestEntity` and `ResponseEntity` objects.

### Accessing HTTP Requests

#### Headers

You can access headers object from the request object and then use various methods on header object to retrieve a specific header or get a collection of all headers. Please note that the header keys will be converted to canonical MIME format header key.

```java
	HttpHeaders headers = req.getHeaders();
	List<String> values = headers.get("keyname");
```

#### Query string

You can use the URI object in request object and parse the query parameters as shown below.

```java
	Map<String, String> query_pairs = new LinkedHashMap<String, String>();
	URI url = req.getUrl();
	String query = url.getQuery();
	String[] pairs = query.split("&");
	for (String pair : pairs) {
		int idx = pair.indexOf("=");
		query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1), "UTF-8"));
	}
```

#### Body 

The body of the request object can be accessed as a map. You can use the map to convert to a value object using Jackson library's `ObjectMappper`. You will need to add the Jackson library to dependencies and import appropriate classes.

```java
import com.fasterxml.jackson.databind.ObjectMapper;

final ObjectMapper mapper = new ObjectMapper();
HashMap data = (HashMap) req.getBody();
// The Data object is a POJO representation of JSON from request
Data iotData = mapper.convertValue(data, Data.class);
```

### Controlling HTTP Responses 

#### Setting Response Headers & Status code

The response object allows adding headers before sending the response back to the user. You can also set status code, body etc. on response object

```java
HttpHeaders headers = new HttpHeaders();
headers.add("Access-Control-Allow-Origin", "*");
return ResponseEntity.status(HttpStatus.OK).headers(headers).build();
```

## Working with dependencies

### Dependencies

JVM environment can accept any executable JAR with entrypoint method that implements the interface of `io.fission.Function`. Currently the dependencies in the JVM environment are managed with Maven so we will take that as an example but you can use the others tools as well such as Gradle.

First you have to define the the basic information about the function:

```xml
<modelVersion>4.0.0</modelVersion>
<groupId>io.fission</groupId>
<artifactId>hello-world</artifactId>
<version>1.0-SNAPSHOT</version>
<packaging>JAR</packaging>

<name>hello-world</name>
```

JVM environment already has the spring-boot-starter-web and fission-java-core as dependencies so you need to declare them at provided scope. You can add additional dependencies that your application needs.

```maven
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <version>2.0.1.RELEASE</version>
    <scope>provided</scope>
</dependency>
<dependency>
    <groupId>io.fission</groupId>
    <artifactId>fission-java-core</artifactId>
    <version>0.0.2-SNAPSHOT</version>
    <scope>provided</scope>
</dependency>
```

One of the key things when packaging the Java function is to package it as a uber/fat JAR so that the class and all other dependencies are packaged with function. For that you can use `maven-assembly-plugin`:

```xml
    <execution>
	<id>make-assembly</id> <!-- this is used for inheritance merges -->
	<phase>package</phase> <!-- bind to the packaging phase -->
	<goals>
		<goal>single</goal>
	</goals>
</execution>
```

Lastly since the `fission-java-core` is currently in the snapshot release, you need to explicitely add the sonatype repository which is where it is published. 

```xml
<repositories>
	<repository>
		<id>fission-java-core</id>
		<name>fission-java-core-snapshot</name>
		<url>https://oss.sonatype.org/content/repositories/snapshots/</url>
	</repository>
</repositories>
```

### Building the function

The current build environment for Java has support for Maven builds. You can upload the source code and the JVM builder will build the source code into a jar. Let's take [Java example from here](https://github.com/fission/fission/tree/master/examples/jvm/java) and build using Fission builder.

Let's first create a JVM environment with builder. For JVM environment you need to pass `--keeparchive` so that the jar file built from source is not extracted for running the function. You also need to use version 2 or higher of environment.

``` sh
$ fission env create --name java --image fission/jvm-env --builder fission/jvm-builder --keeparchive --version 2
```

Next create a package with the builder environment by providing the source package.  This will kick off the build process.

``` sh
$ tree -L 1
.
├── README.md
├── build.sh
├── pom.xml
└── src

2 directories, 3 files
$ chmod +x build.sh
$ zip java-src-pkg.zip -r *
$ fission package create --env java --src java-src-pkg.zip 
Package 'java-src-pkg-zip-dqo5' created
```

You can check the status of build by running the `info` command on package. After the build succeeds, the status will turn to `succeeded` and the build logs will be visible.

``` sh
$ fission package info --name java-src-pkg-zip-dqo5
Name:        java-src-pkg-zip-dqo5
Environment: java
Status:      running
Build Logs:

$ fission package info --name java-src-pkg-zip-dqo5
Name:        java-src-pkg-zip-dqo5
Environment: java
Status:      succeeded
Build Logs:
[INFO] Scanning for projects...
[INFO] 
[INFO] -----------------------< io.fission:hello-world >-----------------------
[INFO] Building hello-world 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 

<< TRUNCATED FOR SIMPLICITY >>

[INFO] Building jar: /packages/java-src-pkg-zip-dqo5-aevhi1/target/hello-world-1.0-SNAPSHOT-jar-with-dependencies.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 6.588 s
[INFO] Finished at: 2018-10-25T12:46:09Z
[INFO] ------------------------------------------------------------------------
```

Finally let's create a function with package created earlier and provide an entrypoint. The function can be tested with `fission fn test` command.

``` sh
$ fission fn create --name javatest --pkg  java-src-pkg-zip-dqo5 --env java --entrypoint io.fission.HelloWorld --executortype newdeploy --minscale 1 --maxscale 1
$ fission fn test --name javatest
Hello World!
```

### Custom builds

You might have noticed that we did not provide any build command to package for building from source in previous section. The build still worked because the builder used the default built in command to build the source. You can override this build command to suit your needs. The only requirement is to instruct the builder on how to copy resulting Jar file to function by using the environment variables `$SRC_PKG` and  `$DEPLOY_PKG`. The `$SRC_PKG` is the root from where build will be run so you can form a relative oath to Jar file and copy the file to `$DEPLOY_PKG` Fission will at runtime inject these variables and copy the Jar file.

```sh
$ cat build.sh
#!/bin/sh
set -eou pipefail
mvn clean package
cp ${SRC_PKG}/target/*with-dependencies.jar ${DEPLOY_PKG}
```

You can pass the custom build script when creating package or function using the `buildcmd` flag:

``` sh
$ fission package create --env java --src java-src-pkg.zip --buildcmd custom_build.sh
Package 'java-src-pkg-zip-dqo5' created
```

## Modifying the environment images

The JVM environment's source code is available [here](https://github.com/fission/fission/tree/master/environments/jvm). If you only want to add libraries to the OS or add some additional files etc. to environment, it would be easier to simply extend the official Fission JVM environment image and use it.

The JVM builder image source code is [available here](https://github.com/fission/fission/tree/master/environments/jvm/builder) and could be extended or written from scratch to use other tools such as Gradle etc. It would be easier to extend the Fission official image and then add tools.

## Resource usage 

A minimum memory of 128MB is needed for JVM environment. You can specify CPU and memory when you create an environment as shown below. The min and max for resources correspond to resource request and resource limits of Kubernetes pods.

``` sh
$ fission env create --name java --image fission/jvm-env --builder fission/jvm-builder --keeparchive --version 2 --mincpu 100 --maxcpu 500 --minmemory 128 --maxmemory 512
```

For function of executor type "newdeploy" you can also override the resource values when creating a function. For functions of type "poolmgr", the resources can only be specified at environment level.

``` sh
$ fission fn create --name javatest --pkg  java-src-pkg-zip-dqo5 --env java --entrypoint io.fission.HelloWorld --executortype newdeploy --minscale 1 --maxscale 1  --mincpu 100 --maxcpu 500 --minmemory 128 --maxmemory 512
```

## JVM Parameters

You can provide options to JVM such as heap size or additional parameters for tuning the JVM to your needs. The Fission JVM environment supports the JVM options.

You can create the JVM environment spec (For more information on using specs check [using Fission specs]({{% relref "../spec/_index.md" %}})) and then add environment variable named `JVM_OPTS`. The value of environment variable is used as options to JVM when function starts. The following is an example of Fission environment YAML with JVM_OPTS added as an environment variable.

```yaml
apiVersion: fission.io/v1
kind: Environment
metadata:
  creationTimestamp: null
  name: jvm
  namespace: default
spec:
  TerminationGracePeriod: 360
  builder: {}
  keeparchive: true
  poolsize: 3
  resources: {}
  runtime:
    functionendpointport: 0
    image: fission/jvm-env
    loadendpointpath: ""
    loadendpointport: 0
    container:
      env:
      - name: JVM_OPTS
        value: "-Xms256M -Xmx1024M"
  version: 2
```

You can validate and apply the YAML to create the JVM environment with JVM options.

```bash
$ fission spec validate
$ fission spec apply
```

## Samples
- The Fission Kafka sample is a complete application written in Java and uses Kafka to interact between functions. The source code and more information can be found [here](https://github.com/fission/fission-kafka-sample)
- The Fission workflow sample uses [Fission workflows](https://github.com/fission/fission-workflows) and Java functions. The source code and more information can be found [here](https://github.com/fission/fission-workflow-sample)
