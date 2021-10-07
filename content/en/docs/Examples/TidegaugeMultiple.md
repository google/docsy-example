---
title: "TidegaugeMultiple"
linkTitle: "TidegaugeMultiple"
weight: 5

description: >
  Example useage of TidegaugeMultiple object.
---

The TidegaugeMultiple object is for storing multiple tide gauge/time series datasets in one object.
It has two dimensions: ('id', 't_dim') and is a child of the Timeseries and Indexed objects.
All timeseries in this object must lie on the same time dimension and indices. If not the case
in your data, then it must be preprocessed before use with this object.

The Tidegauge object on the other hand, currently only stores one time series at a time. See
the examples page for Tidegauge for more information. In the future, these objects will be
combined.

The TidegaugeMultiple object contains multiple routines suitable for validation of SSH.
Below are some examples of how to use this object for this purpose.


This script gives an overview of some of validation tools available when
using the TidegaugeMultiple object in COAsT.

For this a script, a premade netcdf file containing tide gauge data is used.

### 1. Setup
```
import xarray as xr
import numpy as np
import matplotlib.pyplot as plt
import coast
import datetime
```

Define paths
```
fn_dom = "/Users/dbyrne/Projects/coast/workshops/07092021/data/mesh_mask.nc"
fn_dat = "/Users/dbyrne/Projects/coast/workshops/07092021/data/sossheig*"
fn_tg = "/Users/dbyrne/Projects/coast/workshops/07092021/data/tg_amm15.nc"
```

Create gridded object and load data
```
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config="./config/example_nemo_grid_t.json")
```

Create a landmask array and put it into the nemo object.
Here, using the bottom_level == 0 variable from the domain file is enough.
```
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0
```

Rename depth_0 to be depth to work with routines expectations
```
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
nemo.dataset = nemo.dataset[["ssh", "landmask"]]
```

### 2. Create TidegaugeMultiple object

Create the object and then inset the netcdf dataset
```
obs = coast.TidegaugeMultiple()
obs.dataset = xr.open_dataset(fn_tg)
```

Cut down data to be only in 2018 to match model data.
```
start_date = datetime.datetime(2018, 1, 1)
end_date = datetime.datetime(2018, 12, 31)
obs.dataset = coast.general_utils.data_array_time_slice(obs.dataset, start_date, end_date)
```

### 3. Interpolate model data onto obs locations

Obs_operator is used to extract time series from the model:
```
model_timeseries = obs.obs_operator(nemo)
```

In this case, transpose the interpolated dataset so dimensions are
in the correct order: ('id','t_dim')
```
model_timeseries.dataset = model_timeseries.dataset.transpose()
```

Process the data a little
This routine searches for missing values in each dataset and applies them
equally to each corresponding dataset
```
obs, model_timeseries = obs.match_missing_values(model_timeseries)
```

Subtract means from all time series
```
obs = obs.demean_timeseries()
model_timeseries = model_timeseries.demean_timeseries()
```

Now you have equivalent and comparable sets of time series that can be
easily compared.

### 4. Calculate non tidal residuals

First, do a harmonic analysis. This routine uses utide
```
ha_mod = model_timeseries.harmonic_analysis_utide()
ha_obs = obs.harmonic_analysis_utide()
```
Create new TidegaugeMultiple objects containign reconstructed tides
```
tide_mod = model_timeseries.reconstruct_tide_utide(ha_mod)
tide_obs = obs.reconstruct_tide_utide(ha_obs)
```
Get new TidegaugeMultiple objects containing non tidal residuals.
```
ntr_mod = model_timeseries.calculate_residuals(tide_mod)
ntr_obs = obs.calculate_residuals(tide_obs)
```
Other interesting applications here included only reconstructing specified
tidal frequency bands and validating this.

### 5. Calculate errors

The difference() routine will calculate differences, absolute_differences
and squared differenced for all variables:
```
ntr_diff = ntr_obs.difference(ntr_mod)
ssh_diff = obs.difference(model_timeseries)
```
We can then easily get mean errors, MAE and MSE
```
mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
```

### 6. Threshold Statistics for Non-tidal residuals

This is a simple extreme value analysis of whatever data you use.
It will count the number of peaks and the total time spent over each
threshold provided. It will also count the numbers of daily and monthly
maxima over each threshold

```
thresh_mod = ntr_mod.threshold_statistics(thresholds=np.arange(0, 2, 0.2))
thresh_obs = ntr_obs.threshold_statistics(thresholds=np.arange(0, 2, 0.2))
```

