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

Every id index for this object should use the same time coordinates.
Therefore, timeseries need to be aligned before being placed into the
object. If there is any padding needed, then NaNs should be used. NaNs
should also be used for quality control/data rejection.

# Example Useage

Please see COAsT/example_scripts/tidegauge_validaiton for some working
example scripts for using the `Tidegauge` and `TidegaugeAnalysis` classes.

### Reading and manipulation

We can create our empty tidegauge object:

```
tidegauge = coast.Tidegauge()
```

The `Tidegauge` class contains multiple methods for reading different typical
tidegauge formats. This includes reading from the GESLA and BODC databases.
To read a gesla file between two dates, we can use:

```
date0 = datetime.datetime(2007,1,10)
date1 = datetime.datetime(2007,1,12)
tidegauge.read_gesla_v3(fn_tidegauge, date_start = date0, date_end = date1)
```

For the rest of our examples, we will use data from multiple tide gauges
on the same time dimension, read in from a simlpe netCDF file:

```
dataset = xr.open_dataset( fn_multigauge )
tidegauge = coast.Tidegauge(dataset)
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
tidegauge = tidegauge.subset_indices_lonlat_box(longitude_bounds = [-15, 15], 
                                            latitude_bounds = [45, 65])

# Cut out a time window
tidegauge = tidegauge.time_slice( date0 = datetime(2004, 1, 1), date1 = datetime(2005,1,1))
```

We can extract just some variables using:

```
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
nemo.dataset = nemo.dataset[["ssh", "landmask"]]
```

We can subtract means from all time series
```
analysis = coast.TidegaugeAnalysis()
model_timeseries = analysis.demean_timeseries(tidegauge)
```

### Direct model comparison

Before comparing our observations to the model, we will interpolate a model
variable to the same time and geographical space as the tidegauge. This is
done using the obs_operator() method:

```
# Suppose we have created a Gridded object called nemo
tidegauge_interp = tidegauge.obs_operator(nemo, time_interp='nearest')
```

Doing this has created a new interpolated tidegauge called `tidegauge_interp` 
Take a look at tidegauge_interp.datasetto see for yourself. If a `landmask` 
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
obs_ssh, model_ssh = obs.match_missing_values(tidegauge.dataset.ssh, 
                                              tidegauge_interp.dataset.ssh)
```

Although we input data arrays to the above routine, it returns two new Tidegauge
objects. Now you have equivalent and comparable sets of time series that can be
easily compared.

The difference() routine will calculate differences, absolute_differences
and squared differenced for all variables:
```
diff = analysis.difference(obs_ssh, model_ssh)
```
We can then easily get mean errors, MAE and MSE
```
mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
```

### Harmonic Analysis & Non-tidal Residuals

The `Tidegauge` object contains some routines which make harmonic analysis and
the calculation/comparison of non-tidal residuals easier. Harmonic analysis is
done using the `utide` package. Please see [here](https://pypi.org/project/UTide/) for more info.

First we can use the `ProfileAnalysis` class to do a harmonic analysis. Suppose
we have two `Tidegauge` objects called `tidegauge_model` and `tidegauge_obs`:

```
ha_mod = analysis.harmonic_analysis_utide(tidegauge_model.dataset.ssh)
ha_obs = analysis.harmonic_analysis_utide(tidegauge_obs.dataset.ssh)
```

The `harmonic_analysis_utide` routine returns a list of `utide` structure object,
one for each `id_dim` in the `Tidegauge` object. It can be passed any of the
arguments that go to `utide`. It also has an additional argument `min_datapoints`
which determines a minimum number of data points for the harmonics analysis.
If a tidegauge `id_dim` has less than this number, it will not return an analysis.

Now, create new TidegaugeMultiple objects containing reconstructed tides:

```
tide_mod = analysis.reconstruct_tide_utide(tidegauge_model.time)
tide_obs = analysis.reconstruct_tide_utide(tidegauge_obs.time)
```

Get new TidegaugeMultiple objects containing non tidal residuals:

```
ntr_mod = analysis.calculate_non_tidal_residuals(tidegauge_model.dataset.ssh, tide_mod.dataset.ssh)
ntr_obs = analysis.calculate_non_tidal_residuals(tidegauge_obs.dataset.ssh, tide_obs.dataset.ssh)
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
thresh_mod = analysis.threshold_statistics(ntr_mod, thresholds=np.arange(0, 2, 0.2))
thresh_obs = analysis.threshold_statistics(ntr_obs, thresholds=np.arange(0, 2, 0.2))
```
