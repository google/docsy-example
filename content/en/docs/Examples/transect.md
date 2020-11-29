---
title: "Transects"
linkTitle: "Transects"
date: 2020-09-15
weight: 6
description: >
  An introduction to transect analysis
---
In this tutorial we take a look at subsetting the model data along a transect (a custom straight line) and creating some bespoke diagnostics along it. We look at:

    1. Creating a TRANSECT object, defined between two points.
    2. Plotting data along a transect.
    3. Calculating flow normal to the transect

## Create a transect subset of the example dataset

Load packages and define some file paths


```python
import coast
import xarray as xr
import matplotlib.pyplot as plt

fn_nemo_dat_t = './example_files/nemo_data_T_grid.nc'
fn_nemo_dat_u = './example_files/nemo_data_U_grid.nc'
fn_nemo_dat_v = './example_files/nemo_data_V_grid.nc'
fn_nemo_dom = './example_files/COAsT_example_NEMO_domain.nc'
```

Load data variables that are on the NEMO t-grid


```python
nemo_t = coast.NEMO( fn_data = fn_nemo_dat_t, fn_domain = fn_nemo_dom, grid_ref = 't-grid', chunks={} )
```

Now create a transect between the points (54 N 15 W) and (56 N, 12 W) using the `coast.Transect_t` object. This needs to be passed the corresponding NEMO object and transect end points. The model points closest to these coordinates will be selected as the transect end points.


```python
tran_t = coast.Transect_t( nemo_t, (54,-15), (56,-12) )
tran_t.data
```

where `r_dim` is the dimension along the transect. It is simple to plot a scalar such as temperature along the transect:


```python
temp_mean = tran_t.data.temperature.mean(dim='t_dim')
temp_mean.plot.pcolormesh(y='depth_0', yincrease=False )
```

## Flow across the transect
With NEMO’s staggared grid, the first step is to define the transect on the f-grid so that the velocity components are between f-points. We do not need any model data on the f-grid, just the grid information, so create a nemo f-grid object


```python
nemo_f = coast.NEMO( fn_domain = fn_nemo_dom, grid_ref='f-grid', chunks={} )
```

and a transect on the f-grid


```python
tran_f = coast.Transect_f( nemo_f, (54,-15), (56,-12) )
tran_f.data
```

We also need the i- and j-components of velocity so (lazy) load the model data on the u- and v-grid grids


```python
nemo_u = coast.NEMO( fn_data = fn_nemo_dat_u, fn_domain = fn_nemo_dom, grid_ref='u-grid', chunks={} )
nemo_v = coast.NEMO( fn_data = fn_nemo_dat_v, fn_domain = fn_nemo_dom, grid_ref='v-grid', chunks={} )
```

Now we can calculate the flow across the transect with the method


```python
tran_f.calc_flow_across_transect(nemo_u,nemo_v)
```

The flow across the transect is stored in a new dataset where the variables are all defined at the points between f-points.


```python
tran_f.data_cross_tran_flow
```

For example, to plot the time averaged velocity across the transect, we can plot the ‘normal_velocities’ variable


```python
cross_velocity_mean = tran_f.data_cross_tran_flow.normal_velocities.mean(dim='t_dim')
cross_velocity_mean.rolling(r_dim=2).mean().plot.pcolormesh(yincrease=False,y='depth_0',cbar_kwargs={'label': 'm/s'})
```

or the volume transport across the transect, we can plot the ‘normal_transports’ variable


```python
cross_transport_mean = tran_f.data_cross_tran_flow.normal_transports.mean(dim='t_dim')
cross_transport_mean.rolling(r_dim=2).mean().plot()
plt.ylabel('Sv')
```
