---
date: 2026-02-10
title: Easy documentation with Docsy
linkTitle: Announcing Docsy
description: >
  The Docsy Hugo theme lets project maintainers and contributors focus on
  content, not on reinventing a website infrastructure from scratch
author: '[Patrice Chalin](https://github.com/chalin)'
resources:
  - src: '**.{png,jpg}'
    params:
      byline: Photo by Peter Xie from Pexels
    # https://www.pexels.com/photo/serene-ocean-sunset-with-rocky-silhouettes-35157036/
cSpell:ignore: imgproc Pexels
---

**This is a typical blog post that includes images.**

The front matter specifies the date of the blog post, its title, a short
description that will be displayed on the blog landing page, and its author.

## Including images

Here's an image that includes a byline and a caption.

{{< imgproc sunset Crop "500x300" >}}

Image cropped to 500x300

{{< /imgproc >}}

The front matter of this post specifies properties to be assigned to all image
resources:

```yaml
resources:
  - src: '**.{png,jpg}'
    params:
      byline: Photo by Peter Xie from Pexels
```

To include the image in a page, specify its details like this:

```go-html-template
{{</* imgproc sunset Crop "500x300" */>}}
Image cropped to 500x300
{{</* /imgproc */>}}
```

The image will be rendered at the size and byline specified in the front matter.
