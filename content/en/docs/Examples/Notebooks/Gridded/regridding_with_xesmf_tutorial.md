---
    title: "Regridding with xesmf tutorial"
    linkTitle: "Regridding with xesmf tutorial"
    weight: 5

    description: >
        Regridding with xesmf tutorial example.
---
This is a demonstration on regridding in COAsT. To do this, the COAsT package uses the already capable `xesmf` package, which will need to be installed independently (is not natively part of the COAsT package).

### Introduction

COAsT uses XESMF by providing a data class `xesmf_convert` which provides functions to prepare COAsT.Gridded objects, so they can be passed to XESMF for regridding to either a curvilinear or rectilienar grid.
    
All you need to do if provide a Gridded object and a grid type when creating a new instance of this class. It will then contain an appropriate input dataset. You may also provide a second COAsT gridded object if regridding between two objects.

### Install XESMF

See the package's documentation website here:

    https://xesmf.readthedocs.io/en/latest/index.html

 You can install XESMF using:

        conda install -c conda-forge xesmf.

The setup used by this class has been tested for `xesmf v0.6.2` alongside `esmpy v8.0.0`. It was installed using:

        conda install -c conda-forge xesmf esmpy=8.0.0

### Example useage

If regridding a Gridded object to an arbitrarily defined rectilinear or curvilinear grid, you just need to do the following:

```
import xesmf as xe

# Create your gridded object
gridded = coast.Gridded(*args, **kwargs)

# Pass the gridded object over to xesmf_convert
xesmf_ready = coast.xesmf_convert(gridded, input_grid_type = 'curvilinear')

# Now this object will contain a dataset called xesmf_input, which can
# be passed over to xesmf. E.G:

destination_grid = xesmf.util.grid_2d(-15, 15, 1, 45, 65, 1)
regridder = xe.Regridder(xesmf_ready.input_grid, destination_grid, "bilinear")
regridded_dataset = regridder(xesmf_ready.input_data)
```

XESMF contains a couple of difference functions for quickly creating output
grids, such as xesmf.util.grid_2d and xesmf.util.grid_global(). See their
website for more info.

The process is almost the same if regridding from one COAsT.Gridded object
to another (gridded0 -> gridded1):

```
xesmf_ready = coast.xesmf_convert(gridded0, gridded1,
                                  input_grid_type = "curvilinear",
                                  output_grid_type = "curvilinear")
regridder = xe.Regridder(xesmf_ready.input_grid,
                         xesmf_ready.output_grid, "bilinear")
regridded_dataset = regridder(xesmf_ready.input_data)
```

Note that you can select which variables you want to regrid, either prior
to using this tool or by indexing the input_data dataset. e.g.:

```
regridded_dataset = regridder(xesmf_ready.input_data['temperature'])
```

If your input datasets were lazy loaded, then so will the regridded dataset.
At this point you can either load the data or (recomended) save the regridded
data to file:

```
regridded_dataset.to_netcdf(<filename_to_save>)
```

Before saving back to file, call xesmf_ready.to_gridded() to convert
the regridded xesmf object back to a gridded object

### Compatability Note
(written 8 Sept 2022)
`xesmf` is not included natively within COAsT as satisfying all the dependencies within COAsT gets increasingly challenging with more components in COAsT. So whilst valuable, `xesmf` is currently deemed not core. Here are some notes from a user on its installation with conda:

```
A conda environemt with `esmpy=8.0.0` specified and `xesmf` version unspecified works suggests a downgrade of:
netCDF4 1.5.6
scipy 1.5.3
lxml 4.8

A solution to avoid the downgrade maybe found in
https://github.com/pangeo-data/pangeo-docker-images/issues/101

conda create … "mpi==openmpi" "esmpy==mpi_openmpi*" xesmf
```


```python

```
