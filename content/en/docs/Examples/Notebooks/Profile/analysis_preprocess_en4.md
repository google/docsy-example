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

    File /usr/local/lib/python3.8/site-packages/xarray/backends/file_manager.py:201, in CachingFileManager._acquire_with_cache_info(self, needs_lock)
        200 try:
    --> 201     file = self._cache[self._key]
        202 except KeyError:


    File /usr/local/lib/python3.8/site-packages/xarray/backends/lru_cache.py:55, in LRUCache.__getitem__(self, key)
         54 with self._lock:
    ---> 55     value = self._cache[key]
         56     self._cache.move_to_end(key)


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/example_scripts/notebooks/runnable_notebooks/example_files/coast_example_EN4_201008.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    Cell In [2], line 2
          1 profile = coast.Profile(config=fn_cfg_prof)
    ----> 2 profile.read_en4(fn_prof, multiple=multiple)


    File /usr/local/lib/python3.8/site-packages/coast/data/profile.py:122, in Profile.read_en4(self, fn_en4, chunks, multiple)
        120 for ff in range(0, len(file_to_read)):
        121     file = file_to_read[ff]
    --> 122     data_tmp = xr.open_dataset(file, chunks=chunks)
        123     if ff == 0:
        124         self.dataset = data_tmp


    File /usr/local/lib/python3.8/site-packages/xarray/backends/api.py:531, in open_dataset(filename_or_obj, engine, chunks, cache, decode_cf, mask_and_scale, decode_times, decode_timedelta, use_cftime, concat_characters, decode_coords, drop_variables, inline_array, backend_kwargs, **kwargs)
        519 decoders = _resolve_decoders_kwargs(
        520     decode_cf,
        521     open_backend_dataset_parameters=backend.open_dataset_parameters,
       (...)
        527     decode_coords=decode_coords,
        528 )
        530 overwrite_encoded_chunks = kwargs.pop("overwrite_encoded_chunks", None)
    --> 531 backend_ds = backend.open_dataset(
        532     filename_or_obj,
        533     drop_variables=drop_variables,
        534     **decoders,
        535     **kwargs,
        536 )
        537 ds = _dataset_from_backend_dataset(
        538     backend_ds,
        539     filename_or_obj,
       (...)
        547     **kwargs,
        548 )
        549 return ds


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:555, in NetCDF4BackendEntrypoint.open_dataset(self, filename_or_obj, mask_and_scale, decode_times, concat_characters, decode_coords, drop_variables, use_cftime, decode_timedelta, group, mode, format, clobber, diskless, persist, lock, autoclose)
        534 def open_dataset(
        535     self,
        536     filename_or_obj,
       (...)
        551     autoclose=False,
        552 ):
        554     filename_or_obj = _normalize_path(filename_or_obj)
    --> 555     store = NetCDF4DataStore.open(
        556         filename_or_obj,
        557         mode=mode,
        558         format=format,
        559         group=group,
        560         clobber=clobber,
        561         diskless=diskless,
        562         persist=persist,
        563         lock=lock,
        564         autoclose=autoclose,
        565     )
        567     store_entrypoint = StoreBackendEntrypoint()
        568     with close_on_error(store):


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:384, in NetCDF4DataStore.open(cls, filename, mode, format, group, clobber, diskless, persist, lock, lock_maker, autoclose)
        378 kwargs = dict(
        379     clobber=clobber, diskless=diskless, persist=persist, format=format
        380 )
        381 manager = CachingFileManager(
        382     netCDF4.Dataset, filename, mode=mode, kwargs=kwargs
        383 )
    --> 384 return cls(manager, group=group, mode=mode, lock=lock, autoclose=autoclose)


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:332, in NetCDF4DataStore.__init__(self, manager, group, mode, lock, autoclose)
        330 self._group = group
        331 self._mode = mode
    --> 332 self.format = self.ds.data_model
        333 self._filename = self.ds.filepath()
        334 self.is_remote = is_remote_uri(self._filename)


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:393, in NetCDF4DataStore.ds(self)
        391 @property
        392 def ds(self):
    --> 393     return self._acquire()


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:387, in NetCDF4DataStore._acquire(self, needs_lock)
        386 def _acquire(self, needs_lock=True):
    --> 387     with self._manager.acquire_context(needs_lock) as root:
        388         ds = _nc4_require_group(root, self._group, self._mode)
        389     return ds


    File /usr/local/lib/python3.8/contextlib.py:113, in _GeneratorContextManager.__enter__(self)
        111 del self.args, self.kwds, self.func
        112 try:
    --> 113     return next(self.gen)
        114 except StopIteration:
        115     raise RuntimeError("generator didn't yield") from None


    File /usr/local/lib/python3.8/site-packages/xarray/backends/file_manager.py:189, in CachingFileManager.acquire_context(self, needs_lock)
        186 @contextlib.contextmanager
        187 def acquire_context(self, needs_lock=True):
        188     """Context manager for acquiring a file."""
    --> 189     file, cached = self._acquire_with_cache_info(needs_lock)
        190     try:
        191         yield file


    File /usr/local/lib/python3.8/site-packages/xarray/backends/file_manager.py:207, in CachingFileManager._acquire_with_cache_info(self, needs_lock)
        205     kwargs = kwargs.copy()
        206     kwargs["mode"] = self._mode
    --> 207 file = self._opener(*self._args, **kwargs)
        208 if self._mode == "w":
        209     # ensure file doesn't get overridden when opened again
        210     self._mode = "a"


    File src/netCDF4/_netCDF4.pyx:2353, in netCDF4._netCDF4.Dataset.__init__()


    File src/netCDF4/_netCDF4.pyx:1963, in netCDF4._netCDF4._ensure_nc_success()


    FileNotFoundError: [Errno 2] No such file or directory: b'/example_scripts/notebooks/runnable_notebooks/example_files/coast_example_EN4_201008.nc'


Get geographical indices to extract.


```python
profile = profile.subset_indices_lonlat_box(longitude_bounds, latitude_bounds)
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    Cell In [3], line 1
    ----> 1 profile = profile.subset_indices_lonlat_box(longitude_bounds, latitude_bounds)


    File /usr/local/lib/python3.8/site-packages/coast/data/profile.py:152, in Profile.subset_indices_lonlat_box(self, lonbounds, latbounds)
        143 def subset_indices_lonlat_box(self, lonbounds, latbounds):
        144     """Get a subset of this Profile() object in a spatial box.
        145 
        146     lonbounds -- Array of form [min_longitude=-180, max_longitude=180]
       (...)
        149     return: A new profile object containing subsetted data
        150     """
        151     ind = general_utils.subset_indices_lonlat_box(
    --> 152         self.dataset.longitude, self.dataset.latitude, lonbounds[0], lonbounds[1], latbounds[0], latbounds[1]
        153     )
        154     return Profile(dataset=self.dataset.isel(id_dim=ind[0]))


    AttributeError: 'NoneType' object has no attribute 'longitude'


Cut out a time slice of the data.


```python
profile = profile.time_slice(date0=datetime(2010, 1, 1), date1=datetime(2010, 1, 20))
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    Cell In [4], line 1
    ----> 1 profile = profile.time_slice(date0=datetime(2010, 1, 1), date1=datetime(2010, 1, 20))


    File /usr/local/lib/python3.8/site-packages/coast/data/profile.py:816, in Profile.time_slice(self, date0, date1)
        814 """Return new Gridded object, indexed between dates date0 and date1"""
        815 dataset = self.dataset
    --> 816 t_ind = pd.to_datetime(dataset.time.values) >= date0
        817 dataset = dataset.isel(id_dim=t_ind)
        818 t_ind = pd.to_datetime(dataset.time.values) < date1


    AttributeError: 'NoneType' object has no attribute 'time'


Process the extracted data into new processed profile.


```python
processed_profile = profile.process_en4()
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    Cell In [5], line 1
    ----> 1 processed_profile = profile.process_en4()


    File /usr/local/lib/python3.8/site-packages/coast/data/profile.py:552, in Profile.process_en4(self, sort_time)
        550 # REJECT profiles that are QC flagged.
        551 debug(f" Applying QUALITY CONTROL to EN4 data...")
    --> 552 ds.qc_flags_profiles.load()
        554 # This line reads converts the QC integer to a binary string.
        555 # Each bit of this string is a different QC flag. Which flag is which can
        556 # be found on the EN4 website:
        557 # https://www.metoffice.gov.uk/hadobs/en4/en4-0-2-profile-file-format.html
        558 qc_str = [np.binary_repr(ds.qc_flags_profiles.values[pp]).zfill(30)[::-1] for pp in range(ds.dims["id_dim"])]


    AttributeError: 'NoneType' object has no attribute 'qc_flags_profiles'


Sometimes the following line is needed to avoid an error::  
`processed_profile.dataset["time"] = ("id_dim", pd.to_datetime(processed_profile.dataset.time.values))`

Write processed profiles to file.


```python
processed_profile.dataset.to_netcdf(fn_out)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [6], line 1
    ----> 1 processed_profile.dataset.to_netcdf(fn_out)


    NameError: name 'processed_profile' is not defined



```python

```
