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
    fn_prof = path.join('./example_files', "coast_example_en4_201008.nc")
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
fn_prof = path.join('./example_files', "coast_example_en4_201008.nc")
fn_cfg_nemo = path.join('./config', "example_nemo_grid_t.json")
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")
```

### Create NEMO object and read in NEMO data


```python
nemo = coast.Gridded(fn_domain=fn_dom, multiple=True, config=fn_cfg_nemo)
```


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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/coast_example_nemo_domain.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3751/1874519616.py in <cell line: 1>()
    ----> 1 nemo = coast.Gridded(fn_domain=fn_dom, multiple=True, config=fn_cfg_nemo)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/gridded.py in __init__(self, fn_data, fn_domain, multiple, config, workers, threads, memory_limit_per_worker, **kwargs)
         47             self.config = ConfigParser(config).config
         48             if self.config.chunks:
    ---> 49                 self._setup_grid_obj(self.config.chunks, multiple, **kwargs)
         50             else:
         51                 self._setup_grid_obj(None, multiple, **kwargs)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/gridded.py in _setup_grid_obj(self, chunks, multiple, **kwargs)
         82         else:
         83             self.filename_domain = self.fn_domain  # store domain fileanme
    ---> 84             dataset_domain = self.load_domain(self.fn_domain, chunks)
         85 
         86             # Define extra domain attributes using kwargs dictionary


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/gridded.py in load_domain(self, fn_domain, chunks)
        123         # Load xarray dataset
        124         info(f'Loading domain: "{fn_domain}"')
    --> 125         dataset_domain = xr.open_dataset(fn_domain)
        126         self.domain_loaded = True
        127         # Rename dimensions


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/coast_example_nemo_domain.nc'


### Extract latitude and longitude array


```python
lon = nemo.dataset.longitude.values.squeeze()
lat = nemo.dataset.latitude.values.squeeze()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3751/1110665935.py in <cell line: 1>()
    ----> 1 lon = nemo.dataset.longitude.values.squeeze()
          2 lat = nemo.dataset.latitude.values.squeeze()


    NameError: name 'nemo' is not defined


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

    /tmp/ipykernel_3751/2557440746.py in <cell line: 2>()
          1 profile = coast.Profile(config=fn_cfg_prof)
    ----> 2 profile.read_en4(fn_prof)
    

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

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3751/2085394473.py in <cell line: 6>()
          4 # Define Regional Masks
          5 regional_masks = []
    ----> 6 bath = nemo.dataset.bathymetry.values
          7 regional_masks.append(np.ones(lon.shape))
          8 regional_masks.append(mm.region_def_nws_north_sea(lon, lat, bath))


    NameError: name 'nemo' is not defined


### Do mask averaging


```python
mask_means = profile_analysis.mask_means(profile, mask_indices)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3751/605467648.py in <cell line: 1>()
    ----> 1 mask_means = profile_analysis.mask_means(profile, mask_indices)
    

    NameError: name 'mask_indices' is not defined


### Save mask dataset to file


```python
mask_means.to_netcdf(fn_out)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3751/3613510459.py in <cell line: 1>()
    ----> 1 mask_means.to_netcdf(fn_out)
    

    NameError: name 'mask_means' is not defined

