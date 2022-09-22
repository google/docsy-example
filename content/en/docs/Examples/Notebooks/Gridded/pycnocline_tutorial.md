---
    title: "Pycnocline tutorial"
    linkTitle: "Pycnocline tutorial"
    weight: 5

    description: >
        Pycnocline tutorial example.
---
A demonstration of pycnocline depth and thickness diagnostics. The first and second depth moments of stratification are computed as proxies for pycnocline depth and thickness, suitable for a nearly two-layer fluid.

Note that in the AMM7 example data the plots are not particularly spectacular as the internal tide is poorly resolved at 7km.

### Relevant imports and filepath configuration


```python
import coast
import numpy as np
import os
import matplotlib.pyplot as plt
import matplotlib.colors as colors  # colormap fiddling
```


```python
# set some paths
root = "./"
dn_files = root + "./example_files/"
fn_nemo_grid_t_dat = dn_files + "nemo_data_T_grid_Aug2015.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
config_t = root + "./config/example_nemo_grid_t.json"
config_w = root + "./config/example_nemo_grid_w.json"
```

### Loading data


```python
# Create a Gridded object and load in the data:

nemo_t = coast.Gridded(fn_nemo_grid_t_dat, fn_nemo_dom, config=config_t)
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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/nemo_data_T_grid_Aug2015.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3759/1494523395.py in <cell line: 3>()
          1 # Create a Gridded object and load in the data:
          2 
    ----> 3 nemo_t = coast.Gridded(fn_nemo_grid_t_dat, fn_nemo_dom, config=config_t)
    

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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/nemo_data_T_grid_Aug2015.nc'



```python
#nemo_t.dataset # uncomment to print data object summary
```


```python
# The stratification variables are computed as centred differences of the t-grid variables. 
# These will become w-grid variables. So, create an empty w-grid object, to store stratification. 
# Note how we do not pass a NEMO data file for this load.
nemo_w = coast.Gridded(fn_domain=fn_nemo_dom, config=config_w)

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

    /tmp/ipykernel_3759/403710668.py in <cell line: 4>()
          2 # These will become w-grid variables. So, create an empty w-grid object, to store stratification.
          3 # Note how we do not pass a NEMO data file for this load.
    ----> 4 nemo_w = coast.Gridded(fn_domain=fn_nemo_dom, config=config_w)
    

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


### Subset the domain

We are not interested in the whole doman so it is computationally efficient to subset the data for the region of interest. Here we will look at the North Sea between (51N: 62N) and (-4E:15E).
We will great subset objects for both the t- and w-grids:


```python
ind_2d = nemo_t.subset_indices(start=[51,-4], end=[62,15])
nemo_nwes_t = nemo_t.isel(y_dim=ind_2d[0], x_dim=ind_2d[1]) #nwes = northwest european shelf
ind_2d = nemo_w.subset_indices(start=[51,-4], end=[62,15])
nemo_nwes_w = nemo_w.isel(y_dim=ind_2d[0], x_dim=ind_2d[1]) #nwes = northwest european shelf
#nemo_nwes_t.dataset # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3759/113236151.py in <cell line: 1>()
    ----> 1 ind_2d = nemo_t.subset_indices(start=[51,-4], end=[62,15])
          2 nemo_nwes_t = nemo_t.isel(y_dim=ind_2d[0], x_dim=ind_2d[1]) #nwes = northwest european shelf
          3 ind_2d = nemo_w.subset_indices(start=[51,-4], end=[62,15])
          4 nemo_nwes_w = nemo_w.isel(y_dim=ind_2d[0], x_dim=ind_2d[1]) #nwes = northwest european shelf
          5 #nemo_nwes_t.dataset # uncomment to print data object summary


    NameError: name 'nemo_t' is not defined


### Diagnostic calculations and plotting 

We can use a COAsT method to construct the in-situ density:



```python
nemo_nwes_t.construct_density( eos='EOS10' )

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3759/672651133.py in <cell line: 1>()
    ----> 1 nemo_nwes_t.construct_density( eos='EOS10' )
    

    NameError: name 'nemo_nwes_t' is not defined


Then we construct stratification using a COAsT method to take the vertical derivative. Noting that the inputs are on t-pts and the outputs are on w-pt


```python
nemo_nwes_w = nemo_nwes_t.differentiate( 'density', dim='z_dim', out_var_str='rho_dz', out_obj=nemo_nwes_w ) # --> sci_nwes_w.rho_dz

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3759/1923360871.py in <cell line: 1>()
    ----> 1 nemo_nwes_w = nemo_nwes_t.differentiate( 'density', dim='z_dim', out_var_str='rho_dz', out_obj=nemo_nwes_w ) # --> sci_nwes_w.rho_dz
    

    NameError: name 'nemo_nwes_t' is not defined


This has created a variable called `nemo_nwes_w.rho_dz`.

###  Create internal tide diagnostics

We can now use the GriddedStratification class to construct the first and second moments (over depth) of density. In the limit of an idealised two-layer fluid these converge to the depth and thickness of the interface. I.e. the pycnocline depth and thickness respectively.


```python

strat = coast.GriddedStratification(nemo_nwes_t)

#%%  Construct pycnocline variables: depth and thickness
strat.construct_pycnocline_vars( nemo_nwes_t, nemo_nwes_w )
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3759/389065460.py in <cell line: 1>()
    ----> 1 strat = coast.GriddedStratification(nemo_nwes_t)
          2 
          3 #%%  Construct pycnocline variables: depth and thickness
          4 strat.construct_pycnocline_vars( nemo_nwes_t, nemo_nwes_w )


    NameError: name 'nemo_nwes_t' is not defined


### Plotting data

Finally we plot pycnocline variables (depth and thickness) using an GriddedStratification method:


```python
strat.quick_plot()

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3759/1260159304.py in <cell line: 1>()
    ----> 1 strat.quick_plot()
    

    NameError: name 'strat' is not defined

