---
title: "Message Queue Trigger"
weight: 4
description: >
  Subscribe topics and invoke functions
---

# Brief Intro

A message queue trigger binds a message queue topic to a function:
Events from that topic cause the function to be invoked with the
message as the body of the request. The trigger may also contain a
response topic: if specified, the function's output is sent to this
response.

# Diagram

{{< img "../assets/mqtrigger.png" "Fig.1 Message Queue Trigger" "45em" "1" >}}

1. Message Queue Trigger first subscribes to the topic defined by the user.
2. Publisher, it can be a Fission function or external application, publishes messages to the subscribe topic.
3. Trigger receives message from the message queue.
4. Invoke function to get the response.
5. (A) If it is 200 OK, the trigger publishes result to the response topic (if any). 
6. (B) If there is any error or the state is not equal to 200 OK, the trigger publishes result to the error topic (if any). </br>
Currently, only NATS and Kafka message queue triggers support error topic.
