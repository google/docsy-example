---
    title: "Wod bgc ragged example"
    linkTitle: "Wod bgc ragged example"
    weight: 5

    description: >
        Wod bgc ragged example example.
---
An example of using COAsT to analysis observational profile data alongside gridded NEMO data. 

### Load modules


```python
import coast
import glob  # For getting file paths
import gsw
import matplotlib.pyplot as plt
import datetime
import numpy as np
import xarray as xr
import coast._utils.general_utils as general_utils
import scipy as sp

# ====================== UNIV PARAMS ===========================
path_examples = "./example_files/"
path_config = "./config/"
```

### load and preprocess profile and model data


```python
fn_wod_var = path_examples + "WOD_example_ragged_standard_level.nc"
fn_wod_config = path_config + "example_wod_profiles.json"

wod_profile_1d = coast.Profile(config=fn_wod_config)
wod_profile_1d.read_wod(fn_wod_var)
```

    ./config/example_wod_profiles.json



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


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/WOD_example_ragged_standard_level.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3793/3246328479.py in <cell line: 5>()
          3 
          4 wod_profile_1d = coast.Profile(config=fn_wod_config)
    ----> 5 wod_profile_1d.read_wod(fn_wod_var)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/profile.py in read_wod(self, fn_wod, chunks)
        136             chunks (dict): chunks
        137         """
    --> 138         self.dataset = xr.open_dataset(fn_wod, chunks=chunks)
        139         self.apply_config_mappings()
        140 


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


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/profile/example_files/WOD_example_ragged_standard_level.nc'


Reshape into 2D.
Choose which observed variables you want.


```python
var_user_want = ["salinity", "temperature", "nitrate", "oxygen", "dic", "phosphate", "alkalinity"]
wod_profile = coast.Profile.reshape_2d(wod_profile_1d, var_user_want)
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3793/3107136859.py in <cell line: 2>()
          1 var_user_want = ["salinity", "temperature", "nitrate", "oxygen", "dic", "phosphate", "alkalinity"]
    ----> 2 wod_profile = coast.Profile.reshape_2d(wod_profile_1d, var_user_want)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/profile.py in reshape_2d(self, var_user_want)
        699 
        700         # find maximum z levels in any of the profiles
    --> 701         d_max = int(np.max(self.dataset.z_row_size.values))
        702         # number of profiles
        703         prof_size = self.dataset.z_row_size.shape[0]


    AttributeError: 'NoneType' object has no attribute 'z_row_size'


Keep subset.


```python
wod_profile_sub = wod_profile.subset_indices_lonlat_box(lonbounds=[90, 120], latbounds=[-5, 5])

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3793/1812791146.py in <cell line: 1>()
    ----> 1 wod_profile_sub = wod_profile.subset_indices_lonlat_box(lonbounds=[90, 120], latbounds=[-5, 5])
    

    NameError: name 'wod_profile' is not defined



```python
#wod_profile_sub.dataset # uncomment to print data object summary
```

SEAsia read BGC.
Note in this simple test nemo data are only for 3 months from 1990 so the comparisons are not going to be correct but just as a demo.


```python
fn_seasia_domain = path_examples + "coast_example_domain_SEAsia.nc"
fn_seasia_config_bgc = path_config + "example_nemo_bgc.json"
fn_seasia_var = path_examples + "coast_example_SEAsia_BGC_1990.nc"

seasia_bgc = coast.Gridded(
    fn_data=fn_seasia_var, fn_domain=fn_seasia_domain, config=fn_seasia_config_bgc, multiple=True
)
```


    ---------------------------------------------------------------------------

    OSError                                   Traceback (most recent call last)

    /tmp/ipykernel_3793/498999307.py in <cell line: 5>()
          3 fn_seasia_var = path_examples + "coast_example_SEAsia_BGC_1990.nc"
          4 
    ----> 5 seasia_bgc = coast.Gridded(
          6     fn_data=fn_seasia_var, fn_domain=fn_seasia_domain, config=fn_seasia_config_bgc, multiple=True
          7 )


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
         71             self.load_dataset(file_or_dir.open_dataset(chunks=chunks))
         72         elif multiple:
    ---> 73             self.load_multiple(file_or_dir, chunks)
         74         else:
         75             self.load_single(file_or_dir, chunks)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/coast.py in load_multiple(self, directory_to_files, chunks)
         96         """
         97         info(f"Loading a directory ({directory_to_files}) for {get_slug(self)}")
    ---> 98         self.dataset = xr.open_mfdataset(directory_to_files, chunks=chunks, parallel=True, combine="by_coords")
         99 
        100     def load_dataset(self, dataset: xr.Dataset):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/api.py in open_mfdataset(paths, chunks, concat_dim, compat, preprocess, engine, data_vars, coords, combine, parallel, join, attrs_file, combine_attrs, **kwargs)
        871 
        872     if not paths:
    --> 873         raise OSError("no files to open")
        874 
        875     if combine == "nested":


    OSError: no files to open


Domain file does not have mask so this is just a trick.


```python
seasia_bgc.dataset["landmask"] = seasia_bgc.dataset.bottom_level == 0
seasia_bgc.dataset = seasia_bgc.dataset.rename({"depth_0": "depth"})
model_profiles = wod_profile_sub.obs_operator(seasia_bgc)
#model_profiles.dataset # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3793/3830167598.py in <cell line: 1>()
    ----> 1 seasia_bgc.dataset["landmask"] = seasia_bgc.dataset.bottom_level == 0
          2 seasia_bgc.dataset = seasia_bgc.dataset.rename({"depth_0": "depth"})
          3 model_profiles = wod_profile_sub.obs_operator(seasia_bgc)
          4 #model_profiles.dataset # uncomment to print data object summary


    NameError: name 'seasia_bgc' is not defined


Remove any points that are far from model.


```python
too_far = 5
keep_indices = model_profiles.dataset.interp_dist <= too_far
model_profiles = model_profiles.isel(id_dim=keep_indices)
wod_profile = wod_profile_sub.isel(id_dim=keep_indices)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3793/3586994633.py in <cell line: 2>()
          1 too_far = 5
    ----> 2 keep_indices = model_profiles.dataset.interp_dist <= too_far
          3 model_profiles = model_profiles.isel(id_dim=keep_indices)
          4 wod_profile = wod_profile_sub.isel(id_dim=keep_indices)


    NameError: name 'model_profiles' is not defined



```python
#wod_profile.dataset # uncomment to print data object summary
```

### Plot profiles
Transform observed DIC from mmol/l to mmol C/ m^3 that the model has.


```python
fig = plt.figure()
plt.plot(1000 * wod_profile.dataset.dic[8, :], wod_profile.dataset.depth[8, :], linestyle="", marker="o")
plt.plot(model_profiles.dataset.dic[8, :], model_profiles.dataset.depth[:, 8], linestyle="", marker="o")
plt.ylim([2500, 0])
plt.title("DIC vs depth")
plt.show()

fig = plt.figure()
plt.plot(wod_profile.dataset.oxygen[8, :], wod_profile.dataset.depth[8, :], linestyle="", marker="o")
plt.plot(model_profiles.dataset.oxygen[8, :], model_profiles.dataset.depth[:, 8], linestyle="", marker="o")
plt.ylim([2500, 0])
plt.title("Oxygen vs depth")
plt.show()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3793/3243809329.py in <cell line: 2>()
          1 fig = plt.figure()
    ----> 2 plt.plot(1000 * wod_profile.dataset.dic[8, :], wod_profile.dataset.depth[8, :], linestyle="", marker="o")
          3 plt.plot(model_profiles.dataset.dic[8, :], model_profiles.dataset.depth[:, 8], linestyle="", marker="o")
          4 plt.ylim([2500, 0])
          5 plt.title("DIC vs depth")


    NameError: name 'wod_profile' is not defined



    <Figure size 640x480 with 0 Axes>


### Perform profile analysis to evaluate differences
Interpolate seasia to profile depths, using `ProfileAnalysis` class.


```python
reference_depths = wod_profile.dataset.depth[20, :].values
model_profiles.dataset = model_profiles.dataset[["dic"]] / 1000

pa = coast.ProfileAnalysis()
model_interpolated = pa.interpolate_vertical(model_profiles, wod_profile)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3793/3472810794.py in <cell line: 1>()
    ----> 1 reference_depths = wod_profile.dataset.depth[20, :].values
          2 model_profiles.dataset = model_profiles.dataset[["dic"]] / 1000
          3 
          4 pa = coast.ProfileAnalysis()
          5 model_interpolated = pa.interpolate_vertical(model_profiles, wod_profile)


    NameError: name 'wod_profile' is not defined


Calculate differences.


```python
differences = pa.difference(model_interpolated, wod_profile)
#differences.dataset.load() # uncomment to print data object summary
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3793/4076289521.py in <cell line: 1>()
    ----> 1 differences = pa.difference(model_interpolated, wod_profile)
          2 #differences.dataset.load() # uncomment to print data object summary


    NameError: name 'pa' is not defined



```python

```
