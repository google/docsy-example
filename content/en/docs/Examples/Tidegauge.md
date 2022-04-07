---
title: "Tidegauge"
linkTitle: "Tidegauge"
weight: 5

description: >
  Example useage of Tidegauge object.
---
# Overview

This is an object for storage and manipulation of tide gauge data
in a single dataset. This may require some processing of the observations
such as interpolation to a common time step.

This object's dataset should take the form (as with Timeseries):

    Dimensions:
        id_dim   : The locations dimension. Each time series has an index
        time : The time dimension. Each datapoint at each port has an index

    Coordinates:
        longitude (id_dim) : Longitude values for each port index
        latitude  (id_dim) : Latitude values for each port index
        time      (time) : Time values for each time index (datetime)
        id_name   (id_dim)   : Name of index, e.g. port name or mooring id.

An example data variable could be ssh, or ntr (non-tidal residual). This
object can also be used for other instrument types, not just tide gauges.
For example moorings.

Every `id` index for this object should use the same time coordinates.
Therefore, timeseries need to be aligned before being placed into the
object. If there is any padding needed, then NaNs should be used. NaNs
should also be used for quality control/data rejection.

# Example Useage

Please see `COAsT/example_scripts/tidegauge_validation` for some working
example scripts for using the `Tidegauge` and `TidegaugeAnalysis` classes.

To get started you can use example data detailed in the Getting Started section:

```
import coast

dn_files = "./example_files/"
fn_dom = dn_files + "coast_example_nemo_domain.nc"
fn_dat = dn_files + "coast_example_nemo_data.nc"
fn_config = "./config/example_nemo_grid_t.json"
fn_multigauge = dn_files + "tg_amm15.nc"
fn_tidegauge = dn_files + "tide_gauges/lowestoft-p024-uk-bodc"
nemo = coast.Gridded(fn_dat, fn_dom, config=fn_config)
```

### Reading and manipulation

We can create our empty tidegauge object:

```
tidegauge = coast.Tidegauge()
```

The `Tidegauge` class contains multiple methods for reading different typical
tidegauge formats. This includes reading from the GESLA and BODC databases.
To read a gesla file between two dates, we can use:

```
import datetime
date0 = datetime.datetime(2007,1,10)
date1 = datetime.datetime(2007,1,12)
tidegauge.read_gesla_v3(fn_tidegauge, date_start = date0, date_end = date1)
```

For the rest of our examples, we will use data from multiple tide gauges
on the same time dimension, read in from a simple netCDF file:

```
import xarray as xr
dataset = xr.open_dataset( fn_multigauge )
tidegauge = coast.Tidegauge(dataset)
tidegauge.dataset = tidegauge.dataset.set_coords('time')
```

Tidegauge has ready made quick plotting routines for viewing time series
and tide gauge location. To look at the tide gauge location:
```
fig, ax = tidegauge.plot_on_map()
```

Or to look at a time series of the sea_level variable:
```
fig, ax = tidegauge.plot_timeseries('ssh', qc_colors=True)
```

Note that start and end dates can also be specified for plot_timeseries().

We can do some simple spatial and temporal manipulations of this data:

```
# Cut out a geographical box
tidegauge = tidegauge.subset_indices_lonlat_box(lonbounds = [-5, 0],
                                            latbounds = [50, 55])

# Cut out a time window
tidegauge = tidegauge.time_slice( date0 = datetime.datetime(2007, 1, 1), date1 = datetime.datetime(2007,1,31))
```

We can extract just some variables using, e.g.:

```
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
nemo.dataset = nemo.dataset[["ssh", "landmask"]]
```



### Direct model comparison

Before comparing our observations to the model, we will interpolate a model
variable to the same time and geographical space as the tidegauge. This is
done using the `obs_operator()`` method:

```
# Suppose we have created a Gridded object called nemo
tidegauge_from_model = tidegauge.obs_operator(nemo, time_interp='nearest')
```

Doing this has created a new interpolated tidegauge called `tidegauge_from_model`
Take a look at `tidegauge_from_model.dataset` to see for yourself. If a `landmask`
variable is present in the `Gridded` dataset then the nearest wet points will
be taken. Otherwise, just the nearest point is taken. If `landmask` is required
but not present you will need to insert it into the dataset yourself. For nemo
data, you could use the `bottom_level` or `mbathy` variables to do this. E.g:

```
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0
```

For a good comparison, we would like to make sure that both the observed and
modelled `Tidegauge` objects contain the same missing values. `TidegaugeAnalysis`
contains a routine for ensuring this. First create our analysis object:

```
analysis = coast.TidegaugeAnalysis()
```

Then use the `match_missing_values()` routine:

```
obs_ssh, model_ssh = analysis.match_missing_values(tidegauge.dataset.ssh,
                                              tidegauge_from_model.dataset.ssh)
```

Although we input data arrays to the above routine, it returns two new Tidegauge
objects. Now you have equivalent and comparable sets of time series that can be
easily compared.

The difference() routine will calculate differences, absolute_differences
and squared differenced for all variables:
```
diff = analysis.difference(obs_ssh.dataset, model_ssh.dataset)
```
We can then easily get mean errors, MAE and MSE
```
mean_stats = diff.dataset.mean(dim="t_dim", skipna=True)
```

### Harmonic Analysis & Non-tidal Residuals

The `Tidegauge` object contains some routines which make harmonic analysis and
the calculation/comparison of non-tidal residuals easier. Harmonic analysis is
done using the `utide` package. Please see [here](https://pypi.org/project/UTide/) for more info.

First we can use the `TidegaugeAnalysis` class to do a harmonic analysis. Suppose
we have two `Tidegauge` objects called `tidegauge` and `tidegauge_from_model` generated from tidegauge observations and model simulations respectively.

We can subtract means from all time series:
```
analysis = coast.TidegaugeAnalysis()
obs_new, model_new = analysis.match_missing_values(tidegauge.dataset.ssh, tidegauge_from_model.dataset.ssh)
```

Then subtract means from all the time series
```
model_timeseries = analysis.demean_timeseries(model_new.dataset)
obs_timeseries = analysis.demean_timeseries(obs_new.dataset)
```

Then we can apply the harmonic analysis (though the example data is too short for this example to be that meaningful):
```
ha_mod = analysis.harmonic_analysis_utide(model_timeseries.dataset.ssh, min_datapoints = 1)
ha_obs = analysis.harmonic_analysis_utide(obs_timeseries.dataset.ssh, min_datapoints = 1)
```

The `harmonic_analysis_utide` routine returns a list of `utide` structure object,
one for each `id_dim` in the `Tidegauge` object. It can be passed any of the
arguments that go to `utide`. It also has an additional argument `min_datapoints`
which determines a minimum number of data points for the harmonics analysis.
If a tidegauge `id_dim` has less than this number, it will not return an analysis.

Now, create new TidegaugeMultiple objects containing reconstructed tides:

```
tide_mod = analysis.reconstruct_tide_utide(model_timeseries.dataset.time, ha_mod)
tide_obs = analysis.reconstruct_tide_utide(obs_timeseries.dataset.time, ha_obs)
```

Get new TidegaugeMultiple objects containing non tidal residuals:

```
ntr_mod = analysis.calculate_non_tidal_residuals(model_timeseries.dataset.ssh, tide_mod.dataset.reconstructed)
ntr_obs = analysis.calculate_non_tidal_residuals(obs_timeseries.dataset.ssh, tide_obs.dataset.reconstructed)
```

By default, this routines will apply `scipy.signal.savgol_filter` to the non-tidal residuals
to remove some noise. This can be switched off using `apply_filter = False`.

The Doodson X0 filter is an alternative way of estimating non-tidal residuals:

```
dx0 = analysis.doodson_x0_filter(tidegauge.dataset, "ssh")
```

This will return a new `Tidegauge()` object containing filtered `ssh` data.


### 6. Threshold Statistics

This is a simple extreme value analysis of whatever data you use.
It will count the number of peaks and the total time spent over each
threshold provided. It will also count the numbers of daily and monthly
maxima over each threshold. To this, a `Tidegauge` object and an array of
thresholds (in metres) should be passed:

```
import numpy as np
thresh_mod = analysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(0, 2, 0.2))
thresh_obs = analysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(0, 2, 0.2))
```
