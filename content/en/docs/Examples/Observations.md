---
title: Observations
linkTitle: Observations
date:
weight: 2
description: Intro to observations in COAsT
---
COAsT currently has two observation classes: `ALTIMETRY` and `TIDEGAUGE`. Each has it's own methods and, crucially, their own data formatting requirements. Here, we take a look at both and then do some model comparison.

Import packages and define files paths:


```python
import coast
import datetime

fn_nemo_dat  = './example_files/COAsT_example_NEMO_data.nc'
fn_nemo_dom  = './example_files/COAsT_example_NEMO_domain.nc'
fn_tidegauge = './example_files/tide_gauges/dover-p012-uk-bodc'
fn_tidegauge_mult = './example_files/tide_gauges/*'
fn_altimetry = './example_files/COAsT_example_altimetry_data.nc'
```

## Altimetry
The `ALTIMETRY` class is for handling along-track data, especially from an altimeter instrument. By default it is set up to read along-track altimetry data from the CMEMS database.

Create `ALTIMETRY` object and plot the data using `ALTIMETRY.quick_plot()`:


```python
altimetry = coast.ALTIMETRY(fn_altimetry)
altimetry.dataset
```

Let's take a look at the `sla_filtered` variable using `quick_plot()`:


```python
altimetry.quick_plot('sla_filtered')
```

Before going any further, lets just cut out the bit of the altimetry that is over the model domain. This can be done using `altimetry.subset_indices_lonlat_box()` to find relevant indices and then isel to extract them. The data has also been thinned slightly.


```python
ind = altimetry.subset_indices_lonlat_box([-10,10], [45,60])
ind = ind[::4]
altimetry = altimetry.isel(t_dim=ind)
altimetry.quick_plot('sla_filtered')
```

## TIDEGAUGE

The `TIDEGAUGE` class is for handling time series data, specifically at a tide gauge. By default, it is set up to read GESLA2 data. 

Create tidegauge object and read data between two dates:


```python
date0 = datetime.datetime(2007,1,1)
date1 = datetime.datetime(2007,1,31)
tidegauge = coast.TIDEGAUGE(fn_tidegauge, date_start = date0, date_end = date1)
tidegauge.dataset
```

TIDEGAUGE has ready made quick plotting routines for viewing time series and tide gauge location. To look at the tide gauge location:


```python
fig, ax = tidegauge.plot_on_map()
```

Or to look at a time series of the `sea_level` variable:


```python
tidegauge.plot_timeseries('sea_level')
```

We can resample this data to 1 hour using an averaging window and apply a Doodson-x0 filter to remove some of the tides:


```python
# Resample data
tidegauge.resample_mean('sea_level','1H')

# Apply Doodson x0 filter
tidegauge.apply_doodson_x0_filter('sea_level_1H')
```

The `resample_mean()` routine created a new variable inside `tidegauge` called `sea_level_1H`, which we then pass to `apply_doodson_x0_filter()`. This then creates a new variable called `sea_level_1H_dx0`. These can now be seen:


```python
tidegauge.dataset
```

And we can plot all three variables up using `plot_timeseries()`:


```python
tidegauge.plot_timeseries(['sea_level', 'sea_level_1H', 'sea_level_1H_dx0'])
```

Each `TIDEGAUGE` object only holds data for a single tidegauge. There is some functionality for dealing with multiple gauges in COAsT. To load multiple GESLA tidegauge files, we use the static method `create_multiple_tidegauge()`. This routine takes a list of files or a wildcard string and loads them all into a list of `TIDEGAUGE` objects.


```python
date0 = datetime.datetime(2007,1,10)
date1 = datetime.datetime(2007,1,12)
tidegauge_list = coast.TIDEGAUGE.create_multiple_tidegauge(fn_tidegauge_mult,
                                                            date0,date1)
```

Now that we have tidegauge_list, we can plot the locations of all tide gauges as follows:


```python
fig, ax = coast.TIDEGAUGE.plot_on_map_multiple(tidegauge_list)
```

## Model Comparison
COAsT contains some functionality for interpolating model data and comparing to observations.

Let's load in the NEMO data we defined above:


```python
nemo_t = coast.NEMO(fn_nemo_dat, fn_nemo_dom, grid_ref='t-grid', chunks={})
```

Before comparing our observations to the model, we will interpolate a model variable to the same time and geographical space as the tidegauge. This is done using the `obs_operator()` method. At the moment, this finds the nearest grid cell to each observation and interpolates in time using any `scipy` interpolation method.


```python
tidegauge.obs_operator(nemo_t, mod_var_name='ssh', time_interp='nearest')
tidegauge.dataset
```

And similarly for altimetry:


```python
altimetry.obs_operator(nemo_t, mod_var_name = 'ssh', time_interp = 'nearest')
altimetry.dataset
```

Doing this has created a new interpolated variable called interp_ssh and saved it back into our TIDEGAUGE object. Take a look at tidegauge.dataset to see for yourself.

Next we will compare this interpolated variable to an observed variable using some basic metrics. The basic_stats() routine can be used for this, which calculates some simple metrics including differences, RMSE and correlations. NOTE: This may not be a wise choice of variables.


```python
altimetry_stats = altimetry.basic_stats('interp_ssh', 'sla_filtered')
altimetry_stats.dataset
```

Take a look inside `altimetry_stats.dataset` to see all of the new variables. When using `basic stats`, the returned object is also an `TIDEGAUGE` object, so all of the same methods can be applied. Alternatively, if you want to save the new metrics to the original `TIDEGAUGE` object, set `create_new_object = False`.

Now we will do a more complex comparison using the Continuous Ranked Probability Score (CRPS). For this, we need to hand over the model object, a model variable and an observed variable. We also give it a neighbourhood radius in km (nh_radius).


```python
crps = altimetry.crps(nemo_t, model_var_name = 'ssh', obs_var_name = 'sla_filtered', nh_radius = 25)
```

Again, take a look inside crps.dataset to see some new variables. Similarly to basic_stats, create_new_object can be set to false to save output to the original tidegauge object.


```python
crps.dataset
```

This can be treated as the same class as the original observation object, so in this case `ALTIMETRY`. So we can do some plotting using `quick_plot()`:


```python
crps.quick_plot('crps_contains_land')
```

You can use numpy to get an average CRPS over the domain:


```python
import numpy as np
np.nanmean( crps.dataset.crps )
```


```python

```
