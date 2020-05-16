---
title: "Fission"
linkTitle: 文档
weight: 20
menu:
  main:
    weight: 20
description: >
  Kubernetes 的 Serverless 函数
---

# Fission 是什么

[fission.io](http://fission.io)  [@fissionio](http://twitter.com/fissionio)

Fission 是一个快速的，开源的 Kubernetes serverless 框架，专注于提升开发效率和高性能。

Fission 操作的内容 _仅仅是代码_：Docker 和 Kubernetes 操作被抽象到了常规操作的底层，如果愿意，你仍然可以利用他们来增强 Fission。

Fission 是一个可以扩展到任意语言；它的核心使用 Go 语言编写，而且对于不同语言的部分使用了一种叫做 _environments_ 的东西隔离开了。Fission 目前支持 NodeJS， Python， Ruby， Go， PHP， Bash， 和任意的 Linux executable，更多的语言持续更新中。

# 性能: 100ms 冷启动

Fission 维护了一个“热”的容器资源池，每个容器包含了一个小的动态加载器。当一个函数被调用的时候，例如“cold-started”，就会选择一个运行着的容器加载这个函数。这个资源池正式 Fission 快的原因：冷启动延迟一般在 100msec 左右。

# Kubernetes 是 Serverless 的理想之选

因为我们认为任何具有一定复杂度的应用都会需要结合 serverless 函数和更传统一些的微服务，Kubernetes 正是一个可以把他们无缝结合到一起的伟大框架。

在 Kubernetes 上构建也意味着所有你为 Kubernetes 集群操作所做的事情 &mdash; 例如监控或者日志聚合 &mdash; 对于 Fission 部署的操作而言也是有所帮助的。

# Fission 概念

访问 [概念]({{% relref "./concepts/" %}}) 了解更多

# 用法

```bash
  # 添加 NodeJS 环境到你的 Fission 部署
  $ fission env create --name nodejs --image fission/node-env

  # 一个会显示 "hello world" 的单行 javascript 程序 
  $ curl https://raw.githubusercontent.com/fission/fission/master/examples/nodejs/hello.js > hello.js

  # 上传你的函数到 fission
  $ fission function create --name hello --env nodejs --code hello.js

  # 映射 GET /hello 到你的新函数
  $ fission route create --method GET --url /hello --function hello

  # 运行函数.  第一次运行大概需要 100msec 的时间。
  $ fission function test --name hello
  Hello, world!
```

# 加入我们

* [加入 Slack](https://join.slack.com/t/fissionio/shared_invite/enQtOTI3NjgyMjE5NzE3LTllODJiODBmYTBiYWUwMWQxZWRhNDhiZDMyN2EyNjAzMTFiYjE2Nzc1NzE0MTU4ZTg2MzVjMDQ1NWY3MGJhZmE)
* Twitter: http://twitter.com/fissionio
