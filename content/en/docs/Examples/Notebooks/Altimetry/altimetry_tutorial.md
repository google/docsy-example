---
    title: "Altimetry tutorial"
    linkTitle: "Altimetry tutorial"
    weight: 5

    description: >
        Altimetry tutorial example.
---
This is a demonstration script for using the Altimetry object in the COAsT package. This object has strict data formatting requirements, which are outlined in `altimetry.py`.

### Relevant imports and filepath configuration


```python
# Begin by importing coast and other packages
import coast

root = "./"
# And by defining some file paths
dn_files = root + "./example_files/"
fn_nemo_dat = dn_files + "coast_example_nemo_data.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
fn_nemo_config = root + "./config/example_nemo_grid_t.json"
fn_altimetry = dn_files + "coast_example_altimetry_data.nc"
fn_altimetry_config = root + "./config/example_altimetry.json"
```

### Load data


```python
# We need to load in a NEMO object for doing NEMO things.
nemo = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=fn_nemo_config)

# And now we can load in our Altimetry data. By default, Altimetry is set up
# to read in CMEMS netCDF files. However, if no path is supplied, then the
# object's dataset will be initialised as None. Custom data can then be loaded
# if desired, as long as it follows the data formatting for Altimetry.
# altimetry = coast.Altimetry(fn_altimetry)
altimetry = coast.Altimetry(fn_altimetry, config=fn_altimetry_config)
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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/altimetry/example_files/coast_example_nemo_data.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3710/1256602535.py in <cell line: 2>()
          1 # We need to load in a NEMO object for doing NEMO things.
    ----> 2 nemo = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=fn_nemo_config)
          3 
          4 # And now we can load in our Altimetry data. By default, Altimetry is set up
          5 # to read in CMEMS netCDF files. However, if no path is supplied, then the


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/gridded.py in __init__(self, fn_data, fn_domain, multiple, config, workers, threads, memory_limit_per_worker, **kwargs)
         47             self.config = ConfigParser(config).config
         48             if self.config.chunks:
    ---> 49                 self._setup_grid_obj(self.config.chunks, multiple, **kwargs)
         50             else:
         51                 self._setup_grid_obj(None, multiple, **kwargs)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/gridded.py in _setup_grid_obj(self, chunks, multiple, **kwargs)
         72 
         73         if self.fn_data is not None:
    ---> 74             self.load(self.fn_data, chunks, multiple)
         75 
         76         self.set_dimension_names(self.config.dataset.dimension_map)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/coast.py in load(self, file_or_dir, chunks, multiple)
         73             self.load_multiple(file_or_dir, chunks)
         74         else:
    ---> 75             self.load_single(file_or_dir, chunks)
         76 
         77     def __getitem__(self, name: str):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/coast.py in load_single(self, file, chunks)
         86         """
         87         info(f"Loading a single file ({file} for {get_slug(self)}")
    ---> 88         self.dataset = xr.open_dataset(file, chunks=chunks)
         89 
         90     def load_multiple(self, directory_to_files: str, chunks: Dict = None):


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/altimetry/example_files/coast_example_nemo_data.nc'


### Subsetting


```python
# Before going any further, lets just cut out the bit of the altimetry that
# is over the model domain. This can be done using `subset_indices_lonlat_box`
# to find relevant indices and then `isel` to extract them. The data here is then also
# also thinned slightly.
ind = altimetry.subset_indices_lonlat_box([-10, 10], [45, 60])
ind = ind[::4]
altimetry = altimetry.isel(t_dim=ind)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3710/1522150305.py in <cell line: 5>()
          3 # to find relevant indices and then `isel` to extract them. The data here is then also
          4 # also thinned slightly.
    ----> 5 ind = altimetry.subset_indices_lonlat_box([-10, 10], [45, 60])
          6 ind = ind[::4]
          7 altimetry = altimetry.isel(t_dim=ind)


    NameError: name 'altimetry' is not defined


### Model interpolation


```python
# Before comparing our observations to the model, we will interpolate a model
# variable to the same time and geographical space as the altimetry. This is
# done using the obs_operator() method:
altimetry.obs_operator(nemo, mod_var_name="ssh", time_interp="nearest")

# Doing this has created a new interpolated variable called interp_ssh and
# saved it back into our Altimetry object. Take a look at altimetry.dataset
# to see for yourself.
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3710/2639949880.py in <cell line: 4>()
          2 # variable to the same time and geographical space as the altimetry. This is
          3 # done using the obs_operator() method:
    ----> 4 altimetry.obs_operator(nemo, mod_var_name="ssh", time_interp="nearest")
          5 
          6 # Doing this has created a new interpolated variable called interp_ssh and


    NameError: name 'altimetry' is not defined



```python
#altimetry.dataset # uncomment to print data object summary
```

### Interpolated vs observed


```python
# Next we will compare this interpolated variable to an observed variable
# using some basic metrics. The basic_stats() routine can be used for this,
# which calculates some simple metrics including differences, RMSE and
# correlations. NOTE: This may not be a wise choice of variables.
stats = altimetry.basic_stats("ocean_tide_standard_name", "interp_ssh")
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3710/3910404276.py in <cell line: 5>()
          3 # which calculates some simple metrics including differences, RMSE and
          4 # correlations. NOTE: This may not be a wise choice of variables.
    ----> 5 stats = altimetry.basic_stats("ocean_tide_standard_name", "interp_ssh")
    

    NameError: name 'altimetry' is not defined



```python
# Take a look inside stats.dataset to see all of the new variables. When using
# basic stats, the returned object is also an Altimetry object, so all of the
# same methods can be applied. Alternatively, if you want to save the new
# metrics to the original altimetry object, set 'create_new_object = False'.

#stats.dataset  # uncomment to print data object summary
```


```python
# Now we will do a more complex comparison using the Continuous Ranked
# Probability Score (CRPS). For this, we need to hand over the model object,
# a model variable and an observed variable. We also give it a neighbourhood
# radius in km (nh_radius).
crps = altimetry.crps(nemo, model_var_name="ssh", obs_var_name="ocean_tide_standard_name", nh_radius=20)

# Again, take a look inside `crps.dataset` to see some new variables. Similarly
# to basic_stats, `create_new_object` keyword arg can be set to `false` to save output to
# the original altimetry object.

#crps.dataset  # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3710/1520344756.py in <cell line: 5>()
          3 # a model variable and an observed variable. We also give it a neighbourhood
          4 # radius in km (nh_radius).
    ----> 5 crps = altimetry.crps(nemo, model_var_name="ssh", obs_var_name="ocean_tide_standard_name", nh_radius=20)
          6 
          7 # Again, take a look inside `crps.dataset` to see some new variables. Similarly


    NameError: name 'altimetry' is not defined


### Plotting data


```python
# Altimetry has a ready built quick_plot() routine for taking a look at any
# of the observed or derived quantities above. So to take a look at the
# 'ocean_tide_standard_name' variable:
fig, ax = altimetry.quick_plot("ocean_tide_standard_name")
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3710/1029636237.py in <cell line: 4>()
          2 # of the observed or derived quantities above. So to take a look at the
          3 # 'ocean_tide_standard_name' variable:
    ----> 4 fig, ax = altimetry.quick_plot("ocean_tide_standard_name")
    

    NameError: name 'altimetry' is not defined



```python
# As stats and crps are also Altimetry objects, quick_plot() can also be used:
# crps quick_plot:
fig, ax = crps.quick_plot("crps")
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3710/3088798311.py in <cell line: 3>()
          1 # As stats and crps are also Altimetry objects, quick_plot() can also be used:
          2 # crps quick_plot:
    ----> 3 fig, ax = crps.quick_plot("crps")
    

    NameError: name 'crps' is not defined



```python
# stats quick_plot:
fig, ax = stats.quick_plot("absolute_error")
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3710/4195741849.py in <cell line: 2>()
          1 # stats quick_plot:
    ----> 2 fig, ax = stats.quick_plot("absolute_error")
    

    NameError: name 'stats' is not defined

