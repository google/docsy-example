---
title: "Kafka"
draft: false
weight: 77
---

This tutorial will demonstrate how to use a Kafka trigger to invoke a function. We'll assume you have Fission and Kubernetes installed with Kafka MQ integration installed.  If not, please head over to the [install guide]({{% relref "../../installation/_index.zh.md" %}}).

You will also need Kafka setup which is reachable from the Fission Kubernetes cluster. If you want to setup Kafka on the Kubernetes cluster, you can use the [information here](https://github.com/fission/fission-kafka-sample/tree/master/00_setup).

# Installation

You can install Kafka through the incubator helm chart [here](https://github.com/helm/charts/tree/master/incubator/kafka).

# Overview

Before we dive into details, let's walk through overall flow of event and functions involved.

1. A Go producer function (producerfunc) acts as a producer and drops a message in a Kafka topic named `input`.
2. Fission kafka trigger activates and invokes another function (consumerfunc) with body of Kafka message.
3. The consumer function (consumerfunc) gets body of message and returns a response.
4. Fission Kafka trigger takes the response of consumer function (consumerfunc) and drops the message in a response topic named `output`. If there is an error, the message is dropped in error topic named `error`.

{{% notice info %}}
Fission supports Kafka [record headers](https://issues.apache.org/jira/browse/KAFKA-4208). Make sure you set correct version of Kafka to `kafka.version` in values.yaml while installing Fission. For more details please refer to Extra configuration section [here](https://github.com/fission/fission/tree/master/charts/#extra-configuration-for-fission-all).
{{% /notice %}}

# Building the app

## Producer Function

The producer function is a go program which creates a message with timestamp and drops into a topic `input`. For brevity all values have been hard coded in the code itself.

``` go
package main

import (
	"fmt"
	"net/http"
	"time"

	sarama "github.com/Shopify/sarama"
)

// Handler posts a message to Kafka Topic
func Handler(w http.ResponseWriter, r *http.Request) {
	brokers := []string{"broker.kafka.svc.cluster.local:9092"}
	producerConfig := sarama.NewConfig()
	producerConfig.Producer.RequiredAcks = sarama.WaitForAll
	producerConfig.Producer.Retry.Max = 10
	producerConfig.Producer.Return.Successes = true
	producer, err := sarama.NewSyncProducer(brokers, producerConfig)
	if err != nil {
		panic(err)
	}
	t := time.Now()
	ts := t.Format(time.RFC3339)
	message := fmt.Sprintf("{\"name\": \"value %s \"}", ts)
	_, _, err = producer.SendMessage(&sarama.ProducerMessage{
		Topic: "input",
		Value: sarama.StringEncoder(message),
	})

	if err != nil {
		w.Write([]byte(fmt.Sprintf("Failed to publish message to topic %s: %v", "input", err)))
		return
	}
	w.Write([]byte("Successfully sent to input"))
}
```

Since the go program uses sarama library, we need to provide that package for building & running the program. We use glide tool with simple glide.yaml declaration below to download the package.

```
import:
- package: github.com/Shopify/sarama
```

With these two files in a directory, run the command `glide install -v`. The resulting directory structure will look like below:

```
.
├── glide.lock
├── glide.yaml
├── kafka-pub.go
└── vendor

1 directory, 3 files
```

We are now ready to package this code and create a function so that we can execute it later. Following commands will create a environment, package and function. Verify that build for package succeeded before proceeding.

``` sh
$ fission env create --name goenv --image fission/go-env --builder fission/go-builder
$ zip -qr kafka.zip * 
$ fission package create --env goenv --src kafka.zip
Package 'kafka-zip-tzsu' created
$ fission fn create --name producerfunc --env goenv --pkg kafka-zip-tzsu --entrypoint Handler
$ fission package info --name kafka-zip-tzsu
Name:        kafka-zip-tzsu
Environment: go-kafka
Status:      succeeded
Build Logs:
Building in directory /usr/src/kafka-zip-tzsu-1bicov
```

## Consumer function

The consumer function is nodejs function which takes the body of the request, appends a "Hello" and returns the resulting string.

``` js
module.exports = async function (context) {
    console.log(context.request.body);
    let obj = context.request.body;
    return {
        status: 200,
        body: "Hello "+ JSON.stringify(obj)
    };
}
```

Let's create the environment and function:

``` sh
$ fission env create --name nodeenv --image fission/node-env
$ fission fn create --name consumerfunc --env nodeenv --code hellokafka.js
```

## Connecting via trigger

We have both the functions ready but the connection between them is the missing glue. Let's create a message queue trigger which will invoke the consumerfunc every time there is a message in `input` topic. The  response will be sent to `output` topic and in case of consumerfunc invocation fails, the error is written to `error` topic.

``` sh
$ fission mqt create --name kafkatest --function consumerfunc --mqtype kafka --topic input --resptopic output --errortopic error
```

If your Kafka broker is running somewhere else (not at `broker.kafka:9092`), you will have to provide custom configuration for Kafka broker host while installing fission. You can do that by creating a config file, set the value of `kafka.brokers` to your broker URL and provide this config file while installing fission through helm using -f flag. You can refer this [link](https://github.com/fission/fission/blob/master/charts/fission-all/values.yaml) to find out more about this config parameter.

## Testing it out

Let's invoke the producer function so that the topic `input` gets some messages and we can see the consumer function in action.

``` sh
$ fission fn test --name producerfunc
Successfully sent to input
```

There are a couple of ways you can verify that the consumerfunc is called:

- Check the logs of `mqtrigger-kafka` pods:

```
time="2018-10-29T10:46:12Z" level=info msg="Calling message handler with value {"name": "value 2018-10-29T10:46:12Z "}" 
time="2018-10-29T10:46:12Z" level=info msg="Making HTTP request to http://router.fission/fission-function/consumer-func" 
time="2018-10-29T10:46:12Z" level=info msg="Got response Hello {"name":"value 2018-10-29T10:46:12Z "}" 
```

- Install and use a tool such as [Pixy](https://github.com/mailgun/kafka-pixy) in the cluster so that you can check topics and message using a REST client. For example with Pixy and port-forwarding, you can check the response on output topic after decoding the message:

```
$ curl -X GET 'http://127.0.0.1:5000/topics/output/messages?group=pixy.io'
{
    "key": null,
    "value": "SGVsbG8geyJuYW1lIjoidmFsdWUgMjAxOC0xMC0yOVQxMDo0NjoxMlogIn0=",
    "partition": 0,
    "offset": 2
}
$ echo "SGVsbG8geyJuYW1lIjoidmFsdWUgMjAxOC0xMC0yOVQxMDo0NjoxMlogIn0=" | base64 -D
Hello {"name":"value 2018-10-29T10:46:12Z "}

```

## Introducing an error

Let's introduce an error scenario - instead of consumer function returning a 200, you can return 400 which will cause an error:

``` js
module.exports = async function (context) {
    console.log(context.request.body);
    let obj = context.request.body;
    return {
        status: 400,
        body: "Hello "+ JSON.stringify(obj)
    };
}
```

Update the function with new code and invoke the producer function:

``` sh
$ fission fn update --name consumerfunc --code hellokafka.js 

$ fission fn test --name producerfunc
Successfully sent to input
```

We can verify the message in error topic as we did earlier:

```
$ curl -X GET 'http://127.0.0.1:5000/topics/error/messages?group=pixy.io'
{
    "key": null,
    "value": "UmVxdWVzdCByZXR1cm5lZCBmYWlsdXJlOiA0MDA=",
    "partition": 0,
    "offset": 4
}

$ echo "UmVxdWVzdCByZXR1cm5lZCBmYWlsdXJlOiA0MDA="| base64 -D
Request returned failure: 400
```


# More examples

- The [Kafka sample available here](https://github.com/fission/fission-kafka-sample) uses Kafka integration to build a IoT fleet management. It also uses JVM Java environment to create functions.
