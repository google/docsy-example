---
title: "Timer Triggers"
date: 2019-12-17T14:38:24+08:00
weight: 3
---

Time-based triggers invoke functions based on time.  They can run once
or repeatedly.  They're specified using [cron string
specifications](https://en.wikipedia.org/wiki/Cron):

```bash
$ fission timer create --name halfhourly --function hello --cron "0 */30 * * * *"
trigger 'halfhourly' created
Current Server Time: 	2019-12-17T08:33:28Z
Next 1 invocation: 	2019-12-17T09:00:00Z
```

You can also use a friendlier syntax such "@every 1m" or "@hourly":

```bash
$ fission timer create --name minute --function hello --cron "@every 1m"
trigger 'minute' created
Current Server Time: 	2019-12-17T08:33:43Z
Next 1 invocation: 	2019-12-17T08:34:43Z
```

And you can list time triggers to see their associated function and cron strings:

```bash
$ fission timer list
NAME       CRON           FUNCTION_NAME
halfhourly 0 */30 * * * * hello
minute     @every 1m      hello
```

You can also use `showschedule` to show the upcoming schedule for a
given cron spec.  Use this to test your cron strings.  And note that
the server's time is used to invoke functions, not your laptop's time!

```bash
$ fission timer showschedule --cron "0 30 * * * *" --round 5
Current Server Time: 	2018-06-12T05:07:41Z
Next 1 invocation: 	2018-06-12T05:30:00Z
Next 2 invocation: 	2018-06-12T06:30:00Z
Next 3 invocation: 	2018-06-12T07:30:00Z
Next 4 invocation: 	2018-06-12T08:30:00Z
Next 5 invocation: 	2018-06-12T09:30:00Z
```
