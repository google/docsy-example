---
title: "Message Queue Trigger"
date: 2019-12-17T14:38:11+08:00
weight: 2
---

# How Message Queue Trigger Works

A message queue trigger invokes a function based on messages from an
message queue. It allows users to invoke function in an asynchronous 
way by sending messages. Since all functions are invoked by HTTP calls, 
in order to support message queuing a component called `Message Queue Trigger`, 
which sits between message queue and user function, is introduced to subscribe 
to different message topics and invoke function when needed.

{{< img "../assets/message-queue-trigger.png" "Fig.1 Overview" "45em" "1" >}}

The Message Queue Trigger keeps watching the CRD changes of message queue trigger (messagequeuetriggers.fission.io).

```bash
$ fission mqtrigger create --name hello --function node --topic foobar
```

When a message queue trigger was created with the command above, the Message Queue 
Trigger first subscribes to the topic `foobar` and waits for messages being published 
to message queue. As long as Message Queue Trigger receives a message from certain topic, 
it then sends a **POST** HTTP call to function `node` with the content body of message.

We may also want to receive success/error response after each function invocation. 
To achieve this, you can add additional `--resptopic` and `--errortopic` flags when creating message queue trigger.

```bash
$ fission mqtrigger create --name hello --function node --topic foobar \
    --resptopic foo --errortopic bar --maxretries 3
```

If a function returns with 200 HTTP status code, the MQTrigger will send the response body to `resptopic`; otherwise, MQTrigger 
will retry multiple times until reach `maxretries` and sends to `errortopic` if all invocations failed.   

{{% notice warning %}}
Currently, only **NATS Streaming** and **Kafka** type of message queue trigger supports error topic.
{{% /notice %}}

```bash
$ fission mqt create --name hellomsg --function hello --mqtype nats-streaming --topic newfile --resptopic newfileresponse 
trigger 'hellomsg' created
```

You can list or update message queue triggers with `fission mqt list`,
or `fission mqt update`.

# Message Queue Supportability

Fission now supports following kinds of message queue:

* Kafka
* [NATS Streaming]({{% relref "./nats-streaming.md" %}}) 
* Azure Queue Storage

# How to Add New Message Queue Support

We are always looking forward to any contribution. To add new message queue, you need to implement 
the [MessageQueue](https://github.com/fission/fission/blob/master/pkg/mqtrigger/messageQueue/messageQueue.go#L50-L53) interface 
and see [here](https://github.com/fission/fission/tree/master/pkg/mqtrigger/messageQueue) for current existing implementations.
