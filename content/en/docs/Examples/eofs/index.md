---
title: "Empirical Orthogonal Functions"
linkTitle: "EOFs"
date: 2020-11-25
weight: 8
description: >
  Using COAsT to compute the Empirical Orthogonal Functions (EOFs) of your data
---


### Load data and compute EOFs

Load packages and define some file paths

``` python
import coast
import xarray as xr
import matplotlib.pyplot as plt

dn_files = "./example_files/"
fn_nemo_dat_t = 'nemo_data_T_grid.nc'
fn_nemo_dom = 'COAsT_example_NEMO_domain.nc'
```
Load data variables that are on the NEMO t-grid

``` python
nemo_t = coast.NEMO( fn_data = dn_files+fn_nemo_dat_t,
                     fn_domain = dn_files+fn_nemo_dom,
                     grid_ref = 't-grid' )
```
For a variable (or subset of a variable) with two spatial dimensions and one temporal dimension, i.e. (x,y,t), the EOFs, temporal projections and variance explained can be computed by calling the 'eofs' method, and passing in the ssh DataArray as an argument. For example, for the sea surface height field, we can do
``` python
eof_data = coast.eofs( nemo_t.dataset.ssh )
``` 
The method returns an xarray dataset that contains the EOFs, temporal projections and variance as DataArrays
``` python
eof_data
Out[..]: 
<xarray.Dataset>
Dimensions:        (mode: 7, t_dim: 7, x_dim: 297, y_dim: 375)
Coordinates:
  * mode           (mode) int64 1 2 3 4 5 6 7
    longitude      (y_dim, x_dim) float32 -19.888672 -19.777344 ... 13.0
    latitude       (y_dim, x_dim) float32 40.066406 40.066406 ... 65.00098
    time           (t_dim) datetime64[ns] 2010-01-01T12:00:00 ... 2010-01-07T12:00:00
Dimensions without coordinates: t_dim, x_dim, y_dim
Data variables:
    EOF            (y_dim, x_dim, mode) float32 0.0 0.0 0.0 0.0 ... 0.0 0.0 0.0
    temporal_proj  (t_dim, mode) float32 -2.2225053 -8.439432 ... 1.2360597e-06
    variance       (mode) float32 43.399567 22.409678 ... 4.250943 8.635705e-13
```
The variance explained of the first four modes is
```python
eof_data.variance.sel(mode=[1,2,3,4])
Out[..]: 
<xarray.DataArray 'variance' (mode: 4)>
array([43.399567, 22.409678, 18.79165 ,  6.359168], dtype=float32)
Coordinates:
  * mode     (mode) int64 1 2 3 4
Attributes:
    standard name:  percentage of variance explained
```
And the EOFs and temporal projections can be quick plotted:
``` python
eof_data.EOF.sel(mode=[1,2,3,4]).plot.pcolormesh(col='mode',col_wrap=2,x='longitude',y='latitude')
```

{{< imgproc eof_example_1 Resize "600x600" >}}
{{< /imgproc >}}

``` python
eof_data.temporal_proj.sel(mode=[1,2,3,4]).plot.(col='mode',col_wrap=2,x='time')
```

{{< imgproc eof_example_2 Resize "600x600" >}}
{{< /imgproc >}}

The more exotic hilbert complex EOFs can also be computed to investigate the propagation of variability, for example:
``` python
heof_data = coast.hilbert_eofs( nemo_t.dataset.ssh )
heof_data
```
giving
``` python
<xarray.Dataset>
Dimensions:         (mode: 7, t_dim: 7, x_dim: 297, y_dim: 375)
Coordinates:
  * mode            (mode) int64 1 2 3 4 5 6 7
    longitude       (y_dim, x_dim) float32 -19.888672 -19.777344 ... 13.0
    latitude        (y_dim, x_dim) float32 40.066406 40.066406 ... 65.00098
    time            (t_dim) datetime64[ns] 2010-01-01T12:00:00 ... 2010-01-07T12:00:00
Dimensions without coordinates: t_dim, x_dim, y_dim
Data variables:
    EOF_amp         (y_dim, x_dim, mode) float64 0.0 0.0 0.0 0.0 ... 0.0 0.0 0.0
    EOF_phase       (y_dim, x_dim, mode) float64 0.0 0.0 0.0 0.0 ... 0.0 0.0 0.0
    temporal_amp    (t_dim, mode) float64 18.39 9.522 ... 4.118e-15 3.128e-15
    temporal_phase  (t_dim, mode) float64 180.0 180.0 0.0 ... 57.38 111.1 -86.89
    variance        (mode) float64 57.99 27.12 14.88 ... 1.112e-29 1.191e-30
```
now with the modes expressed by their amplitude and phase, the spatial propagation of the variability can be examined through the EOF_phase.

