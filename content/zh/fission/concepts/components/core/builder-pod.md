---
title: "Builder Pod"
weight: 7
description: >
  用来加载并执行用户函数的地方
---

# 简介

Builder Pod 是用来把源码 Archive 构建成可以在函数 Pod 中运行的部署 Archive。
它包含两个容器：Fetcher 容器和 Builder 容器。

# 图例

{{< img "../assets/builder-pod.png" "Fig.1 Builder Pod" "50em" "1" >}}

1. Builder Manager 请求 Fetcher 拉取源码 archive。
2. Fetcher 从 StorageSvc 拉取源码 archive。
3. 把 archive 保存到共享的 volume。
4. Builder Manager 向 Builder Container 发送一个构建请求来启动构建过程。
5. Builder Container 从 volume 读取源码 archive，把它编译到部署 archive。 </br>
最终，把结果回存到共享 volume 上。  
6. Builder Manager 请求 Fetcher 上传部署 archive.

# Builder Container
Builder Container 构建函数源码到可执行的二进制/文件，而且每个 Builder Container 都是针对特定语言的。

# Fetcher

Fetcher 负责从 StorageSvc 拉取源码 archive 并验证文件的检查和来保证文件的完整性。构建结束后，它把部署 archive 上传到 StorageSvc。
