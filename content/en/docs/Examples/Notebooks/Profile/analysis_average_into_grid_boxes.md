---
    title: "Analysis average into grid boxes"
    linkTitle: "Analysis average into grid boxes"
    weight: 5

    description: >
        Analysis average into grid boxes example.
---
Script for showing use of `Profile.average_into_grid_boxes()`. This routines
takes all data in a Profile obejct and averages it into lat/lon grid boxes.

This script can be used for comparing observed and modelled climatologies. 
It should be run AFTER the nearest profiles have been extracted from the model
data, such as shown in `analysis_extract_and_compare.py`. 

Input and output files should be provided as a list. If you only have
one input file, then just enclose the string in []. 

### Relevant imports and filepath configuration


```python
import coast
import numpy as np
import xarray as xr
import os
from os import path

# List of input files
fn_prof = path.join('./example_files', "coast_example_en4_201008.nc")
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")  # If needed
fn_out = path.join('./example_files', 'mask_mean.nc')  # Names of output files (coresponding to fn_in_list), include ".nc"
```

Define longitude and latitude grid.


```python
grid_lon = np.arange(-15, 15, 0.5)
grid_lat = np.arange(45, 65, 0.5)
```

### Load the data
Load in data for averaging (e.g. surface data).


```python
prof_data = coast.Profile(config=fn_cfg_prof)
prof_data.read_en4(fn_prof)
profile_analysis = coast.ProfileAnalysis()
```

    ./config/example_en4_profiles.json



    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/file_manager.py in _acquire_with_cache_info(self, needs_lock)
        198             try:
    --> 199                 file = self._cache[self._key]
        200             except KeyError:


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/lru_cache.py in __getitem__(self, key)
         52         with self._lock:
    ---> 53             value = self._cache[key]
         54             self._cache.move_to_end(key)


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/coast_example_en4_201008.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3684/4124251455.py in <cell line: 2>()
          1 prof_data = coast.Profile(config=fn_cfg_prof)
    ----> 2 prof_data.read_en4(fn_prof)
          3 profile_analysis = coast.ProfileAnalysis()


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/profile.py in read_en4(self, fn_en4, chunks, multiple)
         92         # If not multiple then just read the netcdf file
         93         if not multiple:
    ---> 94             self.dataset = xr.open_dataset(fn_en4, chunks=chunks)
         95 
         96         # If multiple, then we have to get all file names and read them in a


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/api.py in open_dataset(filename_or_obj, engine, chunks, cache, decode_cf, mask_and_scale, decode_times, decode_timedelta, use_cftime, concat_characters, decode_coords, drop_variables, backend_kwargs, *args, **kwargs)
        493 
        494     overwrite_encoded_chunks = kwargs.pop("overwrite_encoded_chunks", None)
    --> 495     backend_ds = backend.open_dataset(
        496         filename_or_obj,
        497         drop_variables=drop_variables,


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in open_dataset(self, filename_or_obj, mask_and_scale, decode_times, concat_characters, decode_coords, drop_variables, use_cftime, decode_timedelta, group, mode, format, clobber, diskless, persist, lock, autoclose)
        551 
        552         filename_or_obj = _normalize_path(filename_or_obj)
    --> 553         store = NetCDF4DataStore.open(
        554             filename_or_obj,
        555             mode=mode,


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in open(cls, filename, mode, format, group, clobber, diskless, persist, lock, lock_maker, autoclose)
        380             netCDF4.Dataset, filename, mode=mode, kwargs=kwargs
        381         )
    --> 382         return cls(manager, group=group, mode=mode, lock=lock, autoclose=autoclose)
        383 
        384     def _acquire(self, needs_lock=True):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in __init__(self, manager, group, mode, lock, autoclose)
        328         self._group = group
        329         self._mode = mode
    --> 330         self.format = self.ds.data_model
        331         self._filename = self.ds.filepath()
        332         self.is_remote = is_remote_uri(self._filename)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in ds(self)
        389     @property
        390     def ds(self):
    --> 391         return self._acquire()
        392 
        393     def open_store_variable(self, name, var):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in _acquire(self, needs_lock)
        383 
        384     def _acquire(self, needs_lock=True):
    --> 385         with self._manager.acquire_context(needs_lock) as root:
        386             ds = _nc4_require_group(root, self._group, self._mode)
        387         return ds


    /usr/share/miniconda/envs/coast/lib/python3.8/contextlib.py in __enter__(self)
        111         del self.args, self.kwds, self.func
        112         try:
    --> 113             return next(self.gen)
        114         except StopIteration:
        115             raise RuntimeError("generator didn't yield") from None


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/file_manager.py in acquire_context(self, needs_lock)
        185     def acquire_context(self, needs_lock=True):
        186         """Context manager for acquiring a file."""
    --> 187         file, cached = self._acquire_with_cache_info(needs_lock)
        188         try:
        189             yield file


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/file_manager.py in _acquire_with_cache_info(self, needs_lock)
        203                     kwargs = kwargs.copy()
        204                     kwargs["mode"] = self._mode
    --> 205                 file = self._opener(*self._args, **kwargs)
        206                 if self._mode == "w":
        207                     # ensure file doesn't get overridden when opened again


    src/netCDF4/_netCDF4.pyx in netCDF4._netCDF4.Dataset.__init__()


    src/netCDF4/_netCDF4.pyx in netCDF4._netCDF4._ensure_nc_success()


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/coast_example_en4_201008.nc'


Take just the data we want so it is faster


```python
prof_data.dataset = prof_data.dataset[["temperature", "practical_salinity"]]
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /tmp/ipykernel_3684/4239776540.py in <cell line: 1>()
    ----> 1 prof_data.dataset = prof_data.dataset[["temperature", "practical_salinity"]]
    

    TypeError: 'NoneType' object is not subscriptable


### Process, merge and save

Average all data across all seasons.


```python
prof_gridded = profile_analysis.average_into_grid_boxes(prof_data, grid_lon, grid_lat)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3684/3309237540.py in <cell line: 1>()
    ----> 1 prof_gridded = profile_analysis.average_into_grid_boxes(prof_data, grid_lon, grid_lat)
    

    NameError: name 'profile_analysis' is not defined


Average data for each season.


```python
prof_gridded_DJF = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="DJF", var_modifier="_DJF"
)
prof_gridded_MAM = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="MAM", var_modifier="_MAM"
)
prof_gridded_JJA = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="JJA", var_modifier="_JJA"
)
prof_gridded_SON = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="SON", var_modifier="_SON"
)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3684/3715300316.py in <cell line: 1>()
    ----> 1 prof_gridded_DJF = profile_analysis.average_into_grid_boxes(
          2     prof_data, grid_lon, grid_lat, season="DJF", var_modifier="_DJF"
          3 )
          4 prof_gridded_MAM = profile_analysis.average_into_grid_boxes(
          5     prof_data, grid_lon, grid_lat, season="MAM", var_modifier="_MAM"


    NameError: name 'profile_analysis' is not defined


Merge together.


```python
ds_prof_gridded = xr.merge(
    (
        prof_gridded.dataset,
        prof_gridded_DJF.dataset,
        prof_gridded_MAM.dataset,
        prof_gridded_JJA.dataset,
        prof_gridded_SON.dataset,
    )
)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3684/3087718761.py in <cell line: 1>()
          1 ds_prof_gridded = xr.merge(
          2     (
    ----> 3         prof_gridded.dataset,
          4         prof_gridded_DJF.dataset,
          5         prof_gridded_MAM.dataset,


    NameError: name 'prof_gridded' is not defined


Save to file.


```python
ds_prof_gridded.to_netcdf(fn_out)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3684/2582897049.py in <cell line: 1>()
    ----> 1 ds_prof_gridded.to_netcdf(fn_out)
    

    NameError: name 'ds_prof_gridded' is not defined



```python

```
