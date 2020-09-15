---
title: "Dask"
linkTitle: "Dask"
weight: 3
menu:
  documentation:
    weight: 20
description: >
  information on using Dask within the COAsT package
---

# What is Dask
Dask is a python library that allows code to be run in parallel based on the hardware your running on. This means Dask works just as well on your laptop as on your large server.


## Using Dask
Dask is included in the xarray library, when loading a data source (file/NumPy array) you can turn Dask on by setting the _chunks_ variable

``` python

nemo_t = coast.NEMO( fn_data=dn_files+fn_nemo_grid_t_dat, fn_domain=dn_files+fn_nemo_dom, grid_ref='t-grid', chunks={"time_counter":3})

```

**chunks** tell Dask where to _break_ your data across the different processor tasks.

### Direct Dask

Dask can be imported and used directly

``` python
import Dask.array as da

big_array = da.multiple(array1,array2)

```
Dask arrays follow the NumPy API. This means that most NumPy functions have a Dask version.


## Potential Issues
Dask objects are immutable. This means that the classic approach, pre-allocation follow by modification will not work.

The following code will error.
``` python
import Dask.array as da
e3w_0 = da.squeeze(dataset_domain.e3w_0)
depth_0 = da.zero_like(e3w_0)
depth_0[0, :, :] = 0.5 * e3w_0[0, :, :] # this line will error out
```

#### option 1
Continue using NumPy function but wrapping the final value in a Dask array. This final Dask object will still be in-memory.

``` python
e3w_0 = np.squeeze(dataset_domain.e3w_0)
depth_0 = np.zeros_like(e3w_0)
depth_0[0, :, :] = 0.5 * e3w_0[0, :, :]
depth_0[1:, :, :] = depth_0[0, :, :] + np.cumsum(e3w_0[1:, :, :], axis=0)

depth_0 = da.array(depth_0)
```

#### option 2

Dask offers a feature called [delayed](https://docs.dask.org/en/latest/delayed.html). This can be used as a modifier on your
complex methods as follows;

``` python
@Dask.delayed
def set_timezero_depths(self, dataset_domain):
  # complex workings

```
these do not return the computed answer, rather it returns a delayed object. These delayed object get stacked, as more delayed methods are called. When the value is needed, it can be computed like so;

``` python
ne = coast.NEMO(...)
# come complex delayed methods called

ne.data_variable.compute()
```

Dask will now work out a computing path via all the required methods using as many processor tasks as possible.

### Visualising the Graph
Dask is fundamentally a computational graph library, to understand what is happening in the background it can help to see these graphs (on smaller/simpler problems). This can be achieved by running;

``` python
ne = coast.NEMO(...)
# come complex delayed methods called

ne.data_variable.visualize()
```
this will output a png image of the graph in the calling directory
