---
    title: "Transect tutorial"
    linkTitle: "Transect tutorial"
    weight: 5

    description: >
        Transect tutorial example.
---
This is a demonstration script for using the Transect class in the COAsT
package. This object has strict data formatting requirements, which are
outlined in tranect.py.  
    _**Transect subsetting** (a vertical slice of data between two coordinates): Creating them and performing some custom diagnostics with them._  

In this tutorial we take a look at subsetting the model data along a transect (a custom straight line) and creating some bespoke diagnostics along it. We look at:

    1. Creating a TRANSECT object, defined between two points.
    2. Plotting data along a transect.
    3. Calculating flow normal to the transect

### Import relevant packages


```python
import coast
import matplotlib.pyplot as plt
```

### Define filepaths for data and configuration


```python
root = "./"
# And by defining some file paths
dn_files = root + "./example_files/"
fn_nemo_dat_t = dn_files + "nemo_data_T_grid.nc"
fn_nemo_dat_u = dn_files + "nemo_data_U_grid.nc"
fn_nemo_dat_v = dn_files + "nemo_data_V_grid.nc"
fn_nemo_dom =   dn_files + "coast_example_nemo_domain.nc"
# Configuration files describing the data files
fn_config_t_grid = root + "./config/example_nemo_grid_t.json"
fn_config_f_grid = root + "./config/example_nemo_grid_f.json"
fn_config_u_grid = root + "./config/example_nemo_grid_u.json"
fn_config_v_grid = root + "./config/example_nemo_grid_v.json"
```

### Load data variables that are on the NEMO t-grid


```python
nemo_t = coast.Gridded(fn_data=fn_nemo_dat_t, fn_domain=fn_nemo_dom, config=fn_config_t_grid)
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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/nemo_data_T_grid.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3821/2070668237.py in <cell line: 1>()
    ----> 1 nemo_t = coast.Gridded(fn_data=fn_nemo_dat_t, fn_domain=fn_nemo_dom, config=fn_config_t_grid)
    

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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/nemo_data_T_grid.nc'


### Now create a transect using the `coast.TransectT` object. 
The transect is between the points (54 N 15 W) and (56 N, 12 W). This needs to be passed the corresponding NEMO object and transect end points. The model points closest to these coordinates will be selected as the transect end points.



```python
tran_t = coast.TransectT(nemo_t, (54, -15), (56, -12))

# Inspect the data
#tran_t.data # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3821/3527157368.py in <cell line: 1>()
    ----> 1 tran_t = coast.TransectT(nemo_t, (54, -15), (56, -12))
          2 
          3 # Inspect the data
          4 #tran_t.data # uncomment to print data object summary


    NameError: name 'nemo_t' is not defined


### Plot the data


```python
# It is simple to plot a scalar such as temperature along the transect:
temp_mean = tran_t.data.temperature.mean(dim="t_dim")
plt.figure()
temp_mean.plot.pcolormesh(y="depth_0", yincrease=False)
plt.show()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3821/3316528086.py in <cell line: 2>()
          1 # It is simple to plot a scalar such as temperature along the transect:
    ----> 2 temp_mean = tran_t.data.temperature.mean(dim="t_dim")
          3 plt.figure()
          4 temp_mean.plot.pcolormesh(y="depth_0", yincrease=False)
          5 plt.show()


    NameError: name 'tran_t' is not defined


### Create a nemo f-grid object
With NEMO’s staggered grid, the first step is to define the transect on the f-grid so that the velocity components are between f-points. We do not need any model data on the f-grid, just the grid information, so create a nemo f-grid object



```python
nemo_f = coast.Gridded(fn_domain=fn_nemo_dom, config=fn_config_f_grid)
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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/coast_example_nemo_domain.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3821/3673778941.py in <cell line: 1>()
    ----> 1 nemo_f = coast.Gridded(fn_domain=fn_nemo_dom, config=fn_config_f_grid)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/gridded.py in __init__(self, fn_data, fn_domain, multiple, config, workers, threads, memory_limit_per_worker, **kwargs)
         49                 self._setup_grid_obj(self.config.chunks, multiple, **kwargs)
         50             else:
    ---> 51                 self._setup_grid_obj(None, multiple, **kwargs)
         52         else:  # allow for usage without config file, this will be limted and dosen't bring the full COAST features
         53             debug("Config file expected. Limited functionality without config file")


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/coast_example_nemo_domain.nc'


### Transect on the f-grid


```python
tran_f = coast.TransectF(nemo_f, (54, -15), (56, -12))
# Inspect the data
#tran_f.data # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3821/845317803.py in <cell line: 1>()
    ----> 1 tran_f = coast.TransectF(nemo_f, (54, -15), (56, -12))
          2 # Inspect the data
          3 #tran_f.data # uncomment to print data object summary


    NameError: name 'nemo_f' is not defined


### Load model data on the u- and v- grids


```python
nemo_u = coast.Gridded(fn_data=fn_nemo_dat_u, fn_domain=fn_nemo_dom, config=fn_config_u_grid)
nemo_v = coast.Gridded(fn_data=fn_nemo_dat_v, fn_domain=fn_nemo_dom, config=fn_config_v_grid)
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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/nemo_data_U_grid.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3821/1969222824.py in <cell line: 1>()
    ----> 1 nemo_u = coast.Gridded(fn_data=fn_nemo_dat_u, fn_domain=fn_nemo_dom, config=fn_config_u_grid)
          2 nemo_v = coast.Gridded(fn_data=fn_nemo_dat_v, fn_domain=fn_nemo_dom, config=fn_config_v_grid)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/gridded.py in __init__(self, fn_data, fn_domain, multiple, config, workers, threads, memory_limit_per_worker, **kwargs)
         49                 self._setup_grid_obj(self.config.chunks, multiple, **kwargs)
         50             else:
    ---> 51                 self._setup_grid_obj(None, multiple, **kwargs)
         52         else:  # allow for usage without config file, this will be limted and dosen't bring the full COAST features
         53             debug("Config file expected. Limited functionality without config file")


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/nemo_data_U_grid.nc'


### Calculate the flow across the transect


```python
tran_f.calc_flow_across_transect(nemo_u, nemo_v)

# The flow across the transect is stored in a new dataset where the variables are all defined at the points between f-points.
#tran_f.data_cross_tran_flow # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3821/1315015121.py in <cell line: 1>()
    ----> 1 tran_f.calc_flow_across_transect(nemo_u, nemo_v)
          2 
          3 # The flow across the transect is stored in a new dataset where the variables are all defined at the points between f-points.
          4 #tran_f.data_cross_tran_flow # uncomment to print data object summary


    NameError: name 'tran_f' is not defined


### Plot the time averaged velocity across the transect


```python
# To do this we can plot the ‘normal_velocities’ variable.
cross_velocity_mean = tran_f.data_cross_tran_flow.normal_velocities.mean(dim="t_dim")
plt.figure()
cross_velocity_mean.rolling(r_dim=2).mean().plot.pcolormesh(yincrease=False, y="depth_0", cbar_kwargs={"label": "m/s"})
plt.show()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3821/2376559692.py in <cell line: 2>()
          1 # To do this we can plot the ‘normal_velocities’ variable.
    ----> 2 cross_velocity_mean = tran_f.data_cross_tran_flow.normal_velocities.mean(dim="t_dim")
          3 plt.figure()
          4 cross_velocity_mean.rolling(r_dim=2).mean().plot.pcolormesh(yincrease=False, y="depth_0", cbar_kwargs={"label": "m/s"})
          5 plt.show()


    NameError: name 'tran_f' is not defined


### Plot volume transport across the transect


```python
# To do this we can plot the ‘normal_transports’ variable.
plt.figure()
cross_transport_mean = tran_f.data_cross_tran_flow.normal_transports.mean(dim="t_dim")
cross_transport_mean.rolling(r_dim=2).mean().plot()
plt.ylabel("Sv")
plt.show()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3821/2019429624.py in <cell line: 3>()
          1 # To do this we can plot the ‘normal_transports’ variable.
          2 plt.figure()
    ----> 3 cross_transport_mean = tran_f.data_cross_tran_flow.normal_transports.mean(dim="t_dim")
          4 cross_transport_mean.rolling(r_dim=2).mean().plot()
          5 plt.ylabel("Sv")


    NameError: name 'tran_f' is not defined



    <Figure size 640x480 with 0 Axes>

