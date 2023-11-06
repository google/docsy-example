---
title: "Bug Report"
linkTitle: "Bug Report"
date: 2021-10-05
weight: 1
menu:
  documentation:
    weight: 20
description: >
  Python object structure guidance.
---

Bug reports are an important part of making COAsT more stable. Having a complete bug report will allow others to reproduce the bug and provide insight into fixing. See this [stackoverflow article](https://stackoverflow.com/help/minimal-reproducible-example) for tips on writing a good bug report.

Trying if the bug is ocurring in the lastest version of the package is worthwhile exercise to confirm the bug still exists. It is also worth searching existing bug reports and pull requests to see if the issue has already been reported and/or fixed.

Bug reports must:

1. Include a short, self contained Python snippet reproducing the problem. You can format the code nicely by using GitHub Flavored Markdown:

```
.```python
import coast

fn_data = "<path to T-grid data file(s)>"
fn_domain = "<path to domain file>"
fn_config = "<path to json config file>"
data = coast.Gridded(fn_data, fn_domain, fn_config)
```.
```

2. Include the full version string of COAsT and its dependencies. Explain why the current behavior is wrong/not desired and what you expect instead. The issue will then show up to the COAsT community and be open to comments/ideas from others.

[Click here](https://github.com/British-Oceanographic-Data-Centre/COAsT/issues/new) to open an issue.
