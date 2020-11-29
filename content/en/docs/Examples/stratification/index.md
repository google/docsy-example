---
title: "Stratification diagnostics"
linkTitle: "Stratification diagnostics"
date: 2020-09-15
weight: 10
description: >
  An introduction to stratification diagnostics
---
A demonstration of pycnocline depth and thickness diagnostics. The first and second depth moments of stratification are computed as proxies for pycnocline depth and thickness, suitable for a nearly two-layer fluid.


```python
import coast
import numpy as np
import os
import xarray as xr
import dask
import matplotlib.pyplot as plt
import matplotlib.colors as colors # colormap fiddling
```

## Load in the Data
set some aliases and load the t-grid data:


```python
# set some paths
config = 'AMM7'
fn_nemo_grid_t_dat = './example_files/nemo_data_T_grid_Aug2015.nc'
fn_nemo_dom = './example_files/COAsT_example_NEMO_domain.nc'
```

Create a NEMO object and load in the data:


```python
nemo_t = coast.NEMO(fn_nemo_grid_t_dat, fn_nemo_dom, grid_ref='t-grid', chunks={})
```

The stratification variables are computed as centred differences of the t-grid variables. These will become w-grid variables. So, create an empty w-grid object, to store stratification. Note how we do not pass a NEMO data object for this load.


```python
nemo_w = coast.NEMO( fn_domain = fn_nemo_dom, grid_ref='w-grid')
```

## Subset the Domain

We are not interested in the whole doman so it is computationally efficient to subset the data for the region of interest. Here we will look at the North Sea between (51N: 62N) and (-4E:15E). We will great subset objects for both the t- and w-grids:


```python
ind_2d = nemo_t.subset_indices([51,-4], [62,15])
nemo_nwes_t = nemo_t.isel(y_dim=ind_sci[0], x_dim=ind_sci[1]) #nwes = northwest european shelf
ind_2d = nemo_w.subset_indices([51,-4], [62,15])
nemo_nwes_w = nemo_w.isel(y_dim=ind_sci[0], x_dim=ind_sci[1]) #nwes = northwest european shelf
nemo_nwes_t.dataset
```

## Diagnostic calculations and plotting
We can use a COAsT method to construct the in-situ density:


```python
nemo_nwes_t.construct_density( EOS='EOS10' )
```

Then we construct stratification using a COAsT method to take the vertical derivative. Noting that the inputs are on t-pts and the outputs are on w-pt


```python
nemo_nwes_w = nemo_nwes_t.differentiate( 'density', dim='z_dim', out_varstr='rho_dz', out_obj=nemo_nwes_w ) # --> sci_nwes_w.rho_dz
```

This has created a variable called `nemo_nwes_w.rho_dz`.

We can now use the `INTERNALTIDE` class to construct the first and second moments (over depth) of density. In the limit of an idealised two-layer fluid these converge to the depth and thickness of the interface. I.e. the pycnocline depth and thickness respectively.


```python
#%% Create internal tide diagnostics object
IT = coast.INTERNALTIDE(nemo_nwes_t, nemo_nwes_w)

#%%  Construct pycnocline variables: depth and thickness
IT.construct_pycnocline_vars( nemo_nwes_t, nemo_nwes_w )
```

Finally we plot pycnocline variables (depth and thickness) using an INTERNALTIDES method:


```python
IT.quick_plot()
```
