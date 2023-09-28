---
title: 贡献指南
weight: 10
description: 如何为文档做出贡献
---

{{% pageinfo %}}

这些基本示例假设您的 Docsy 站点是使用 Netlify 部署的，并且您的文件存储在 GitHub 中。您可以“按原样”使用这些指南，也可以根据自己的需要进行调整：例如，其他部署选项、有关文档项目文件结构的信息、特定于项目的审核指南、版本控制指南或您的用户可能认为有用的任何其他信息。 [Kubeflow](https://github.com/kubeflow/website/blob/master/README.md) 有一个很好的例子。

不要忘记链接到您自己的文档仓库而不是我们的示例网站！还要确保用户可以从您的文档仓库的自述文件中找到这些指南：将它们链接到本页面，或者链接到README，或者将它们包含在这两个位置。

{{% /pageinfo %}}

我们使用 [Hugo](https://gohugo.io/) 来格式化和生成我们的网站，
用 [Docsy](https://github.com/google/docsy) 主题来构建样式和组织网站结构，
用 [Netlify](https://www.netlify.com/) 来管理站点的部署。
Hugo是一个开源静态站点生成器，为我们提供模板，
组织内容的标准目录结构，以及网站生成引擎。你用 Markdown（或者 HTML，如果你愿意的话）编写页面，Hugo 将它们组装到一个网站中。

所有提交的内容，包括项目成员提交的内容，都需要审核。我们通过 GitHub 的 pull requests 机制来实现这一目标。查看
[GitHub 帮助](https://help.github.com/articles/about-pull-requests/) 了解更多有关 pull requests 的信息。

## Netlify 快速入门{#quick-start-with-netlify}

这是更新文档的快速指南。它假设您熟悉 GitHub 工作流程，并且您很乐意使用文档的自动预览更新：

1. 在 GitHub 上 Fork [Goldydocs 仓库](https://github.com/google/docsy-example)。
1. 进行更改并发送拉取请求 (PR)。
1. 如果您尚未准备好接受审核，请在 PR 名称中添加“WIP”以表明这是一项正在进行的工作。（**不要**添加 Hugo 属性 “draft = true”到页面前面的内容，因为这会阻止下一点中描述的内容预览的自动部署。）
1. 等待自动化 PR 工作流程进行一些检查。 准备好后，您应该看到这样的评论：**deploy/netlify — Deploy preview ready!**
1. 点击“Deploy preview ready”右侧的**Details**，预览您的更新。
1. 继续更新您的文档并推送更改，直到您满意为止内容。
1. 当您准备好进行审核时，向 PR 添加评论，并删除任何评论“WIP”标记。

## 更新单个页面{#updating-a-single-page}

如果您在使用文档时刚刚发现想要更改的内容，Docsy 为您提供了一个快捷方式：

1. 单击页面右上角的**编辑此页**。
1. 如果您还没有项目仓库的最新分支，系统会提示您获取一个提示：单击 **Fork this repository and propose changes** 或 **Update your Fork** 以获取最新版本，分支中的相应页面会以编辑模式显示。
1. 按照上面的 [Netlify 快速入门](#quick-start-with-netlify) 流程的其余部分进行更改、预览并提出更改建议。

## 在本地预览您的更改{#previewing-your-changes-locally}

如果您想在的本地运行 Hugo 服务器以预览更改：

1. 按照[入门](/docs/getting-started)中的说明安装 Hugo 和您需要的任何其他工具。您至少需要 **Hugo 0.45 版本**（我们建议使用最新的可用版本），并且必须是支持 SCSS 的**扩展**版本。
1. 将 [Goldydocs 仓库](https://github.com/google/docsy-example) 仓库 Fork 到您自己的项目中，然后使用 `git clone` 创建本地副本。不要忘记使用`--recurse-submodules`，否则您将无法提取生成工作站点所需的一些代码。

     ````
    git clone --recurse-submodules --depth 1 https://github.com/google/docsy-example.git
     ````

1. 在站点根目录下运行 `hugo server`。默认情况下，您的站点将位于 http://localhost:1313/。现在您已在本地提供网站服务，Hugo 将监视内容更改并自动刷新您的网站。
1. 继续常规的 GitHub 工作流程来编辑文件、提交文件、推送更改您的 Fork，并创建拉取请求。

## 创建 issue{#creating-an-issue}

如果您在文档中发现问题，但不确定如何自行修复，请在 [Goldydocs 仓库](https://github.com/google/docsy-example/issues) 中创建 issue。您还可以通过单击页面右上角的 **提交文档问题** 按钮来创建有关特定页面的问题。

## 有用的资源{#useful-resources}

* [Docsy 用户指南](https://www.docsy.dev/docs/)：有关 Docsy 的所有内容，包括它如何管理导航、外观、体验以及多语言支持。
* [Hugo 文档](https://gohugo.io/documentation/)：Hugo 的综合参考。
* [Github Hello World!](https://guides.github.com/activities/hello-world/)：GitHub 概念和工作流程的基本介绍。
