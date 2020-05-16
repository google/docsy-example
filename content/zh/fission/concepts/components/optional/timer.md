---
title: "Timer"
weight: 5
description: >
  Invoke functions periodically
---

# Brief Intro

The timer works like kubernetes CronJob but instead of creating a pod to do the task, 
it sends a request to router to invoke the function. It's suitable for the background tasks that
need to execute periodically.

# Diagram

{{< img "../assets/timer.png" "Fig.1 Timer Trigger" "30em" "1" >}}

1. If the schedule time arrived, Timer invokes the function defined.
