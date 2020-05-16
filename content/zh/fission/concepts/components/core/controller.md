---
title: "控制器"
weight: 2
description: >
  接收 REST API 请求并创建 Fission 资源
---

# 简介

控制器是客户沟通的组件。它包含了函数，触发器，环境，Kubernetes 事件监听等的 CURD 接口。以及外部的第三方服务代理接口。   

所有的 fission 资源都被存储在 kubernetes 自定义资源中。他需要能够和 kubernetes 接口服务通信。为了能够操作所有命名空间中的自定义资源，控制器需要使用一个具有整个集群管理权限的服务账户。

# 示意图

{{< img "../assets/controller.png" "图1 控制器" "40em" "1" >}}

1. 客户端发送请求到控制器的地址。
2. (A) 控制器基于请求操作自定义资源。
3. (B) 如果一个请求是给另一个内部服务的，代理这个请求到那个服务。

# API

到 [这里](https://github.com/fission/fission/blob/master/pkg/controller/api.go) 查看更多详情。

* `/v2/apidocs.json`: Fission 自定义资源的所有 CRUD 接口的 OpenAPI 2.0 (Swagger) 文档
* `/proxy/*`: 内部服务的代理接口。
* `/v2/<resources>/*`: Fission 自定义资源的接口。
* `/healthz`: 健康状况检查地址
