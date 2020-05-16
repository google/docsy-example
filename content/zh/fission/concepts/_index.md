---
title: "概念"
weight: 10
description: >
  Fission 架构和组件的概念
---

Fission 有三个主要概念： **函数，环境，和触发器**

{{< img "./assets/trigger-function-environment.png" "触发器，环境，函数" "30em" "1" >}}

## 函数

一个 **Fission** 函数是用来给 Fission 运行的。 它通常是一个包含入口点的模块，而那个入口点是一个具有指定接口的函数。函数已经支持许多种编程语言了。

这是一个 JavaScript 的 简单函数示例：

```js
module.exports = async function(context) {
    return {
        status: 200,
        body: "hello, world!\n"
    };
}
```

## 环境

环境是 Fission 针对语言相关的部分。一个**环境**包含了刚好够构建和运行 Fission 函数的软件。

因为 Fission 通过 HTTP 调用函数，这代表着一个环境的运行时是一个 HTTP 服务端的容器，并且通常是一个可以加载函数的动态加载器。有些环境也包含构建容器，它们可以负责编译和加载依赖。

你可以修改任意现有的 Fission 环境并重新构建它们，或者你也可以从头开始构建一个新的环境。

点击 [这里]({{% relref "../languages/" %}}) 查看详细镜像列表。

## 触发器
 
函数在事件发生的时候被调用；一个**触发器**是用来配置 Fission 指定事件来调用函数的。换句话说，一个触发器就是一个事件到函数调用的绑定。

例如，一个 **HTTP 触发器**可以绑定指定路径上的 GET 请求来调用一个指定的函数。

我们支持几种类型的触发器：

* **HTTP 触发器** 当收到 HTTP 请求时调用函数。
* **Timer 触发器** 基于事件触发函数。
* **消息队列触发器** 例如 Kafka，NATS，和 Azure queues。
* **Kubernetes Watch 触发器** 当你的集群发生变化时触发函数。

当一个触发器收到请求/事件，它通过向函数的路由发送 HTTP 请求的方式调用在触发器对象中定义的目标函数。

## 其他概念

还有一些你开始的时候无需了解的概念，但是在高级用法中可能还是有用的。

### Archive

一个 **Archive** 是一个包含源代码或编译后二进制的 zip 文件。

包含可运行函数的 Archive 被称为 **部署
Archive**；包含源代码的则被称为 **源码
Archive**。

### Package

一个 **Package** 是一个包含部署 Archive 和源码 Archive（如果存在的话）的 Fission 对象。一个 Package 也关联到一个特定的环境。

当你通过源码 Archive 创建一个 Package 的时候， Fission 自动构建它并使用对应的构建环境，并且添加一个部署 Archive 到这个 package。

### Specification

Specification（简称 **specs**）就是包含我们以上所述 --- 函数，环境，触发器，Package 和 Archive 的 YAML 配置文件。

Specification 仅存在于客户端，是一种指导 Fission 命令行来创建和更新对象的方式。它们也指定如何构建源码，二进制等到 Archive。

Fission 命令行实现了一个能够使用这些 Specification 的幂等部署工具。
