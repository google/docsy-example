---
    title: "Dask wrapper template tutorial"
    linkTitle: "Dask wrapper template tutorial"
    weight: 5

    description: >
        Dask wrapper template tutorial example.
---
The notebook proves a template and some instruction on how to create a dask wrapper

### Motivation

Start with an `xarray.DataArray` object called `myDataArra`y, that we want to pass into a function. That function will perform eager evaluation and return a numpy array, but we want lazy evaluation with the possibility to allow dask parallelism. See worked example in `Process_data.seasonal_decomposition`.

### Import dependencies


```python
import dask.array as da
from dask import delayed
import xarray as xr
import numpy as np
```

### Step 1. (optional: allows dask to distribute computation across multiple cores, if not interested see comment 2)

Partition data in `myDataArray` by chunking it up as desired. Note that chunking dimensions need to make sense for your particular problem! Here we just chunk along `dim_2`

```
myDataArray = myDataArray.chunk({"dim_1": myDataArray.dim_1.size, "dim_2": chunksize})  # can be more dimensions
```

Then create a list containing all the array chunks as dask.delayed objects (e.g. 4 chunks => list contain 4 delayed objects)

```
myDataArray_partitioned = myDataArray.data.to_delayed().ravel()
```

#### Comment 1

There are different ways to partition your data. For example, if you start off with a numpy array rather than an xarray DataArray you can just iterate over the array and partition it that way (the partitions do NOT need to be dask.delayed objects). For example see the very simple case here: https://docs.dask.org/en/stable/delayed.html

The method described in 1 is just very convenient for DataArrays where the multi-dimensional chunks may be the desired way to partition the data.

### Step 2.

Call your eager evaluating function using dask.delayed and pass in your data. This returns a list containing the outputs from the function as dask.delayed objects. The list will have the same length as `myDataArray_partitioned`

```
delayed_myFunction_output = [
    delayed(myFunction)(aChunk, other_args_for_myFunction) for aChunk in myDataArray_partitioned
]
```

### Step 3.

Convert the lists of delayed objects to lists of dask arrays to allow array operations. It's possible this step is not necessary!

```
dask_array_list = []
for chunk_idx, aChunk in enumerate(delayed_myFunction_output):
    # When converting from dask.delayed to dask.array, you must know the shape of the
    # array. In this example we know this from the chunk sizes of the original DataArray
    chunk_shape = (myDataArray.chunks[0][0], myDataArray.chunks[1][chunk_idx])
    dask_array_list.append(da.from_delayed(aChunk, shape=chunk_shape, dtype=float))
```

### Step 4.

Concatenate the array chunks together to get a single dask.array. This can be assigned to a new DataArray as desired.

```
myOutputArray = da.concatenate(dask_array_list, axis=1)
```

#### Comment 2

If you skipped step 1., i.e. just want a lazy operation and no parallelism, you can just do this

```
myOutputArray = da.from_delayed(
    delayed(myFunction)(myDataArray, other_args_for_myFunction), shape=myDataArray.shape, dtype=float
)
```


```python

```
