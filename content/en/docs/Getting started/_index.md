---
title: "Getting Started"
linkTitle: "Getting Started"
weight: 2
description: >
  Download, install and use.
---

## Prerequisites

This package requires;
- python version 3.7+
- Anaconda version 3.7

Are there any system requirements for using your project? What languages are supported (if any)? Do users need to already have any software or tools installed?

## Installation

This package should be installed by run;
```shell
conda install -c bodc COAsT
```
However, there is also the option of;
```shell
pip install COAsT
```

if you wish to install from source then got to [GitHub](https://github.com/british-oceanographic-data-centre/COAsT) and follow the README instructions


## Setup
The base package should now be installed on your system. The following packages might be required for some of the advanced features;

- cartopy
- graphviz


## Try it out!
The following example script should load a example file and plot some data on a map.

```python
import coast

dir = '<path-to-files>'
sci_dom = coast.DOMAIN()
sci_dom.load(dir+"domain_cfg.nc")
yt, xt, length_of_line = sci_dom.transect_indices([42,-3],[43,-2], grid_ref='t')

# Visualise
import numpy as np
import matplotlib.pyplot as plt
lon = np.array( sci_dom.dataset.nav_lon )
lat = np.array( sci_dom.dataset.nav_lat )


plt.plot( lon[yt,xt], lat[yt,xt], '.');
plt.show()
```
You are now all setup with a working COAsT package. Time for the tutorials :)
