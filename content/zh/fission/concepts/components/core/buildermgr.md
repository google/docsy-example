---
title: "Builder Manager"
weight: 6
description: >
  把源码编译到可运行的函数
---

# 简介

builder manager 监视 package 和环境自定义资源的变化并管理函数源码的构建。
每当一个包含 builder image 的环境被创建的时候，
builder manager 会创建 Kubernetes 服务并部署在 fission-builder 命名空间下，
以启动 environment builder。一旦一个包含源码 archive 的 package 被创建，
builder manager 通知 environment builder 去把构建函数的源码到一个部署 archive 来部署函数。

在构建之后，一旦构建成功 builder manager 就会通知 Builder 上传部署 archive 到存储服务，
并更新 package 状态及构建日志。

# 图例

{{< img "../assets/buildermanager.png" "Fig.1 Builder Manager" "30em" "1" >}}

1. Builder Manager 监视环境变化
2. 当新的包含构建镜像的环境被创建或删除时，创建/删除服务并部署。
3. Builder Manager 监视 packages 变化。
4. 向 builder 服务发送一个构建请求
5. Builder pod 从 builder manager 收到构建请求
6. Builder 从 StorageSvc 拉取源码并开始构建过程 </br>
如果构建成功，转到步骤7；否则转到步骤8。
7. Builder 上传部署 archive 到 StorageSvc 供函数 pod 使用。
8. Builder Manager 更新 package 状态和构建日志
