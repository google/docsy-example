---
title: "Build test"
linkTitle: "Build test"
weight: 4
description: >
  Build testing.
---

In order to run Build Tests locally, you need to follow the procedures of [Getting Started](https://british-oceanographic-data-centre.github.io/COAsT/docs/getting-started/) related to `Development use installation` and `Example data files`.

After that you can run:

```shell
pip install . && pytest unit_testing/unit_test.py -s
```

It will ask you for the path of your example files.

