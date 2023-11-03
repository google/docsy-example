---
title: "Working Lazily"
linkTitle: "Lazy"
weight: 2
description: >
  Information on using lazy loading and/or evaluation within the COAsT package
---

## What is lazy...

### ...loading
Lazy loading determines if data is read into memory straight away (on that line of code execution) or if the loading is delayed until the data is physical altered by some function (normally mathematical in nature)

### ...evaluation
Lazy evaluation is about delaying the execution of a method/function call until the value is physical required, normally as a graph or printed to screen.  Lazy evaluation can also help with memory management, useful with large dataset, by allowing for optimisation on the chained methods calls.

Lazy loading and Lazy evaluation are offer used together, though it is not mandatory and always worth checking that both are happening.   


## Being Lazy in COAsT
There are two way to be Lazy within the COAsT package.

* xarray
* Dask

## xarray
COAsT uses xarray to load NetCDF files in, by default this will be Lazy, the raw data values will not be brought into memory.

you can slice and subset the data while still having the lazy loading honoured, it is not _until_ the data is altered, say via a call to NumPy.cumsum, that the required data will be loaded into memory.

Note the data on disk (in the NetCDF file) is never altered, only the values in memory are changed.

```python
import xarray as xr
import NumPy as np

dataset_domain = xr.open_dataset(fn_domain)
e3w_0 = dataset_domain.e3w_0 # still lazy loaded
e3w_0_cs = np.cumsum(e3w_0[1:, :, :], axis=0) # now in memory

```


## Dask
When in use Dask will provide lazy evaluation on top of the lazy loading.

using the same example as above, a file loaded in using xarray, this time with the chunks option set, will not only lazy load the data, but will turn on Dask, now using either the xarray or Dask wrapper functions will mean the NumPy cumsum call is not evaluated right way, in fact it will not be evaluated until either the compute function is called, or a greedy method from another library is used.

```python
import xarray as xr

dataset_domain = xr.open_dataset(fn_domain, chunks={"t": 1})
e3w_0 = dataset_domain.e3w_0 # still lazy loaded
e3w_0_cs = e3w_0[1:, :, :].cumsum(axis=0) # Dask backed Lazy evaluation

```

We discuss Dask even more [here](../dask/).
