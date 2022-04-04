---
title: "Stratification diagnostics"
linkTitle: "Stratification diagnostics"
date: 2021-10-05
weight: 10
description: >
  An introduction to stratification diagnostics
---
A demonstration of pycnocline depth and thickness diagnostics. The first and second depth moments of stratification are computed as proxies for pycnocline depth and thickness, suitable for a nearly two-layer fluid.

Note that in the AMM7 example data the plots are not particularly spectacular as the internal tide is poorly resolved at 7km.


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
fn_nemo_dom = './example_files/coast_example_nemo_domain.nc'
config_t = "./config/example_nemo_grid_t.json"
config_w = "./config/example_nemo_grid_w.json"

```

Create a Gridded object and load in the data:


```python
nemo_t = coast.Gridded(fn_nemo_grid_t_dat, fn_nemo_dom, config=config_t)
```

The stratification variables are computed as centred differences of the t-grid variables. These will become w-grid variables. So, create an empty w-grid object, to store stratification. Note how we do not pass a NEMO data file for this load.


```python
nemo_w = coast.Gridded(fn_domain=fn_nemo_dom, config=config_w)
```

## Subset the Domain

We are not interested in the whole doman so it is computationally efficient to subset the data for the region of interest. Here we will look at the North Sea between (51N: 62N) and (-4E:15E). We will great subset objects for both the t- and w-grids:


```python
ind_2d = nemo_t.subset_indices([51,-4], [62,15])
nemo_nwes_t = nemo_t.isel(y_dim=ind_2d[0], x_dim=ind_2d[1]) #nwes = northwest european shelf
ind_2d = nemo_w.subset_indices([51,-4], [62,15])
nemo_nwes_w = nemo_w.isel(y_dim=ind_2d[0], x_dim=ind_2d[1]) #nwes = northwest european shelf
nemo_nwes_t.dataset
```

## Diagnostic calculations and plotting
We can use a COAsT method to construct the in-situ density:


```python
nemo_nwes_t.construct_density( eos='EOS10' )
```

Then we construct stratification using a COAsT method to take the vertical derivative. Noting that the inputs are on t-pts and the outputs are on w-pt


```python
nemo_nwes_w = nemo_nwes_t.differentiate( 'density', dim='z_dim', out_var_str='rho_dz', out_obj=nemo_nwes_w ) # --> sci_nwes_w.rho_dz
```

This has created a variable called `nemo_nwes_w.rho_dz`.

We can now use the `InternalTide` class to construct the first and second moments (over depth) of density. In the limit of an idealised two-layer fluid these converge to the depth and thickness of the interface. I.e. the pycnocline depth and thickness respectively.


```python
#%% Create internal tide diagnostics object
IT = coast.InternalTide(nemo_nwes_t, nemo_nwes_w)

#%%  Construct pycnocline variables: depth and thickness
IT.construct_pycnocline_vars( nemo_nwes_t, nemo_nwes_w )
```

Finally we plot pycnocline variables (depth and thickness) using an InternalTide method:


```python
IT.quick_plot()
```
{{< imgproc strat_1st_mom Fit "600x700" >}}
{{< /imgproc >}}
