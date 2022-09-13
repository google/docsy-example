---
    title: "Eof tutorial"
    linkTitle: "Eof tutorial"
    weight: 5

    description: >
        Eof tutorial example.
---
Using COAsT to compute the Empirical Orthogonal Functions (EOFs) of your data

### Relevant imports and filepath configuration


```python
# Begin by importing coast and other packages
import coast
import xarray as xr
import matplotlib.pyplot as plt

# Define some file paths
root = "./"
dn_files = root + "./example_files/"

fn_nemo_dat_t = dn_files + "nemo_data_T_grid.nc"
fn_nemo_dom   = dn_files + "COAsT_example_NEMO_domain.nc"
fn_nemo_config = root + "./config/example_nemo_grid_t.json"
```

### Loading data


```python
# Load data variables that are on the NEMO t-grid

nemo_t = coast.Gridded( fn_data = fn_nemo_dat_t, fn_domain = fn_nemo_dom, config = fn_nemo_config )
```


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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/example_scripts/notebooks/runnable_notebooks/example_files/COAsT_example_NEMO_domain.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    Cell In [2], line 3
          1 # Load data variables that are on the NEMO t-grid
    ----> 3 nemo_t = coast.Gridded( fn_data = fn_nemo_dat_t, fn_domain = fn_nemo_dom, config = fn_nemo_config )


    File /usr/local/lib/python3.8/site-packages/coast/data/gridded.py:49, in Gridded.__init__(self, fn_data, fn_domain, multiple, config, workers, threads, memory_limit_per_worker, **kwargs)
         47 self.config = ConfigParser(config).config
         48 if self.config.chunks:
    ---> 49     self._setup_grid_obj(self.config.chunks, multiple, **kwargs)
         50 else:
         51     self._setup_grid_obj(None, multiple, **kwargs)


    File /usr/local/lib/python3.8/site-packages/coast/data/gridded.py:84, in Gridded._setup_grid_obj(self, chunks, multiple, **kwargs)
         82 else:
         83     self.filename_domain = self.fn_domain  # store domain fileanme
    ---> 84     dataset_domain = self.load_domain(self.fn_domain, chunks)
         86     # Define extra domain attributes using kwargs dictionary
         87     # This is a bit of a placeholder. Some domain/nemo files will have missing variables
         88     for key, value in kwargs.items():


    File /usr/local/lib/python3.8/site-packages/coast/data/gridded.py:125, in Gridded.load_domain(self, fn_domain, chunks)
        123 # Load xarray dataset
        124 info(f'Loading domain: "{fn_domain}"')
    --> 125 dataset_domain = xr.open_dataset(fn_domain)
        126 self.domain_loaded = True
        127 # Rename dimensions


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/example_scripts/notebooks/runnable_notebooks/example_files/COAsT_example_NEMO_domain.nc'


### Compute EOF

For a variable (or subset of a variable) with two spatial dimensions and one temporal dimension, i.e. (x,y,t), the EOFs, temporal projections and variance explained can be computed by calling the ‘eofs’ method, and passing in the ssh DataArray as an argument. For example, for the sea surface height field, we can do


```python
eof_data = coast.compute_eofs( nemo_t.dataset.ssh )
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [3], line 1
    ----> 1 eof_data = coast.compute_eofs( nemo_t.dataset.ssh )


    NameError: name 'nemo_t' is not defined


The method returns an xarray dataset that contains the EOFs, temporal projections and variance as DataArrays


```python
#eof_data  # uncomment to print data object summary
```

### Inspect EOFs
The variance explained of the first four modes is


```python
eof_data.variance.sel(mode=[1,2,3,4])
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [5], line 1
    ----> 1 eof_data.variance.sel(mode=[1,2,3,4])


    NameError: name 'eof_data' is not defined


### Plotting
And the EOFs and temporal projections can be quick plotted:


```python
eof_data.EOF.sel(mode=[1,2,3,4]).plot.pcolormesh(col='mode',col_wrap=2,x='longitude',y='latitude')
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [6], line 1
    ----> 1 eof_data.EOF.sel(mode=[1,2,3,4]).plot.pcolormesh(col='mode',col_wrap=2,x='longitude',y='latitude')


    NameError: name 'eof_data' is not defined



```python
eof_data.temporal_proj.sel(mode=[1,2,3,4]).plot(col='mode',col_wrap=2,x='time')
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [7], line 1
    ----> 1 eof_data.temporal_proj.sel(mode=[1,2,3,4]).plot(col='mode',col_wrap=2,x='time')


    NameError: name 'eof_data' is not defined


### Complex EOFs
The more exotic hilbert complex EOFs can also be computed to investigate the propagation of variability, for example:


```python
heof_data = coast.compute_hilbert_eofs( nemo_t.dataset.ssh )
#heof_data # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [8], line 1
    ----> 1 heof_data = coast.compute_hilbert_eofs( nemo_t.dataset.ssh )


    NameError: name 'nemo_t' is not defined


now with the modes expressed by their amplitude and phase, the spatial propagation of the variability can be examined through the EOF_phase.

