---
    title: "Tideguage validation tutorial"
    linkTitle: "Tideguage validation tutorial"
    weight: 5

    description: >
        Tideguage validation tutorial example.
---
This script gives an overview of some of validation tools available when
using the TidegaugeMultiple object in COAsT.

For this a script, a premade netcdf file containing tide gauge data is used.


```python
#%% 1. Import necessary libraries
import xarray as xr
import numpy as np
import coast
import datetime
```


```python
#%% 2. Define paths
fn_dom = "<PATH_TO_NEMO_DOMAIN>"
fn_dat = "<PATH_TO_NEMO_DATA>"
fn_config = "<PATH_TO_CONFIG.json>"
fn_tg = "<PATH_TO_TIDEGAUGE_NETCDF>"  # This should already be processed, on the same time dimension

# Change this to 0 to not use default files.
if 1:
    print(f"Use default files")
    dir = "./example_files/"
    fn_dom = dir + "coast_example_nemo_domain.nc"
    fn_dat = dir + "coast_example_nemo_data.nc"
    fn_config = "./config/example_nemo_grid_t.json"
    fn_tg = dir + "tg_amm15.nc"
```


```python
#%% 3. Create gridded object and load data
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config=fn_config)

# Create a landmask array and put it into the nemo object.
# Here, using the bottom_level == 0 variable from the domain file is enough.
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0

# Rename depth_0 to be depth
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
nemo.dataset = nemo.dataset[["ssh", "landmask"]]
```


```python
#%% 4. Create TidegaugeMultiple object

# Create the object and then inset the netcdf dataset
obs = coast.Tidegauge(dataset=xr.open_dataset(fn_tg))
obs.dataset = obs.dataset.set_coords("time")

# Shift the timestamp so it overlaps with the tidegauge data - Not ideal but this is only a demo
obs.dataset.coords["time"] = obs.dataset.coords["time"] + 1000000000 * 3600 * 24 * 365 * 3

# Cut down data to be only in 2018 to match model data.
start_date = datetime.datetime(2007, 1, 1)
end_date = datetime.datetime(2007, 1, 31)
obs = obs.time_slice(start_date, end_date)
```


```python
#%% 5. Interpolate model data onto obs locations
model_timeseries = obs.obs_operator(nemo)

# In this case, transpose the interpolated dataset
model_timeseries.dataset = model_timeseries.dataset.transpose()
```


```python
#%% 6. Do some processing
# This routine searches for missing values in each dataset and applies them
# equally to each corresponding dataset
tganalysis = coast.TidegaugeAnalysis()
obs_new, model_new = tganalysis.match_missing_values(obs.dataset.ssh, model_timeseries.dataset.ssh)

# Subtract means from all time series
obs_new = tganalysis.demean_timeseries(obs_new.dataset)
model_new = tganalysis.demean_timeseries(model_new.dataset)

# Now you have equivalent and comparable sets of time series that can be
# easily compared.
```


```python
#%% Calculate non tidal residuals

# First, do a harmonic analysis. This routine uses utide
ha_mod = tganalysis.harmonic_analysis_utide(model_new.dataset.ssh, min_datapoints=1)
ha_obs = tganalysis.harmonic_analysis_utide(obs_new.dataset.ssh, min_datapoints=1)

# Create new TidegaugeMultiple objects containing reconstructed tides
tide_mod = tganalysis.reconstruct_tide_utide(model_new.dataset.time, ha_mod)
tide_obs = tganalysis.reconstruct_tide_utide(obs_new.dataset.time, ha_obs)

# Get new TidegaugeMultiple objects containing non tidal residuals.
ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed)
ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed)

# Other interesting applications here included only reconstructing specified
# tidal frequency bands and validating this.
```


```python
#%% Calculate errors

# The difference() routine will calculate differences, absolute_differences
# and squared differenced for all variables:
ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)

# We can then easily get mean errors, MAE and MSE
mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
```


```python
#%% Threshold Statistics for Non-tidal residuals

# This is a simple extreme value analysis of whatever data you use.
# It will count the number of peaks and the total time spent over each
# threshold provided. It will also count the numbers of daily and monthly
# maxima over each threshold

thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(0, 2, 0.2))
thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(0, 2, 0.2))
```
