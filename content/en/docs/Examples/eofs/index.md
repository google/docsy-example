---
title: "Empirical Orthogonal Functions"
linkTitle: "EOFs"
date: 2020-11-25
weight: 8
description: >
  Using COAsT to compute the Empirical Orthogonal Functions (EOFs) of your data
---
Using COAsT to compute the Empirical Orthogonal Functions (EOFs) of your data.

## Load data and compute EOFs
Load packages and define some file paths


```python
import coast
import xarray as xr
import matplotlib.pyplot as plt

fn_nemo_dat_t = "./example_files/nemo_data_T_grid.nc"
fn_nemo_dom = "./example_files/COAsT_example_NEMO_domain.nc"
fn_nemo_config = "./config/example_nemo_grid_t.json"

```

Load data variables that are on the NEMO t-grid


```python
nemo_t = coast.Gridded( fn_data = fn_nemo_dat_t, fn_domain = fn_nemo_dom, config = fn_nemo_config )
```

For a variable (or subset of a variable) with two spatial dimensions and one temporal dimension, i.e. (x,y,t), the EOFs, temporal projections and variance explained can be computed by calling the ‘eofs’ method, and passing in the ssh DataArray as an argument. For example, for the sea surface height field, we can do


```python
eof_data = coast.compute_eofs( nemo_t.dataset.ssh )
```

The method returns an xarray dataset that contains the EOFs, temporal projections and variance as DataArrays


```python
eof_data
```

The variance explained of the first four modes is


```python
eof_data.variance.sel(mode=[1,2,3,4])
```

And the EOFs and temporal projections can be quick plotted:


```python
eof_data.EOF.sel(mode=[1,2,3,4]).plot.pcolormesh(col='mode',col_wrap=2,x='longitude',y='latitude')
```
{{< imgproc eof_example_1 Fit "600x700" >}}
{{< /imgproc >}}

```python
eof_data.temporal_proj.sel(mode=[1,2,3,4]).plot(col='mode',col_wrap=2,x='time')
```

{{< imgproc eof_example_2 Fit "600x700" >}}
{{< /imgproc >}}

The more exotic hilbert complex EOFs can also be computed to investigate the propagation of variability, for example:


```python
heof_data = coast.compute_hilbert_eofs( nemo_t.dataset.ssh )
heof_data
```

now with the modes expressed by their amplitude and phase, the spatial propagation of the variability can be examined through the EOF_phase.
