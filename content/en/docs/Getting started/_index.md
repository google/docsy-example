---
title: "Getting Started"
linkTitle: "Getting Started"
weight: 2
description: >
  What does your user need to know to try your project?
---

{{% pageinfo %}}
This is a placeholder page that shows you how to use this template site.
{{% /pageinfo %}}

Information in this section helps your user try your project themselves.

* What do your users need to do to start using your project? This could include downloading/installation instructions, including any prerequisites or system requirements.

* Introductory “Hello World” example, if appropriate. More complex tutorials should live in the Tutorials section.

Consider using the headings below for your getting started page. You can delete any that are not applicable to your project.

## Prerequisites

This package requires;
- python version 3.7+
- Anaconda version 3.7

Are there any system requirements for using your project? What languages are supported (if any)? Do users need to already have any software or tools installed?

## Installation

This package can be installed by run;
```shell
conda install COAsT
```

if you wish to install from source then got to [GitHub](https://github.com/british-oceanographic-data-centre/COAsT) and follow the README instructions


## Setup
The package should now be installed on your system

## Try it out!
The following example script should load a example file and plot some data on a map.

```python
from COAsT import COAsT
sci = COAsT()
sci.load('example_files/AMM7_25hourm_grid_T.nc',{'time_counter':10})
sci.plot_cartopy()
```
