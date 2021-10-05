---
title: "Export to netCDF"
linkTitle: "Export to netCDF"
date: 2021-10-05
weight: 17

description: >
  Example usage of how to export to netCDF.
---

This is a demonstration for how to export intermediate data from COAsT
to netCDF files for later analysis or storage.
The tutorial showcases the ``xarray.to_netcdf()`` method.
http://xarray.pydata.org/en/stable/generated/xarray.Dataset.to_netcdf.html

## Load in example data

Begin by importing coast and other packages
```python
import coast
```
and by defining some file paths
```python
fn_nemo_dat  = "./example_files/COAsT_example_NEMO_data.nc"
fn_nemo_dom  = "./example_files/COAsT_example_NEMO_domain.nc"
config = "./config/example_nemo_grid_t.json"

ofile = "example_export_output.nc" # The target filename for output
```

We need to load in a NEMO object for doing NEMO things.
```python
nemo = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=config)
```

## Export to netCDF

We can export the **whole** ``xr.DataSet`` to a netCDF file
```python
nemo.dataset.to_netcdf(ofile, mode="w", format="NETCDF4")
```

Other file formats are available. From the documentation:
```quote
format:
    NETCDF4: Data is stored in an HDF5 file, using netCDF4 API features.
    NETCDF4_CLASSIC: Data is stored in an HDF5 file, using only netCDF 3 compatible API features.
    NETCDF3_64BIT: 64-bit offset version of the netCDF 3 file format, which fully supports 2+ GB files, but is only compatible with clients linked against netCDF version 3.6.0 or later.
    NETCDF3_CLASSIC: The classic netCDF 3 file format. It does not handle 2+ GB files very well.
```
Similarly other *modes* are available; 'w' (write) is the default.
From the documentation:
```quote
mode ({"w", "a"}, default: "w") – Write (‘w’) or append (‘a’) mode.
    If mode=’w’, any existing file at this location will be overwritten.
    If mode=’a’, existing variables will be overwritten.
```

Alternatively a **single variable** (an ``xr.DataArray`` object) can be exported
```python
nemo.dataset['temperature'].to_netcdf(ofile, format="NETCDF4")
```
Similarly ``xr.DataSet``s collections of variables or ``xr.DataArray`` variables can be
exported to netCDF for objects in the ``TRANSECT``, ``TIDEGAUGE``, etc classes.

## Check the exported file

Check the exported file is as you expect.
Perhaps using ``ncdump -h example_export_output.nc``
Or load file as see that the xarray structure is preserved.
```python
import xarray as xr
object = xr.open_dataset(ofile)
object.close() # close file associated with this object
```
