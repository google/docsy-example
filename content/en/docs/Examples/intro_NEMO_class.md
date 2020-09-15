---
title: "The NEMO class"
linkTitle: "NEMO class"
date: 2020-09-15
weight: 1
description: >
  An introduction to the NEMO class. Loading variables and grid information.
---

# An introduction to the COAsT package's NEMO class.

In a python window

### 1. Load python modules and create some aliases

``` python
import coast
import os
import numpy as np
import xarray as xr
import datetime

dn_files = "./example_files/"
fn_nemo_dat = 'COAsT_example_NEMO_data.nc'
fn_nemo_dom = 'COAsT_example_NEMO_domain.nc'
```

### 2. Load the NEMO data, the domain configuration data and blend them

Using the NEMO class a output file is read with the domain configuration file
and an object is created for all the variables on the specified grid. For example:

``` python
sci = coast.NEMO(dn_files + fn_nemo_dat, dn_files + fn_nemo_dom, grid_ref = 't-grid')
```
Will create an object called ``sci`` with all the `t-grid` variables. These can be
listed:

``` python
sci.dataset
```

Which returns:
```python
<xarray.Dataset>
Dimensions:              (axis_nbounds: 2, t_dim: 7, x_dim: 297, y_dim: 375, z_dim: 51)
Coordinates:
    time                 (t_dim) datetime64[ns] 2007-01-01T11:58:56 ... 2007-01-31T11:58:56
    longitude            (y_dim, x_dim) float32 ...
    latitude             (y_dim, x_dim) float32 ...
    depth_0              (z_dim, y_dim, x_dim) float32 0.5 0.5 0.5 ... 50.5 50.5
Dimensions without coordinates: axis_nbounds, t_dim, x_dim, y_dim, z_dim
Data variables:
    deptht_bounds        (z_dim, axis_nbounds) float32 ...
    sossheig             (t_dim, y_dim, x_dim) float32 ...
    time_counter_bounds  (t_dim, axis_nbounds) datetime64[ns] ...
    time_instant         (t_dim) datetime64[ns] ...
    temperature          (t_dim, z_dim, y_dim, x_dim) float32 ...
    e1                   (y_dim, x_dim) float32 ...
    e2                   (y_dim, x_dim) float32 ...
    e3_0                 (z_dim, y_dim, x_dim) float32 ...
Attributes:
    name:         AMM7_1d_20070101_20070131_25hourm_grid_T
    description:  ocean T grid variables, 25h meaned
    title:        ocean T grid variables, 25h meaned
    Conventions:  CF-1.6
    timeStamp:    2019-Dec-26 04:35:28 GMT
    uuid:         96cae459-d3a1-4f4f-b82b-9259179f95f7
    history:      Tue May 19 12:07:51 2020: ncks -v votemper,sossheig -d time...
    NCO:          4.4.7
```

Along with ``temperature`` (which has been renamed from ``votemper``) a number
of other things have happen under the hood:

1. The dimensions have been renamed to ``t_dim``, ``x_dim``, ``y_dim``, ``z_dim``
2. The coordinates have been renamed to ``time``, ``longitude``, ``latitude``
and ``depth_0``. These are the coordinates for this grid (the t-grid). Also ``depth_0``
has been calculated as the 3D depth array at time zero.
3. The variables ``e1``, ``e2`` and ``e3_0`` have been created. These are the
metrics for the t-grid in the ``x-dim``, ``y-dim`` and ``z_dim`` (at time zero)
directions.

So we see that the NEMO class has standardised some variable names and created an
object based on this discretisation grid by combining the appropriate grid
information with all the variables on that grid.

### 3. Load multiple files

Powered by [xarray](http://xarray.pydata.org/en/stable/index.html), the NEMO
class can load and merge multiple files:

``` python
file_names_amm7 = "nemo_data_T_grid*.nc"
amm7 = coast.NEMO(dn_files + file_names_amm7,
            dn_files + fn_nemo_dom, grid_ref='t-grid', multiple=True)
```
These are automatically stacked over the appropriate dimension, here time.

### 4. Load subset data

With NEMO data files can written for spatial subsets of the whole domain. In the NEMO class, when the grid information
is extracted for pairing with the variables an appropriate subsetting of the grid information is applied:

```python
fn_nemo_dat_subset = 'COAsT_example_NEMO_subset_data.nc'
amm7 = coast.NEMO(dn_files + fn_nemo_dat_subset,
                 dn_files + fn_nemo_dom)
```
