---
title: "Transect subsetting"
linkTitle: "Transects"
date: 2020-11-24
weight: 6
description: >
  Transect subsetting (a vertical slice of data between two coordinates): Creating them and performing some custom diagnostics with them.
---


### Create a transect subset of the example dataset

Load packages and define some file paths

``` python
import coast
import xarray as xr
import matplotlib.pyplot as plt

dn_files = "./example_files/"
fn_nemo_dat_t = 'nemo_data_T_grid.nc'
fn_nemo_dat_u = 'nemo_data_U_grid.nc'
fn_nemo_dat_v = 'nemo_data_V_grid.nc'
fn_nemo_dom = 'COAsT_example_NEMO_domain.nc'
```

Load data variables that are on the NEMO t-grid

``` python
nemo_t = coast.NEMO( fn_data = dn_files+fn_nemo_dat_t,
                     fn_domain = dn_files+fn_nemo_dom,
                     grid_ref = 't-grid' )
```

Create a transect between the points (54 N 15 W) and (56 N, 12 W). The model points closest to these coordinates will be selected as the transect end points. 

``` python
tran_t = coast.Transect_t( nemo_t, (54,-15), (56,-12) )
tran_t.data
Out[..]:
<xarray.Dataset>
Dimensions:      (r_dim: 58, t_dim: 7, z_dim: 51)
Coordinates:
    time         (t_dim) datetime64[ns] 2010-01-01T12:00:00 ... 2010-01-07T12...
    longitude    (r_dim) float32 -15.0 -15.0 -14.888672 ... -12.111328 -12.0
    latitude     (r_dim) float32 54.000977 54.067383 ... 56.000977 56.000977
    depth_0      (z_dim, r_dim) float32 0.49951172 0.49951172 ... 2735.997
Dimensions without coordinates: r_dim, t_dim, z_dim
Data variables:
    e3t_25h      (t_dim, z_dim, r_dim) float32 ...
    temperature  (t_dim, z_dim, r_dim) float32 ...
    salinity     (t_dim, z_dim, r_dim) float32 ...
    ssh          (t_dim, r_dim) float32 ...
    mld          (t_dim, r_dim) float32 ...
    bathymetry   (r_dim) float32 ...
    e1           (r_dim) float32 7262.1484 7250.5117 ... 6908.8594 6908.8594
    e2           (r_dim) float32 7413.633 7413.633 ... 7413.633 7413.633
    e3_0         (z_dim, r_dim) float32 ...
Attributes:
    name:         AMM7_1d_20100101_20100131_25hourm_grid_T
    description:  ocean T grid variables, 25h meaned
    title:        ocean T grid variables, 25h meaned
    Conventions:  CF-1.6
    timeStamp:    2019-Dec-27 04:41:46 GMT
```

where r_dim is the dimension along the transect. It is simple to plot a scaler such as temperature along the transect

``` python
temp_mean = tran_t.data.temperature.mean(dim='t_dim')
temp_mean.plot.pcolormesh(y='depth_0', yincrease=False )
```

{{< imgproc tran_example_1 Fill "875x500" >}}
{{< /imgproc >}}

### Flow across the transect

With NEMO's staggared grid, the first step is to define the transect on the f-grid so that the velocity components are between f-points. We do not need any model data on the f-grid, just the grid information, so create a nemo f-grid object
``` python
nemo_f = coast.NEMO( fn_domain=dn_files+fn_nemo_dom, grid_ref='f-grid' )
```
and a transect on the f-grid
``` python
tran_f = coast.Transect_f( nemo_f, (54,-15), (56,-12) )
tran_f.data
Out[..]: 
<xarray.Dataset>
Dimensions:     (r_dim: 58, z_dim: 51)
Coordinates:
    longitude   (r_dim) float32 -15.055664 -15.055664 ... -12.166992 -12.055664
    latitude    (r_dim) float32 53.967773 54.03418 ... 55.967773 55.967773
    depth_0     (z_dim, r_dim) float32 0.49951172 0.49951172 ... 2739.0999
Dimensions without coordinates: r_dim, z_dim
Data variables:
    bathymetry  (r_dim) float32 ...
    e1          (r_dim) float32 7267.963 7256.332 ... 6914.8184 6914.8184
    e2          (r_dim) float32 7413.633 7413.633 7413.633 ... 7413.633 7413.633
    e3_0        (z_dim, r_dim) float32 ...
```

We also need the i- and j-components of velocity so (lazy) load the model data on the u- and v-grid grids

``` python
nemo_u = coast.NEMO( fn_data=dn_files+fn_nemo_dat_u,
                     fn_domain=dn_files+fn_nemo_dom, 
                     grid_ref='u-grid' )
nemo_v = coast.NEMO( fn_data=dn_files+fn_nemo_dat_v,
                     fn_domain=dn_files+fn_nemo_dom,
                     grid_ref='v-grid' )
```
Now we can calculate the flow across the transect with the method
``` python
tran_f.calc_flow_across_transect(nemo_u,nemo_v)
```
The flow across the transect is stored in a new dataset where the variables are all defined at the points between f-points.
``` python
tran_f.data_cross_tran_flow
Out[25]: 
<xarray.Dataset>
Dimensions:            (r_dim: 57, t_dim: 7, z_dim: 51)
Coordinates:
    time               (t_dim) datetime64[ns] 2010-01-02 ... 2010-01-08
    depth_0            (z_dim, r_dim) float64 0.4995 0.4995 ... 2.739e+03
    latitude           (r_dim) float64 54.0 54.03 54.07 ... 55.9 55.93 55.97
    longitude          (r_dim) float64 -15.06 -15.0 -14.94 ... -12.17 -12.11
Dimensions without coordinates: r_dim, t_dim, z_dim
Data variables:
    normal_velocities  (t_dim, z_dim, r_dim) float64 0.05566 -0.07031 ... nan
    normal_transports  (t_dim, r_dim) float64 1.569 -1.09 ... 1.004 0.04741
    e1                 (r_dim) float64 7.262e+03 7.256e+03 ... 6.915e+03
    e2                 (r_dim) float64 7.414e+03 7.414e+03 ... 7.414e+03
    e3_0               (z_dim, r_dim) float64 1.0 1.0 1.0 ... 48.72 48.65 48.6
``` 
For example, to plot the time averaged velocity across the transect, we can plot the 'normal_velocities' variable
``` python
cross_velocity_mean = tran_f.data_cross_tran_flow.normal_velocities.mean(dim='t_dim')
cross_velocity_mean.rolling(r_dim=2).mean().plot.pcolormesh(yincrease=False,y='depth_0',cbar_kwargs={'label': 'm/s'})
```
{{< imgproc tran_example_2 Fill "875x500" >}}
{{< /imgproc >}}

or the volume transport across the transect, we can plot the 'normal_transports' variable
``` python
cross_transport_mean = tran_f.data_cross_tran_flow.normal_transports.mean(dim='t_dim')
cross_transport_mean.rolling(r_dim=2).mean().plot()
plt.ylabel('Sv')
```
{{< imgproc tran_example_3 Fill "875x500" >}}
{{< /imgproc >}}
