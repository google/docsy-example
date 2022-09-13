---
    title: "Analysis extract and compare single process tutorial"
    linkTitle: "Analysis extract and compare single process tutorial"
    weight: 5

    description: >
        Analysis extract and compare single process tutorial example.
---
This runs the same analysis as `analysis_extract_and_compare.py` however it
does so in time blocks (multiples of months) to avoid memory problems, and can not be run with the `example_files`.
At the top of this file are two variables called min_date and end_date
and freq_monthgs. These are the dates that this script will run an analysis
between and the monthly multiples to run per block. You must pass an index
to this file at the command line, telling the script which month index to run.  

For example... If the dates are between 20040101 and 20050101, then an index
of 0 will run for the period 20040101 -> 20040201. An index of 4 will run
for the period 20040301 -> 20040401.

This script exists to be used as part of a parallel scheme on a platform like
JASMIN. For example, using a command interface such as jug. This script
should be run on each process, being passed just a single index.

If uneditted, this script will output five files PER PROCESS to the output
directory specified by dn_out:

1) extracted_profiles: Model data on model levels extracted at obs locs
2) interpolated_profiles: Model data on ref depth level
3) interpolated_obs: Obs data on ref depth levels
4) profile_errors: Differences between interpolated_profiles and _obs
5) surface_data: Surface data and errors
6) bottom_data: Bottom data and errors

The files can then be concatenated and given to an averaging routine such
as `analysis_mask_means.py` or `analysis_average_into_grid.py`.

### Import relevant packages

```
import sys
import coast
import xarray as xr
import numpy as np
import datetime
from dateutil.relativedelta import relativedelta
```

### Define settings

```
index = 1
# Name of the run -- used mainly for naming output files
run_name = "co7"
# Start and end dates for the analysis. The script will cut down model
# and EN4 data to be witin this range.
min_date = datetime.datetime(2004, 1, 1)
freq_months = 12
end_date = datetime.datetime(2004, 3, 1)
```

### Figure out what the date range is for this analysis process

```
start_date = min_date + relativedelta(months=int(index * freq_months))
end_date = start_date + relativedelta(months=int(freq_months))
print("Analysis Range: {0} -->> {1}".format(start_date.strftime("%Y%m%d"), end_date.strftime("%Y%m%d")), flush=True)
```

### Set depth averaging settings

```
ref_depth = np.concatenate((np.arange(1, 100, 2), np.arange(100, 300, 5), np.arange(300, 1000, 50)))
surface_def = 5  # in metres
bottom_height = [10, 30, 100]  # Use bottom heights of 10m, 30m and 100m for...
bottom_thresh = [100, 500, np.inf]  # ...depths less than 100m, 500m and infinite
```

### Set file paths

```
# define some file paths

fn_dom = "<PATH_TO_NEMO_DOMAIN_FILE>"
fn_dat = "<PATH_TO_NEMO_DATA_FILE(S)>"  # .format(run_name, start_date.year)
dn_out = "<PATH_TO_OUTPUT_DIRECTORY>"  # .format(run_name)
fn_prof = "<PATH_TO_PROCESSED_EN4_DATA>"
fn_cfg_nemo = "<PATH_TO_COAST_GRIDDED_CONFIG_FILE>"
fn_cfg_prof = "<PATH_TO_CODE_PROFILE_CONFIG_FILE>"
```

### Create NEMO object and read in NEMO data.

```
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config=fn_cfg_nemo)
```

### Extract latitude and longitude

```
lat = nemo.dataset.latitude.values.squeeze()
lon = nemo.dataset.longitude.values.squeeze()
```

### Extract time indices between start and end dates

```
nemo = nemo.time_slice(start_date, end_date)
```

```
nemo.dataset.temperature.values
```

### Create a landmask array
This is important for obs_operator We can get a landmask from bottom_level.

```
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
print("Landmask calculated", flush=True)
```

### Create EN4 Profile object

```
# CREATE EN4 PROFILE OBJECT containing processed data. We just need to
# create a Profile object and place the data straight into its dataset
profile = coast.Profile()
profile.dataset = xr.open_dataset(fn_prof, chunks={"id_dim": 10000})
profile = profile.time_slice(start_date, end_date)
print("Profile object created", flush=True)
```

### Extract only the variables that we want

```
nemo.dataset = nemo.dataset[["temperature", "salinity", "bathymetry", "bottom_level", "landmask"]]
profile.dataset = profile.dataset[["potential_temperature", "practical_salinity", "depth"]]
profile.dataset = profile.dataset.rename({"potential_temperature": "temperature", "practical_salinity": "salinity"})
```

### Create Profile analysis object

```
profile_analysis = coast.ProfileAnalysis()
```

### Interpolate model to obs using obs_operator()

```
model_profiles = profile.obs_operator(nemo)
print("Obs_operator successful.", flush=True)
```

### Throw away profiles where the interpolation distance is larger than 5km.

```
keep_indices = model_profiles.dataset.interp_dist <= 5
model_profiles = model_profiles.isel(profile=keep_indices)
profile = profile.isel(profile=keep_indices)
```

### Load the profiles (careful with memory)

```
profile.dataset.load()
print("Model interpolated to obs locations", flush=True)
```

### Vertical Interpolation of model profiles to obs depths

```
model_profiles_interp = profile_analysis.interpolate_vertical(model_profiles, profile, interp_method="linear")
print("Model interpolated to obs depths", flush=True)
```

### Vertical interpolation of model profiles to reference depths

```
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

### Interpolation of obs profiles to reference depths

```
profile_interp = profile_analysis.interpolate_vertical(profile, ref_depth)
profile_interp.dataset.to_netcdf(
    dn_out + "interpolated_obs_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
print("Obs interpolated to reference depths", flush=True)
```

### Get difference between Model and Obs

```
differences = profile_analysis.difference(profile_interp, model_profiles_interp)
differences.dataset.load()
differences.dataset.to_netcdf(
    dn_out + "profile_errors_{0}_{1}_{2}.nc".format(run_name, start_date.strftime("%Y%m"), end_date.strftime("%Y%m"))
)
print("Calculated errors and written", flush=True)
```

### Get surface values and errors

```
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

### Get bottom values and errors

```
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
```
