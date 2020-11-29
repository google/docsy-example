---
title: "The NEMO class"
linkTitle: "Intro to the NEMO class"
date: 2020-09-15
weight: 1
description: >
  An introduction to the NEMO class. Loading variables and grid information.
---
This script is designed to be a brief introduction to the NEMO class including:

    1. Creation of a NEMO object
    2. Loading data into the NEMO object.
    3. Combining NEMO output and NEMO domain data.
    4. Interrogating the NEMO object.
    5. Basic manipulation ans subsetting
    6. Looking at the data with matplotlib

Up to date as of: 26/11/2020

### Loading and Interrogating
Begin by importing COAsT and define some file paths for NEMO output data and a NEMO domain


```python
import coast
import matplotlib.pyplot as plt
import datetime
import numpy as np

fn_nemo_dat = './example_files/COAsT_example_NEMO_data.nc'
fn_nemo_dom = './example_files/COAsT_example_NEMO_domain.nc'
```

We can create a new NEMO object by simple calling ```coast.NEMO()```. By passing this a NEMO data file and NEMO domain file, COAsT will combine the two into a single xarray dataset within the NEMO object. Each individual NEMO object should be for a specified NEMO grid reference, which is also passed as an argument. By passing `chunks = {}`, we switch on the Dask library.


```python
nemo_t = coast.NEMO(fn_data = fn_nemo_dat, fn_domain = fn_nemo_dom, grid_ref='t-grid', chunks = {})
```

Our new NEMO object `nemo_t` contains a variable called `dataset`, which holds information on the two files we passed. Let's have a look at this:


```python
nemo_t.dataset
```

This is an xarray dataset, which has all the information on netCDF style structures. You can see dimensions, coordinates and data variables. At the moment, none of the actual data is loaded to memory and will remain that way until it needs to be accessed. 

Along with temperature (which has been renamed from votemper) a number of other things have happen under the hood:

    1. The dimensions have been renamed to t_dim, x_dim, y_dim, z_dim
    2. The coordinates have been renamed to time, longitude, latitude and depth_0. These are the coordinates for this grid (the t-grid). Also depth_0 has been calculated as the 3D depth array at time zero.
    3. The variables e1, e2 and e3_0 have been created. These are the metrics for the t-grid in the x-dim, y-dim and z_dim (at time zero) directions.

So we see that the NEMO class has standardised some variable names and created an object based on this discretisation grid by combining the appropriate grid information with all the variables on that grid.

We can interact with this as an xarray Dataset object. So to extract a specific variable (say temperature):


```python
ssh = nemo_t.dataset.ssh
ssh
```

Or as a numpy array:


```python
ssh_np = ssh.values
ssh_np.shape
```

Then lets plot up a single time snapshot of ssh using matplotlib:


```python
plt.pcolormesh(nemo_t.dataset.longitude, nemo_t.dataset.latitude, nemo_t.dataset.ssh[0])
```

### Some Manipulation
There are currently some basic subsetting routines for NEMO objects, to cut out specified regions of data. Fundamentally, this can be done using xarray's `isel` or `sel` routines to index the data. In this case, the NEMO object will pass arguments straight through to `xarray.isel`. 

Lets get the indices of all model points within 111km km of (5W, 55N):


```python
ind_x, ind_y = nemo_t.subset_indices_by_distance(centre_lon=-5, centre_lat=55, radius=111)
ind_x.shape
```

Now create a new, smaller subsetted NEMO object by passing those indices to isel. 


```python
nemo_t_subset = nemo_t.isel(x_dim=ind_x, y_dim=ind_y)
nemo_t_subset.dataset
```

Alternatively, `xarray.isel` can be applied directly to the `xarray.Dataset` object. 

A longitude/latitude box of data can also be extracted using `NEMO.subset_indices()`.
