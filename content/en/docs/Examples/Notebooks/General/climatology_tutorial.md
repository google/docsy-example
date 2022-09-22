---
    title: "Climatology tutorial"
    linkTitle: "Climatology tutorial"
    weight: 5

    description: >
        Climatology tutorial example.
---
This demonstration has two parts:

1)  Climatology.make_climatology():
    This demonstration uses the COAsT package to calculate a climatological mean of an
    input dataset at a desired output frequency. Output can be written straight
    to file.

2) Climatology.make_multiyear_climatology():
    This demonstrations uses the COAsT package to calculate a climatological mean of an
    input dataset at a desired output frequency, over multiple years, but will work with single year datasets too.

COAsT and xarray should preserve any lazy loading and chunking. If defined
properly in the read function, memory issues can be avoided and parallel
processes will automatically be used.


```python
import coast
```

### Usage of coast.Climatology.make_climatology().

Calculates mean over a given period of time. This doesn't take different years into account, unless using the
'years' frequency.


```python
root = "./"
# Paths to a single or multiple data files.
dn_files = root + "./example_files/"
fn_nemo_dat = dn_files + "coast_example_nemo_data.nc"
fn_nemo_config = root + "./config/example_nemo_grid_t.json"
# Set path for domain file if required.
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
# Define output filepath (optional: None or str)
fn_out = None

# Read in multiyear data (This example uses NEMO data from a single file.)
nemo_data = coast.Gridded(fn_data=fn_nemo_dat,
                          fn_domain=fn_nemo_dom,
                          config=fn_nemo_config,
                          ).dataset

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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/general/example_files/coast_example_nemo_data.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3694/3320103903.py in <cell line: 12>()
         10 
         11 # Read in multiyear data (This example uses NEMO data from a single file.)
    ---> 12 nemo_data = coast.Gridded(fn_data=fn_nemo_dat,
         13                           fn_domain=fn_nemo_dom,
         14                           config=fn_nemo_config,


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/general/example_files/coast_example_nemo_data.nc'


Calculate the climatology for temperature and sea surface height (ssh) as an example:


```python
# Select specific data variables.
data = nemo_data[["temperature", "ssh"]]

# Define frequency -- Any xarray time string: season, month, etc
climatology_frequency = "month"

# Calculate the climatology and write to file.
clim = coast.Climatology()
clim_mean = clim.make_climatology(data, climatology_frequency, fn_out=fn_out)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3694/3130387092.py in <cell line: 2>()
          1 # Select specific data variables.
    ----> 2 data = nemo_data[["temperature", "ssh"]]
          3 
          4 # Define frequency -- Any xarray time string: season, month, etc
          5 climatology_frequency = "month"


    NameError: name 'nemo_data' is not defined


Below shows the structure of a dataset returned, containing 1 month worth of meaned temperature and sea surface height data:


```python
#clim_mean  # uncomment to print data object summary
```

### Usage of coast.Climatology.multiyear_averages().

Calculates the mean over a specified period and groups the data by year-period. Here a fully working example is not available as multi-year example data is not in the `example_files`. However a working example using synthetic data is given in: `tests/test_climatology.py`. This method is designed to be compatible with multi-year datasets, but will work with single year datasets too.

```
# Paths to a single or multiple data files.
fn_nemo_data = "/path/to/nemo/*.nc"
# Set path for domain file if required.
fn_nemo_domain = None
# Set path to configuration file
fn_nemo_config = "/path/to/nemo/*.json"

# Read in multiyear data (This example uses NEMO data from multiple datafiles.)
nemo_data = coast.Gridded(fn_data=fn_nemo_data,
                          fn_domain=fn_nemo_domain,
                          config=fn_nemo_config,
                          multiple=True).dataset

```

Now calculate temperature and ssh means of each season across multiple years for specified data, using seasons module to specify time period.

```
from coast._utils import seasons

# Select specific data variables.
data = nemo_data[["temperature", "ssh"]]

clim = coast.Climatology()
# SPRING, SUMMER, AUTUMN, WINTER, ALL are valid values for seasons.
clim_multiyear = clim.multiyear_averages(data, seasons.ALL, time_var='time', time_dim='t_dim')

# Or explicitly defining specific month periods.
# A list of tuples defining start and end month integers. The start months should be in chronological order.
# (you may need to read/load the data again if it gives an error)

month_periods = [(1,2), (12,2)] # Specifies January -> February and December -> February for each year of data. 
clim_multiyear = clim.multiyear_averages(data, month_periods , time_var='time', time_dim='t_dim')
```


```python

```
