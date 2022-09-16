---
    title: "Analysis preprocess en4"
    linkTitle: "Analysis preprocess en4"
    weight: 5

    description: >
        Analysis preprocess en4 example.
---
Script for processing raw EN4 data prior to analysis.
See docstring of `Profile.process_en4()` for more specifics on what it does.

This script will just load modules, read in raw EN4 data, cut out a geographical box, call the processing routine and write the processed data to file.

You don't have to do this for each EN4 file individually if you don't want, you can read in multiple using `multiple = True` on the creation of the profile object. However, if analysing model data in parallel chunks, you may want to split up the processing into smaller files to make the analysis faster.


```python
import sys

# IF USING A DEVELOPMENT BRANCH OF COAST, ADD THE REPOSITORY TO PATH:
# sys.path.append('<PATH_TO_COAST_REPO')
import coast
import pandas as pd
from datetime import datetime
from os import path

print("Modules loaded")

# File paths - input en4, output processed file and read config file
"""
fn_prof = "<PATH_TO_RAW_EN4_DATA_FILE(S)>"
fn_out = "<PATH_TO_OUTPUT_LOCATION_FOR_PROCESSED_PROFILES>"
fn_cfg_prof = "<PATH_TO_COAST_PROFILE_CONFIG_FILE>"
"""

fn_out = "./output.nc"
fn_prof = path.join('./example_files', "coast_example_EN4_201008.nc")
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")


# Some important settings, easier to get at here
longitude_bounds = [-15, 15]  # Geo box to cut out from data (match to model)
latitude_bounds = [40, 65]
multiple = True  # Reading multple files?
```

    Modules loaded


Create profile object containing data


```python
profile = coast.Profile(config=fn_cfg_prof)
profile.read_en4(fn_prof, multiple=multiple)
```

    ./config/example_en4_profiles.json



    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/file_manager.py in _acquire_with_cache_info(self, needs_lock)
        200             try:
    --> 201                 file = self._cache[self._key]
        202             except KeyError:


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/lru_cache.py in __getitem__(self, key)
         54         with self._lock:
    ---> 55             value = self._cache[key]
         56             self._cache.move_to_end(key)


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/coast_example_EN4_201008.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_4021/3838477898.py in <cell line: 2>()
          1 profile = coast.Profile(config=fn_cfg_prof)
    ----> 2 profile.read_en4(fn_prof, multiple=multiple)
    

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/data/profile.py in read_en4(self, fn_en4, chunks, multiple)
        120             for ff in range(0, len(file_to_read)):
        121                 file = file_to_read[ff]
    --> 122                 data_tmp = xr.open_dataset(file, chunks=chunks)
        123                 if ff == 0:
        124                     self.dataset = data_tmp


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/api.py in open_dataset(filename_or_obj, engine, chunks, cache, decode_cf, mask_and_scale, decode_times, decode_timedelta, use_cftime, concat_characters, decode_coords, drop_variables, inline_array, backend_kwargs, **kwargs)
        529 
        530     overwrite_encoded_chunks = kwargs.pop("overwrite_encoded_chunks", None)
    --> 531     backend_ds = backend.open_dataset(
        532         filename_or_obj,
        533         drop_variables=drop_variables,


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in open_dataset(self, filename_or_obj, mask_and_scale, decode_times, concat_characters, decode_coords, drop_variables, use_cftime, decode_timedelta, group, mode, format, clobber, diskless, persist, lock, autoclose)
        553 
        554         filename_or_obj = _normalize_path(filename_or_obj)
    --> 555         store = NetCDF4DataStore.open(
        556             filename_or_obj,
        557             mode=mode,


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in open(cls, filename, mode, format, group, clobber, diskless, persist, lock, lock_maker, autoclose)
        382             netCDF4.Dataset, filename, mode=mode, kwargs=kwargs
        383         )
    --> 384         return cls(manager, group=group, mode=mode, lock=lock, autoclose=autoclose)
        385 
        386     def _acquire(self, needs_lock=True):


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in __init__(self, manager, group, mode, lock, autoclose)
        330         self._group = group
        331         self._mode = mode
    --> 332         self.format = self.ds.data_model
        333         self._filename = self.ds.filepath()
        334         self.is_remote = is_remote_uri(self._filename)


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in ds(self)
        391     @property
        392     def ds(self):
    --> 393         return self._acquire()
        394 
        395     def open_store_variable(self, name, var):


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in _acquire(self, needs_lock)
        385 
        386     def _acquire(self, needs_lock=True):
    --> 387         with self._manager.acquire_context(needs_lock) as root:
        388             ds = _nc4_require_group(root, self._group, self._mode)
        389         return ds


    /usr/share/miniconda/envs/coast-site/lib/python3.8/contextlib.py in __enter__(self)
        111         del self.args, self.kwds, self.func
        112         try:
    --> 113             return next(self.gen)
        114         except StopIteration:
        115             raise RuntimeError("generator didn't yield") from None


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/file_manager.py in acquire_context(self, needs_lock)
        187     def acquire_context(self, needs_lock=True):
        188         """Context manager for acquiring a file."""
    --> 189         file, cached = self._acquire_with_cache_info(needs_lock)
        190         try:
        191             yield file


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/xarray/backends/file_manager.py in _acquire_with_cache_info(self, needs_lock)
        205                     kwargs = kwargs.copy()
        206                     kwargs["mode"] = self._mode
    --> 207                 file = self._opener(*self._args, **kwargs)
        208                 if self._mode == "w":
        209                     # ensure file doesn't get overridden when opened again


    src/netCDF4/_netCDF4.pyx in netCDF4._netCDF4.Dataset.__init__()


    src/netCDF4/_netCDF4.pyx in netCDF4._netCDF4._ensure_nc_success()


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/coast_example_EN4_201008.nc'


Get geographical indices to extract.


```python
profile = profile.subset_indices_lonlat_box(longitude_bounds, latitude_bounds)
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_4021/2450699116.py in <cell line: 1>()
    ----> 1 profile = profile.subset_indices_lonlat_box(longitude_bounds, latitude_bounds)
    

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/data/profile.py in subset_indices_lonlat_box(self, lonbounds, latbounds)
        150         """
        151         ind = general_utils.subset_indices_lonlat_box(
    --> 152             self.dataset.longitude, self.dataset.latitude, lonbounds[0], lonbounds[1], latbounds[0], latbounds[1]
        153         )
        154         return Profile(dataset=self.dataset.isel(id_dim=ind[0]))


    AttributeError: 'NoneType' object has no attribute 'longitude'


Cut out a time slice of the data.


```python
profile = profile.time_slice(date0=datetime(2010, 1, 1), date1=datetime(2010, 1, 20))
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_4021/567752478.py in <cell line: 1>()
    ----> 1 profile = profile.time_slice(date0=datetime(2010, 1, 1), date1=datetime(2010, 1, 20))
    

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/data/profile.py in time_slice(self, date0, date1)
        814         """Return new Gridded object, indexed between dates date0 and date1"""
        815         dataset = self.dataset
    --> 816         t_ind = pd.to_datetime(dataset.time.values) >= date0
        817         dataset = dataset.isel(id_dim=t_ind)
        818         t_ind = pd.to_datetime(dataset.time.values) < date1


    AttributeError: 'NoneType' object has no attribute 'time'


Process the extracted data into new processed profile.


```python
processed_profile = profile.process_en4()
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_4021/2338363098.py in <cell line: 1>()
    ----> 1 processed_profile = profile.process_en4()
    

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/data/profile.py in process_en4(self, sort_time)
        550         # REJECT profiles that are QC flagged.
        551         debug(f" Applying QUALITY CONTROL to EN4 data...")
    --> 552         ds.qc_flags_profiles.load()
        553 
        554         # This line reads converts the QC integer to a binary string.


    AttributeError: 'NoneType' object has no attribute 'qc_flags_profiles'


Sometimes the following line is needed to avoid an error::  
`processed_profile.dataset["time"] = ("id_dim", pd.to_datetime(processed_profile.dataset.time.values))`

Write processed profiles to file.


```python
processed_profile.dataset.to_netcdf(fn_out)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_4021/1086284925.py in <cell line: 1>()
    ----> 1 processed_profile.dataset.to_netcdf(fn_out)
    

    NameError: name 'processed_profile' is not defined



```python

```
