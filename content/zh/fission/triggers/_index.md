---
title: "Triggers"
weight: 43
description: >
  Supported event triggers
---

Functions are invoked on the occurrence of an event; a **Trigger** is
what configures Fission to use that event to invoke a function.  In
other words, a trigger is a binding of events to function invocations.

There are several types of triggers like HTTP trigger and message queue trigger. 
One thing worth noticing is that **all the functions are invoked through HTTP requests**.

{{< img "assets/message-queue-trigger.png" "Fig.1 Message Queue Trigger" "45em" "1" >}}

The message queue trigger, for example, from Fig.1 you can see that `Message Queue Trigger` 
subscribes to a certain topic specified by the user when creating the message queue trigger. 
Message Queue Trigger will invoke the function if any messages published to the subscribed topic.
