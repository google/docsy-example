---
date: 2018-10-06
title: 使用 Docsy 轻松记录
linkTitle: Docsy 通告
description: >
  Docsy Hugo 主题让项目维护者和贡献者专注于内容，而不是从头开始重新发明网站基础设施。
author: Riona MacNamara ([@rionam](https://twitter.com/bepsays))
resources:
  - src: "**.{png,jpg}"
    title: "Image #:counter"
    params:
      byline: "Photo: Riona MacNamara / CC-BY-CA"
slug: easy-documentation-with-docsy
---

**这是一篇典型的包含图像的博客文章。**

前面的内容指定了博客文章的日期、标题、简短的摘要、作者，它们将被展示在博客列表页。

## 包含图片{#including-images}

这是一张包含署名和标题的图像 (`featured-sunset-get.png`)。

{{< imgproc sunset Fill "600x300" >}}
Hugo 0.43 将推出图片缩放功能。
{{< /imgproc >}}

这篇文章的元数据章节指定了所有图像资源的属性：

```
resources:
- src: "**.{png,jpg}"
  title: "Image #:counter"
  params:
    byline: "Photo: Riona MacNamara / CC-BY-CA"
```

要指定图片的描述信息，请参照如下：

```
{{< imgproc sunset Fill "600x300" >}}
Fetch and scale an image in the upcoming Hugo 0.43.
{{< /imgproc >}}
```

图片将以前文中指定的尺寸和署名进行渲染。

