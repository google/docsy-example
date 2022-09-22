---
    title: "Analysis extract and compare"
    linkTitle: "Analysis extract and compare"
    weight: 5

    description: >
        Analysis extract and compare example.
---
This script demonstrates how to use the Profile and Gridded objects to extract model profiles and do some comparisons with observed profiles.
It will do a nearest neighbour extraction of model data (with time interpolation of your choice). It will then calculate differences between the model and obs and averaged profiles and errors into surface and bottom layers.

This script will result in five new files being written:
- 1. extracted_profiles: Model data on model levels extracted at obs locs
- 2. interpolated_profiles: Model data on ref depth level
- 3. interpolated_obs: Obs data on ref depth levels
- 4. profile_errors: Differences between interpolated_profiles and _obs
- 5. surface_data: Surface data and errors
- 6. bottom_data: Bottom data and errors

If you are dealing with very large datasets, you should take a look at the script `analysis_extract_and_compare_single_process_tutorial.ipynb`. This script demonstrates a single process that can be used to build a parallel scheme.

This script can be used with COAsT example data. Please set:  

fn_dom = path.join('./example_files', "coast_example_nemo_domain.nc")  
fn_dat = path.join('./example_files', "coast_example_nemo_data.nc")  
dn_out = "./example_files"  
fn_prof = path.join('./example_files', "coast_example_EN4_201008.nc")  
fn_cfg_nemo = path.join('./config', "example_nemo_grid_t.json")  
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")  


```python
import sys

# IF USING A DEVELOPMENT BRANCH OF COAST, ADD THE REPOSITORY TO PATH:
# sys.path.append('<PATH_TO_COAST_REPO>')
import coast
import xarray as xr
import numpy as np
import datetime
from dateutil.relativedelta import relativedelta
import os.path as path

print("Modules loaded", flush=True)

# Name of the run -- used mainly for naming output files
run_name = "co7"
```

    Modules loaded


Figure out what the date range is for this analysis process.


```python
start_date = datetime.datetime(2007, 1, 1)
end_date = datetime.datetime(2010, 12, 1)
print("Analysis Range: {0} -->> {1}".format(start_date.strftime("%Y%m%d"), end_date.strftime("%Y%m%d")), flush=True)
```

    Analysis Range: 20070101 -->> 20101201


Depth averaging settings.


```python
ref_depth = np.concatenate((np.arange(1, 100, 2), np.arange(100, 300, 5), np.arange(300, 1000, 50)))
surface_def = 5  # in metres
bottom_height = [10, 30, 100]  # Use bottom heights of 10m, 30m and 100m for...
bottom_thresh = [100, 500, np.inf]  # ...depths less than 100m, 500m and infinite
```

File paths (All) -- use format suggestions.


```python
"""
fn_dom = "<PATH_TO_NEMO_DOMAIN_FILE>"
fn_dat = "<PATH_TO_NEMO_DATA_FILE(S)>"  # .format(run_name, start_date.year)
dn_out = "<PATH_TO_OUTPUT_DIRECTORY>"  # .format(run_name)
fn_prof = "<PATH_TO_PROCESSED_EN4_DATA>"
fn_cfg_nemo = "<PATH_TO_COAST_GRIDDED_CONFIG_FILE>"
fn_cfg_prof = "<PATH_TO_CODE_PROFILE_CONFIG_FILE>"
"""

fn_dom = path.join('./example_files', "coast_example_nemo_domain.nc")  
fn_dat = path.join('./example_files', "coast_example_nemo_data.nc")  
dn_out = "./example_files"  
fn_prof = path.join('./example_files', "coast_example_en4_201008.nc")  
fn_cfg_nemo = path.join('./config', "example_nemo_grid_t.json")  
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")
```

CREATE NEMO OBJECT and read in NEMO data. Extract latitude and longitude array.


```python
print("Reading model data..", flush=True)
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config=fn_cfg_nemo)
lon = nemo.dataset.longitude.values.squeeze()
lat = nemo.dataset.latitude.values.squeeze()
print("NEMO object created", flush=True)
```

    Reading model data..



    ---------------------------------------------------------------------------

    OSError                                   Traceback (most recent call last)

    /tmp/ipykernel_3712/1681410080.py in <cell line: 2>()
          1 print("Reading model data..", flush=True)
    ----> 2 nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config=fn_cfg_nemo)
          3 lon = nemo.dataset.longitude.values.squeeze()
          4 lat = nemo.dataset.latitude.values.squeeze()
          5 print("NEMO object created", flush=True)


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


Extract time indices between start and end dates.


```python
nemo = nemo.time_slice(start_date, end_date)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/361660845.py in <cell line: 1>()
    ----> 1 nemo = nemo.time_slice(start_date, end_date)
    

    NameError: name 'nemo' is not defined


Create a landmask array -- important for obs_operator. We can get a landmask from bottom_level.


```python
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
print("Landmask calculated", flush=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/1356107197.py in <cell line: 1>()
    ----> 1 nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0
          2 nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
          3 print("Landmask calculated", flush=True)


    NameError: name 'nemo' is not defined


CREATE EN4 PROFILE OBJECT  
If you have not already processed the data:


```python
profile = coast.Profile(config=fn_cfg_prof)
profile.read_en4(fn_prof)
profile = profile.process_en4()
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

    /tmp/ipykernel_3712/1392213322.py in <cell line: 2>()
          1 profile = coast.Profile(config=fn_cfg_prof)
    ----> 2 profile.read_en4(fn_prof)
          3 profile = profile.process_en4()


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


If you have already processed then uncomment:  
profile = coast.Profile(dataset = xr.open_dataset(fn_prof, chunks={"id_dim": 10000}))


```python
print("Profile object created", flush=True)
```

    Profile object created


Slice out the Profile times.


```python
profile = profile.time_slice(start_date, end_date)
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3712/3896460870.py in <cell line: 1>()
    ----> 1 profile = profile.time_slice(start_date, end_date)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/profile.py in time_slice(self, date0, date1)
        814         """Return new Gridded object, indexed between dates date0 and date1"""
        815         dataset = self.dataset
    --> 816         t_ind = pd.to_datetime(dataset.time.values) >= date0
        817         dataset = dataset.isel(id_dim=t_ind)
        818         t_ind = pd.to_datetime(dataset.time.values) < date1


    AttributeError: 'NoneType' object has no attribute 'time'


Extract only the variables that we want.


```python
nemo.dataset = nemo.dataset[["temperature", "bathymetry", "bottom_level", "landmask"]]
profile.dataset = profile.dataset[["potential_temperature", "practical_salinity", "depth"]]
profile.dataset = profile.dataset.rename({"potential_temperature": "temperature", "practical_salinity": "salinity"})
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/1079215808.py in <cell line: 1>()
    ----> 1 nemo.dataset = nemo.dataset[["temperature", "bathymetry", "bottom_level", "landmask"]]
          2 profile.dataset = profile.dataset[["potential_temperature", "practical_salinity", "depth"]]
          3 profile.dataset = profile.dataset.rename({"potential_temperature": "temperature", "practical_salinity": "salinity"})


    NameError: name 'nemo' is not defined


Create Profile analysis object.


```python
profile_analysis = coast.ProfileAnalysis()
```

Interpolate model to obs using obs_operator().


```python
model_profiles = profile.obs_operator(nemo)
print("Obs_operator successful.", flush=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/2825540059.py in <cell line: 1>()
    ----> 1 model_profiles = profile.obs_operator(nemo)
          2 print("Obs_operator successful.", flush=True)


    NameError: name 'nemo' is not defined


Throw away profiles where the interpolation distance is larger than 5km.


```python
keep_indices = model_profiles.dataset.interp_dist <= 5
model_profiles = model_profiles.isel(id_dim=keep_indices)
profile = profile.isel(id_dim=keep_indices)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/1644419807.py in <cell line: 1>()
    ----> 1 keep_indices = model_profiles.dataset.interp_dist <= 5
          2 model_profiles = model_profiles.isel(id_dim=keep_indices)
          3 profile = profile.isel(id_dim=keep_indices)


    NameError: name 'model_profiles' is not defined


Load the profiles (careful with memory).


```python
profile.dataset.load()
print("Model interpolated to obs locations", flush=True)
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3712/4061683924.py in <cell line: 1>()
    ----> 1 profile.dataset.load()
          2 print("Model interpolated to obs locations", flush=True)


    AttributeError: 'NoneType' object has no attribute 'load'


Vertical Interpolation of model profiles to obs depths.


```python
model_profiles_interp = profile_analysis.interpolate_vertical(model_profiles, profile, interp_method="linear")
print("Model interpolated to obs depths", flush=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/690449501.py in <cell line: 1>()
    ----> 1 model_profiles_interp = profile_analysis.interpolate_vertical(model_profiles, profile, interp_method="linear")
          2 print("Model interpolated to obs depths", flush=True)


    NameError: name 'model_profiles' is not defined


Vertical interpolation of model profiles to reference depths.


```python
model_profiles_interp = profile_analysis.interpolate_vertical(model_profiles_interp, ref_depth)
model_profiles.dataset.to_netcdf(
    dn_out
    + "extracted_profiles_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
model_profiles_interp.dataset.to_netcdf(
    dn_out
    + "interpolated_profiles_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
print("Model interpolated to ref depths", flush=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/864913742.py in <cell line: 1>()
    ----> 1 model_profiles_interp = profile_analysis.interpolate_vertical(model_profiles_interp, ref_depth)
          2 model_profiles.dataset.to_netcdf(
          3     dn_out
          4     + "extracted_profiles_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
          5 )


    NameError: name 'model_profiles_interp' is not defined


Interpolation of obs profiles to reference depths.


```python
profile_interp = profile_analysis.interpolate_vertical(profile, ref_depth)
profile_interp.dataset.to_netcdf(
    dn_out + "interpolated_obs_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
print("Obs interpolated to reference depths", flush=True)
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3712/24140306.py in <cell line: 1>()
    ----> 1 profile_interp = profile_analysis.interpolate_vertical(profile, ref_depth)
          2 profile_interp.dataset.to_netcdf(
          3     dn_out + "interpolated_obs_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
          4 )
          5 print("Obs interpolated to reference depths", flush=True)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/diagnostics/profile_analysis.py in interpolate_vertical(cls, profile, new_depth, interp_method, print_progress)
        350 
        351         ds = profile.dataset
    --> 352         n_prof = ds.sizes["id_dim"]
        353         n_z = ds.sizes["z_dim"]
        354 


    AttributeError: 'NoneType' object has no attribute 'sizes'


Difference between Model and Obs.


```python
differences = profile_analysis.difference(profile_interp, model_profiles_interp)
differences.dataset.load()
differences.dataset.to_netcdf(
    dn_out + "profile_errors_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
print("Calculated errors and written", flush=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/3069574209.py in <cell line: 1>()
    ----> 1 differences = profile_analysis.difference(profile_interp, model_profiles_interp)
          2 differences.dataset.load()
          3 differences.dataset.to_netcdf(
          4     dn_out + "profile_errors_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
          5 )


    NameError: name 'profile_interp' is not defined


Surface Values and errors.


```python
model_profiles_surface = profile_analysis.depth_means(model_profiles, [0, surface_def])
obs_profiles_surface = profile_analysis.depth_means(profile, [0, surface_def])
surface_errors = profile_analysis.difference(obs_profiles_surface, model_profiles_surface)
surface_data = xr.merge(
    (surface_errors.dataset, model_profiles_surface.dataset, obs_profiles_surface.dataset), compat="override"
)
surface_data.to_netcdf(
    dn_out + "surface_data_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/1451327084.py in <cell line: 1>()
    ----> 1 model_profiles_surface = profile_analysis.depth_means(model_profiles, [0, surface_def])
          2 obs_profiles_surface = profile_analysis.depth_means(profile, [0, surface_def])
          3 surface_errors = profile_analysis.difference(obs_profiles_surface, model_profiles_surface)
          4 surface_data = xr.merge(
          5     (surface_errors.dataset, model_profiles_surface.dataset, obs_profiles_surface.dataset), compat="override"


    NameError: name 'model_profiles' is not defined


Bottom values and errors.


```python
model_profiles_bottom = profile_analysis.bottom_means(model_profiles, bottom_height, bottom_thresh)
obs_bathymetry = model_profiles.dataset["bathymetry"].values
profile.dataset["bathymetry"] = (["id_dim"], obs_bathymetry)
obs_profiles_bottom = profile_analysis.bottom_means(profile, bottom_height, bottom_thresh)
bottom_errors = profile_analysis.difference(model_profiles_bottom, obs_profiles_bottom)
bottom_data = xr.merge(
    (bottom_errors.dataset, model_profiles_bottom.dataset, obs_profiles_bottom.dataset), compat="override"
)
bottom_data.to_netcdf(
    dn_out + "bottom_data_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
print("Bottom and surface data estimated and written", flush=True)
print("DONE", flush=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3712/1177276497.py in <cell line: 1>()
    ----> 1 model_profiles_bottom = profile_analysis.bottom_means(model_profiles, bottom_height, bottom_thresh)
          2 obs_bathymetry = model_profiles.dataset["bathymetry"].values
          3 profile.dataset["bathymetry"] = (["id_dim"], obs_bathymetry)
          4 obs_profiles_bottom = profile_analysis.bottom_means(profile, bottom_height, bottom_thresh)
          5 bottom_errors = profile_analysis.difference(model_profiles_bottom, obs_profiles_bottom)


    NameError: name 'model_profiles' is not defined

