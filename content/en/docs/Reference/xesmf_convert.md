---
title: "Xesmf_convert"
linkTitle: "Xesmf_convert"
date: 2022-06-29
description: >
  Docstrings for the Xesmf_convert class
---
### Objects

[xesmf_convert()](#xesmf_convert)<br />
[xesmf_convert._get_xesmf_datasets()](#xesmf_convert_get_xesmf_datasets)<br />
[xesmf_convert.to_gridded()](#xesmf_convertto_gridded)<br />

A class to convert from coast gridded to xesmf.
#### xesmf_convert()
```python
class xesmf_convert():
```

```
Converts the main dataset within a COAsT.Gridded object to be suitable
for input to XESMF for regridding to either a curvilinear or rectilienar
grid. All you need to do if provide a Gridded object and a grid type when
creating a new instance of this class. It will then contain an appropriate
input dataset. You may also provide a second COAsT gridded object if
regridding between two objects. For using xesmf, please see the package's
documentation website here:

https://xesmf.readthedocs.io/en/latest/index.html

You can install XESMF using:

    conda install -c conda-forge xesmf.

The setup used by this class has been tested for xesmf v0.6.2 alongside
esmpy v8.0.0. It was installed using:

    conda install -c conda-forge xesmf esmpy=8.0.0

INPUTS
 input_gridded_obj (Gridded) :: Gridded object to be regridded
 output_gridded_obj(Gridded) :: (optional) Gridded object to regrid TO
 reorder_dims      (bool)    :: Xesmf requires that lat/lon dimensions are
                                the last dimensions. If this is True, then
                                will attempt to reorder dimensions. Not
                                recommended for large datasets.
                                [Default = False]

>>> EXAMPLE USEAGE <<<
If regridding a Gridded object to an arbitrarily defined rectilinear
or curvilinear grid, you just need to do the following:

    import xesmf as xe

    # Create your gridded object
    gridded = coast.Gridded(*args, **kwargs)

    # Pass the gridded object over to xesmf_convert
    xesmf_ready = coast.xesmf_convert(gridded, input_grid_type = 'curvilinear')

    # Now this object will contain a dataset called xesmf_input, which can
    # be passed over to xesmf. E.G:

    destination_grid = xesmf.util.grid_2d(-15, 15, 1, 45, 65, 1)
    regridder = xe.Regridder(xesmf_ready.input_grid, destination_grid,
                             "bilinear")
    regridded_dataset = regridder(xesmf_ready.input_data)

XESMF contains a couple of difference functions for quickly creating output
grids, such as xesmf.util.grid_2d and xesmf.util.grid_global(). See their
website for more info.

The process is almost the same if regridding from one COAsT.Gridded object
to another (gridded0 -> gridded1):

    xesmf_ready = coast.xesmf_convert(gridded0, gridded1,
                                      input_grid_type = "curvilinear",
                                      output_grid_type = "curvilinear")
    regridder = xe.Regridder(xesmf_ready.input_grid,
                             xesmf_ready.output_grid, "bilinear")
    regridded_dataset = regridder(xesmf_ready.input_data)

Note that you can select which variables you want to regrid, either prior
to using this tool or by indexing the input_data dataset. e.g.:

    regridded_dataset = regridder(xesmf_ready.input_data['temperature'])

If your input datasets were lazy loaded, then so will the regridded dataset.
At this point you can either load the data or (recomended) save the regridded
data to file:

    regridded_dataset.to_netcdf(<filename_to_save>)

Before saving back to file, call xesmf_ready.to_gridded() to convert
the regridded xesmf object back to a gridded object
```

##### xesmf_convert._get_xesmf_datasets()
```python
@classmethod
def xesmf_convert._get_xesmf_datasets(cls, dataset, grid_type, reorder_dims=False):
```
> <br />
> For a given dataset taken from a Gridded object and a grid_type<br />
> (curvilinear or rectilinear), determine the xesmf formatted dataset.<br />
> This method does some checks to make sure the dataset is suitable and<br />
> renames the relevant dimensions/coordinates. Any vars that don't have<br />
> both x_dim and y_dim will be dropped. If x_dim and y_dim are present<br />
> BUT they are not the last dimensions AND reorder_dims=True then<br />
> the dimensions will be reordered (not good for lazy loading/chunking).<br />
> <br />
##### xesmf_convert.to_gridded()
```python
@staticmethod
def xesmf_convert.to_gridded(xesmf_dataset):
```
> <br />
> Converts an xesmf_dataset back to a Coast.Gridded() object. Returns<br />
> a Gridded object.<br />
> <br />