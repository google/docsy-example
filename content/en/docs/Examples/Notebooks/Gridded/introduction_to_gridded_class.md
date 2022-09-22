---
    title: "Introduction to gridded class"
    linkTitle: "Introduction to gridded class"
    weight: 5

    description: >
        Introduction to gridded class example.
---
An introduction to the Gridded class. Loading variables and grid information.

This is designed to be a brief introduction to the Gridded class including:
    1. Creation of a Gridded object
    2. Loading data into the Gridded object.
    3. Combining Gridded output and Gridded domain data.
    4. Interrogating the Gridded object.
    5. Basic manipulation ans subsetting
    6. Looking at the data with matplotlib
    
    
### Loading and Interrogating

Begin by importing COAsT and define some file paths for NEMO output data and a NEMO domain, as an example of model data suitable for the Gridded object.


```python
import coast
import matplotlib.pyplot as plt
import datetime
import numpy as np

# Define some file paths
root = "./"
dn_files = root + "./example_files/"

fn_nemo_dat = dn_files + "coast_example_nemo_data.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
fn_config_t_grid = root + "./config/example_nemo_grid_t.json"
```

We can create a new Gridded object by simple calling `coast.Gridded()`. By passing this a NEMO data file and a NEMO domain file, COAsT will combine the two into a single xarray dataset within the Gridded object. Each individual Gridded object should be for a specified NEMO grid type, which is specified in a configuration file which is also passed as an argument. The Dask library is switched on by default, chunking can be specified in the configuration file.


```python
nemo_t = coast.Gridded(fn_data = fn_nemo_dat, fn_domain = fn_nemo_dom, config=fn_config_t_grid)
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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/coast_example_nemo_data.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3716/2757720096.py in <cell line: 1>()
    ----> 1 nemo_t = coast.Gridded(fn_data = fn_nemo_dat, fn_domain = fn_nemo_dom, config=fn_config_t_grid)
    

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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/coast_example_nemo_data.nc'


Our new Gridded object `nemo_t` contains a variable called dataset, which holds information on the two files we passed. Let’s have a look at this:


```python
#nemo_t.dataset # uncomment to print data object summary
```

This is an xarray dataset, which has all the information on netCDF style structures. You can see dimensions, coordinates and data variables. At the moment, none of the actual data is loaded to memory and will remain that way until it needs to be accessed.

Along with temperature (which has been renamed from votemper) a number of other things have happen under the hood:

1. The dimensions have been renamed to `t_dim`, `x_dim`, `y_dim`, `z_dim`
2. The coordinates have been renamed to `time`, `longitude`, `latitude` and `depth_0`. These are the coordinates for this grid (the t-grid). Also `depth_0` has been calculated as the 3D depth array at time zero.
3. The variables `e1`, `e2` and `e3_0` have been created. These are the metrics for the t-grid in the x-dim, y-dim and z_dim (at time zero) directions.

So we see that the Gridded class has standardised some variable names and created an object based on this discretisation grid by combining the appropriate grid information with all the variables on that grid.

We can interact with this as an xarray Dataset object. So to extract a specific variable (say temperature):


```python
ssh = nemo_t.dataset.ssh
#ssh # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3716/947344433.py in <cell line: 1>()
    ----> 1 ssh = nemo_t.dataset.ssh
          2 #ssh # uncomment to print data object summary


    NameError: name 'nemo_t' is not defined


Or as a numpy array:


```python
ssh_np = ssh.values
#ssh_np.shape # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3716/3198598826.py in <cell line: 1>()
    ----> 1 ssh_np = ssh.values
          2 #ssh_np.shape # uncomment to print data object summary


    NameError: name 'ssh' is not defined


Then lets plot up a single time snapshot of ssh using matplotlib:


```python
plt.pcolormesh(nemo_t.dataset.longitude, nemo_t.dataset.latitude, nemo_t.dataset.ssh[0])
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3716/1959159628.py in <cell line: 1>()
    ----> 1 plt.pcolormesh(nemo_t.dataset.longitude, nemo_t.dataset.latitude, nemo_t.dataset.ssh[0])
    

    NameError: name 'nemo_t' is not defined


### Some Manipulation

There are currently some basic subsetting routines for Gridded objects, to cut out specified regions of data. Fundamentally, this can be done using xarray’s isel or sel routines to index the data. In this case, the Gridded object will pass arguments straight through to `xarray.isel`.

Lets get the indices of all model points within 111km km of (5W, 55N):


```python
ind_y, ind_x = nemo_t.subset_indices_by_distance(centre_lon=-5, centre_lat=55, radius=111)
#ind_x.shape # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3716/3199558563.py in <cell line: 1>()
    ----> 1 ind_y, ind_x = nemo_t.subset_indices_by_distance(centre_lon=-5, centre_lat=55, radius=111)
          2 #ind_x.shape # uncomment to print data object summary


    NameError: name 'nemo_t' is not defined


Now create a new, smaller subsetted Gridded object by passing those indices to `isel`.


```python
nemo_t_subset = nemo_t.isel(x_dim=ind_x, y_dim=ind_y)
#nemo_t_subset.dataset # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3716/1606248965.py in <cell line: 1>()
    ----> 1 nemo_t_subset = nemo_t.isel(x_dim=ind_x, y_dim=ind_y)
          2 #nemo_t_subset.dataset # uncomment to print data object summary


    NameError: name 'nemo_t' is not defined


Alternatively, xarray.isel can be applied directly to the `xarray.Dataset` object.
A longitude/latitude box of data can also be extracted using `Gridded.subset_indices()`.

### Plotting example for NEMO-ERSEM biogechemical variables

Import COAsT, define some file paths for NEMO-ERSEM output data and a NEMO domain, and read/load your NEMO-ERSEM data into a gridded object, example:


```python
import coast
import matplotlib.pyplot as plt

# Define some file paths
root = "./"
dn_files = root + "./example_files/"

fn_bgc_dat = dn_files + "coast_example_SEAsia_BGC_1990.nc"
fn_bgc_dom = dn_files + "coast_example_domain_SEAsia.nc"
fn_config_bgc_grid = root + "./config/example_nemo_bgc.json"

nemo_bgc = coast.Gridded(fn_data = fn_bgc_dat, fn_domain = fn_bgc_dom, config=fn_config_bgc_grid)
#nemo_bgc.dataset # uncomment to print data object summary
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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/coast_example_SEAsia_BGC_1990.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3716/457899006.py in <cell line: 12>()
         10 fn_config_bgc_grid = root + "./config/example_nemo_bgc.json"
         11 
    ---> 12 nemo_bgc = coast.Gridded(fn_data = fn_bgc_dat, fn_domain = fn_bgc_dom, config=fn_config_bgc_grid)
         13 #nemo_bgc.dataset # uncomment to print data object summary


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/gridded/example_files/coast_example_SEAsia_BGC_1990.nc'


As an example plot a snapshot of dissolved inorganic carbon at the sea surface


```python
fig = plt.figure()
plt.pcolormesh(
    nemo_bgc.dataset.longitude,
    nemo_bgc.dataset.latitude,
    nemo_bgc.dataset.dic.isel(t_dim=0).isel(z_dim=0),
    cmap="RdYlBu_r",
    vmin=1600,
    vmax=2080,
)
plt.colorbar()
plt.title("DIC, mmol/m^3")
plt.xlabel("longitude")
plt.ylabel("latitude")
plt.show()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3716/2498690501.py in <cell line: 2>()
          1 fig = plt.figure()
          2 plt.pcolormesh(
    ----> 3     nemo_bgc.dataset.longitude,
          4     nemo_bgc.dataset.latitude,
          5     nemo_bgc.dataset.dic.isel(t_dim=0).isel(z_dim=0),


    NameError: name 'nemo_bgc' is not defined



    <Figure size 640x480 with 0 Axes>



```python

```
