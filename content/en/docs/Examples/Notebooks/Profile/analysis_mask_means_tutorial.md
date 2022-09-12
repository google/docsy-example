---
    title: "Analysis mask means tutorial"
    linkTitle: "Analysis mask means tutorial"
    weight: 5

    description: >
        Analysis mask means tutorial example.
---
Tutorial to calculate mask means (regional means) of variables within a Profile object.

Provide paths to four files:

    fn_dom : NEMO domain file defining mask lon/lat.
    fn_cfg_nemo : NEMO config file.
    fn_profile : Path to netCDF containing profile data.
    fn_out : Path to netCDF output file.

You can use this script with example files by setting:
    
    fn_dom = path.join('./example_files', "coast_example_nemo_domain.nc")
    fn_prof = path.join('./example_files', "coast_example_EN4_201008.nc")
    fn_cfg_nemo = path.join('./config', "example_nemo_grid_t.json")
    fn_cfg_prof = path.join('./config', "example_en4_profiles.json")

### Import relevant packages


```python
import coast
import numpy as np
from os import path
```

### Set filepaths to data and configuration


```python
"""
fn_dom = "<PATH_TO_NEMO_DOMAIN_FILE>"
fn_cfg_nemo = "<PATH_TO_COAST_GRIDDED_CONFIG_FILE>"
fn_cfg_prof = "<PATH_TO_COAST_PROFILE_CONFIG_FILE>"
fn_prof = "<PATH_TO_COAST_PROFILE_NETCDF>"
fn_out = "<PATH_TO_OUTPUT_FILE>"
"""

fn_out = "./output.nc"
fn_dom = path.join('./example_files', "coast_example_nemo_domain.nc")
fn_prof = path.join('./example_files', "coast_example_EN4_201008.nc")
fn_cfg_nemo = path.join('./config', "example_nemo_grid_t.json")
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")
```

### Create NEMO object and read in NEMO data


```python
nemo = coast.Gridded(fn_domain=fn_dom, multiple=True, config=fn_cfg_nemo)
```

### Extract latitude and longitude array


```python
lon = nemo.dataset.longitude.values.squeeze()
lat = nemo.dataset.latitude.values.squeeze()
```

### Create analysis object and mask maker object


```python
profile_analysis = coast.ProfileAnalysis()
```

### Make Profile object and read data


```python
profile = coast.Profile(config=fn_cfg_prof)
profile.read_en4(fn_prof)
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

    Cell In [6], line 2
          1 profile = coast.Profile(config=fn_cfg_prof)
    ----> 2 profile.read_en4(fn_prof)


    File /usr/local/lib/python3.8/site-packages/coast/data/profile.py:94, in Profile.read_en4(self, fn_en4, chunks, multiple)
         92 # If not multiple then just read the netcdf file
         93 if not multiple:
    ---> 94     self.dataset = xr.open_dataset(fn_en4, chunks=chunks)
         96 # If multiple, then we have to get all file names and read them in a
         97 # loop, followed by concatenation
         98 else:
         99     # Check a list is provided
        100     if type(fn_en4) is not list:


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


### Make MaskMaker object and define Regional Masks


```python
# Make MaskMaker object
mm = coast.MaskMaker()

# Define Regional Masks
regional_masks = []
bath = nemo.dataset.bathymetry.values
regional_masks.append(np.ones(lon.shape))
regional_masks.append(mm.region_def_nws_north_sea(lon, lat, bath))
regional_masks.append(mm.region_def_nws_outer_shelf(lon, lat, bath))
regional_masks.append(mm.region_def_nws_english_channel(lon, lat, bath))
regional_masks.append(mm.region_def_nws_norwegian_trench(lon, lat, bath))
regional_masks.append(mm.region_def_kattegat(lon, lat, bath))
regional_masks.append(mm.region_def_south_north_sea(lon, lat, bath))
off_shelf = mm.region_def_off_shelf(lon, lat, bath)
off_shelf[regional_masks[3].astype(bool)] = 0
off_shelf[regional_masks[4].astype(bool)] = 0
regional_masks.append(off_shelf)
regional_masks.append(mm.region_def_irish_sea(lon, lat, bath))

region_names = [
    "whole_domain",
    "north_sea",
    "outer_shelf",
    "eng_channel",
    "nor_trench",
    "kattegat",
    "southern_north_sea",
    "irish_sea",
    "off_shelf",
]

mask_list = mm.make_mask_dataset(lon, lat, regional_masks)
mask_indices = profile_analysis.determine_mask_indices(profile, mask_list)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    Cell In [7], line 33
         20 region_names = [
         21     "whole_domain",
         22     "north_sea",
       (...)
         29     "off_shelf",
         30 ]
         32 mask_list = mm.make_mask_dataset(lon, lat, regional_masks)
    ---> 33 mask_indices = profile_analysis.determine_mask_indices(profile, mask_list)


    File /usr/local/lib/python3.8/site-packages/coast/diagnostics/profile_analysis.py:180, in ProfileAnalysis.determine_mask_indices(cls, profile, mask_dataset)
        174     landmask = mask_dataset.landmask
        176 # SPATIAL indices - nearest neighbour
        177 ind_x, ind_y = general_utils.nearest_indices_2d(
        178     mask_dataset["longitude"],
        179     mask_dataset["latitude"],
    --> 180     dataset["longitude"],
        181     dataset["latitude"],
        182     mask=landmask,
        183 )
        185 # Figure out which points lie in which region
        186 debug(f"Figuring out which regions each profile is in..")


    TypeError: 'NoneType' object is not subscriptable


### Do mask averaging


```python
mask_means = profile_analysis.mask_means(profile, mask_indices)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [8], line 1
    ----> 1 mask_means = profile_analysis.mask_means(profile, mask_indices)


    NameError: name 'mask_indices' is not defined


### Save mask dataset to file


```python
mask_means.to_netcdf(fn_out)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [9], line 1
    ----> 1 mask_means.to_netcdf(fn_out)


    NameError: name 'mask_means' is not defined

