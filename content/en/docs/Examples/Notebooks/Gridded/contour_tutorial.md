---
    title: "Contour tutorial"
    linkTitle: "Contour tutorial"
    weight: 5

    description: >
        Contour tutorial example.
---
Contour subsetting (a vertical slice of data along a contour).

This is a demonstration script for using the Contour class in the COAsT
package. This object has strict data formatting requirements, which are
outlined in contour.py.

The code is taken directly from `unit_tesing/unit_test.py`

In this tutorial we take a look the following Isobath Contour Methods:

    a. Extract isbath contour between two points
    b. Plot contour on map
    c. Calculate pressure along contour
    d. Calculate flow across contour
    e. Calculate pressure gradient driven flow across contour


### Load packages and define some file paths.


```python
import coast
import matplotlib.pyplot as plt

# Define some file paths
root = "./"
dn_files = root + "./example_files/"

fn_nemo_dat_t = dn_files + "nemo_data_T_grid.nc"
fn_nemo_dat_u = dn_files + "nemo_data_U_grid.nc"
fn_nemo_dat_v = dn_files + "nemo_data_V_grid.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
# Configuration files describing the data files
fn_config_t_grid = root + "./config/example_nemo_grid_t.json"
fn_config_f_grid = root + "./config/example_nemo_grid_f.json"
fn_config_u_grid = root + "./config/example_nemo_grid_u.json"
fn_config_v_grid = root + "./config/example_nemo_grid_v.json"
```


### Extract isobath contour between two points and create contour object.


Create a gridded object with the grid only.


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

    /tmp/ipykernel_3689/3673778941.py in <cell line: 1>()
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


Then create a contour object on the 200m isobath.


```python
contours, no_contours = coast.Contour.get_contours(nemo_f, 200)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3689/2066080525.py in <cell line: 1>()
    ----> 1 contours, no_contours = coast.Contour.get_contours(nemo_f, 200)
    

    NameError: name 'nemo_f' is not defined


Extract the indices for the contour in a specified box.


```python
y_ind, x_ind, contour = coast.Contour.get_contour_segment(nemo_f, contours[0], [50, -10], [60, 3])
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3689/2859757133.py in <cell line: 1>()
    ----> 1 y_ind, x_ind, contour = coast.Contour.get_contour_segment(nemo_f, contours[0], [50, -10], [60, 3])
    

    NameError: name 'nemo_f' is not defined


Extract the contour for the specified indices.


```python
cont_f = coast.ContourF(nemo_f, y_ind, x_ind, 200)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3689/3551178965.py in <cell line: 1>()
    ----> 1 cont_f = coast.ContourF(nemo_f, y_ind, x_ind, 200)
    

    NameError: name 'nemo_f' is not defined


### Plot contour on map


```python
plt.figure()
coast.Contour.plot_contour(nemo_f, contour)
plt.show()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3689/2810690408.py in <cell line: 2>()
          1 plt.figure()
    ----> 2 coast.Contour.plot_contour(nemo_f, contour)
          3 plt.show()


    NameError: name 'nemo_f' is not defined



    <Figure size 640x480 with 0 Axes>



### Calculate pressure along contour.


Repeat the above procedure but on t-points.


```python
nemo_t = coast.Gridded(fn_data=fn_nemo_dat_t, fn_domain=fn_nemo_dom, config=fn_config_t_grid)
contours, no_contours = coast.Contour.get_contours(nemo_t, 200)
y_ind, x_ind, contour = coast.Contour.get_contour_segment(nemo_t, contours[0], [50, -10], [60, 3])
cont_t = coast.ContourT(nemo_t, y_ind, x_ind, 200)
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

    /tmp/ipykernel_3689/1812485151.py in <cell line: 1>()
    ----> 1 nemo_t = coast.Gridded(fn_data=fn_nemo_dat_t, fn_domain=fn_nemo_dom, config=fn_config_t_grid)
          2 contours, no_contours = coast.Contour.get_contours(nemo_t, 200)
          3 y_ind, x_ind, contour = coast.Contour.get_contour_segment(nemo_t, contours[0], [50, -10], [60, 3])
          4 cont_t = coast.ContourT(nemo_t, y_ind, x_ind, 200)


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


Now contruct pressure along this contour segment.


```python
cont_t.construct_pressure(1027)

# This creates ``cont_t.data_contour.pressure_s`` and ``cont_t.data_contour.pressure_h_zlevels`` fields.
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3689/4263640221.py in <cell line: 1>()
    ----> 1 cont_t.construct_pressure(1027)
          2 
          3 # This creates ``cont_t.data_contour.pressure_s`` and ``cont_t.data_contour.pressure_h_zlevels`` fields.


    NameError: name 'cont_t' is not defined



### Calculate flow across contour.

Create the contour segement on f-points again.


```python
nemo_f = coast.Gridded(fn_domain=fn_nemo_dom, config=fn_config_f_grid)
nemo_u = coast.Gridded(fn_data=fn_nemo_dat_u, fn_domain=fn_nemo_dom, config=fn_config_u_grid)
nemo_v = coast.Gridded(fn_data=fn_nemo_dat_v, fn_domain=fn_nemo_dom, config=fn_config_v_grid)
contours, no_contours = coast.Contour.get_contours(nemo_f, 200)
y_ind, x_ind, contour = coast.Contour.get_contour_segment(nemo_f, contours[0], [50, -10], [60, 3])
cont_f = coast.ContourF(nemo_f, y_ind, x_ind, 200)
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

    /tmp/ipykernel_3689/3841125001.py in <cell line: 1>()
    ----> 1 nemo_f = coast.Gridded(fn_domain=fn_nemo_dom, config=fn_config_f_grid)
          2 nemo_u = coast.Gridded(fn_data=fn_nemo_dat_u, fn_domain=fn_nemo_dom, config=fn_config_u_grid)
          3 nemo_v = coast.Gridded(fn_data=fn_nemo_dat_v, fn_domain=fn_nemo_dom, config=fn_config_v_grid)
          4 contours, no_contours = coast.Contour.get_contours(nemo_f, 200)
          5 y_ind, x_ind, contour = coast.Contour.get_contour_segment(nemo_f, contours[0], [50, -10], [60, 3])


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


Calculate the flow across the contour, pass u- and v- gridded velocity objects.


```python
cont_f.calc_cross_contour_flow(nemo_u, nemo_v)

# This creates fields ``cont_f.data_cross_flow.normal_velocities`` and
## ``cont_f.data_cross_flow.depth_integrated_normal_transport``
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3689/1562466825.py in <cell line: 1>()
    ----> 1 cont_f.calc_cross_contour_flow(nemo_u, nemo_v)
          2 
          3 # This creates fields ``cont_f.data_cross_flow.normal_velocities`` and
          4 ## ``cont_f.data_cross_flow.depth_integrated_normal_transport``


    NameError: name 'cont_f' is not defined



### Calculate pressure gradient driven flow across contour.
                                                                    

The "calc_geostrophic_flow()" operates on f-grid objects and requires configuration files for the u- and v- grids.


```python
cont_f.calc_geostrophic_flow(nemo_t, config_u=fn_config_u_grid, config_v=fn_config_v_grid, ref_density=1027)

"""
 This constructs:
    cont_f.data_cross_flow.normal_velocity_hpg
    cont_f.data_cross_flow.normal_velocity_spg
    cont_f.data_cross_flow.transport_across_AB_hpg
    cont_f.data_cross_flow.transport_across_AB_spg
"""
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3689/580794929.py in <cell line: 1>()
    ----> 1 cont_f.calc_geostrophic_flow(nemo_t, config_u=fn_config_u_grid, config_v=fn_config_v_grid, ref_density=1027)
          2 
          3 """
          4  This constructs:
          5     cont_f.data_cross_flow.normal_velocity_hpg


    NameError: name 'cont_f' is not defined



```python

```
