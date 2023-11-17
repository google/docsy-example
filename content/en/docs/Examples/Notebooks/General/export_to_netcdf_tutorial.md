---
    title: "Export to netcdf tutorial"
    linkTitle: "Export to netcdf tutorial"
    weight: 5

    description: >
        Export to netcdf tutorial example.
---
This is a demonstration script for how to export intermediate data from COAsT
to netCDF files for later analysis or storage.
The tutorial showcases the xarray.to_netcdf() method.
http://xarray.pydata.org/en/stable/generated/xarray.Dataset.to_netcdf.html

### Begin by importing COAsT and other packages


```python
import coast
import xarray as xr
```

### Now define some file paths


```python
root = "./"
# And by defining some file paths
dn_files = root + "./example_files/"
fn_nemo_dat = dn_files + "coast_example_nemo_data.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
config = root + "./config/example_nemo_grid_t.json"
ofile = "example_export_output.nc"  # The target filename for output
```

### We need to load in a NEMO object for doing NEMO things


```python
nemo = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=config)
```

    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/dataset.py:278: UserWarning: The specified chunks separate the stored chunks along dimension "time_counter" starting at index 2. This could degrade performance. Instead, consider rechunking after loading.
      warnings.warn(


### We can export the whole xr.DataSet to a netCDF file
Other file formats are available. From the documentation:
   - NETCDF4: Data is stored in an HDF5 file, using netCDF4 API features.
   - NETCDF4_CLASSIC: Data is stored in an HDF5 file, using only netCDF 3 compatible API features.
   - NETCDF3_64BIT: 64-bit offset version of the netCDF 3 file format, which fully supports 2+ GB files, but is only compatible with clients linked against netCDF version 3.6.0 or later.
   - NETCDF3_CLASSIC: The classic netCDF 3 file format. It does not handle 2+ GB files very well.

Mode - 'w' (write) is the default. Other options from the documentation:

   - mode ({"w", "a"}, default: "w") – Write (‘w’) or append (‘a’) mode.
   - If mode=’w’, any existing file at this location will be overwritten.
   - If mode=’a’, existing variables will be overwritten.
   
Similarly xr.DataSets collections of variables or xr.DataArray variables can be exported to netCDF for objects in the TRANSECT, TIDEGAUGE, etc classes.


```python
nemo.dataset.to_netcdf(ofile, mode="w", format="NETCDF4")
```

### Alternatively a single variable (an xr.DataArray object) can be exported


```python
nemo.dataset["temperature"].to_netcdf(ofile, format="NETCDF4")
```

### Check the exported file is as you expect
Perhaps by using `ncdump -h example_export_output.nc`, or load the file and see that the xarray structure is preserved.


```python
object = xr.open_dataset(ofile)
object.close()  # close file associated with this object
```


```python

```
