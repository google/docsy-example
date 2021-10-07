---
title: "Tidegauge"
linkTitle: "Tidegauge"
weight: 5

description: >
  Example useage of Tidegauge object.
---


This is a demonstration script for using the Tidegauge object in the COAsT
package. This object has strict data formatting requirements, which are
outlined in tidegauge.py.


Begin by importing coast and other packages
```
import coast
import datetime
```

And by defining some file paths from the COAsT example files
```
fn_nemo_dat  = './example_files/coast_example_nemo_data.nc'
fn_nemo_dom  = './example_files/coast_example_nemo_domain.nc'
fn_config_t_grid = './config/example_nemo_grid_t.json',
fn_tidegauge = './example_files/tide_gauges/lowestoft-p024-uk-bodc'
fn_tidegauge_mult = './example_files/tide_gauges/l*'
```

We need to load in a Gridded object for doing things with NEMO.
```
nemo = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=fn_config_t_grid)
```

And now we can load in our tidegauge data. By default, Tidegauge is set up
to read in GESLA ASCII files. However, if no path is supplied, then the
object's dataset will be initialised as None. Custom data can then be loaded
if desired, as long as it follows the data formatting for Tidegauge. Here
we load data between two specified dates:
```
date0 = datetime.datetime(2007,1,10)
date1 = datetime.datetime(2007,1,12)
tidegauge = coast.Tidegauge(fn_tidegauge, date_start = date0, date_end = date1)
```

Before comparing our observations to the model, we will interpolate a model
variable to the same time and geographical space as the tidegauge. This is
done using the obs_operator() method:
```
tidegauge.obs_operator(nemo, mod_var_name='ssh', time_interp='nearest')
```

Doing this has created a new interpolated variable called interp_ssh and
saved it back into our Tidegauge object. Take a look at tidegauge.dataset
to see for yourself.

Next we will compare this interpolated variable to an observed variable
using some basic metrics. The basic_stats() routine can be used for this,
which calculates some simple metrics including differences, RMSE and
correlations. NOTE: This may not be a wise choice of variables.
```
stats = tidegauge.basic_stats('interp_ssh', 'sea_level')
```

Take a look inside stats.dataset to see all of the new variables. When using
basic stats, the returned object is also an Tidegauge object, so all of the
same methods can be applied. Alternatively, if you want to save the new
metrics to the original Tidegauge object, set create_new_object = False.

Now we will do a more complex comparison using the Continuous Ranked
Probability Score (CRPS). For this, we need to hand over the model object,
a model variable and an observed variable. We also give it a neighbourhood
radius in km (nh_radius).
```
crps = tidegauge.crps(nemo, model_var_name = 'ssh', obs_var_name = 'sea_level',
                      nh_radius = 20)
```

Again, take a look inside crps.dataset to see some new variables. Similarly
to basic_stats, create_new_object can be set to false to save output to
the original tidegauge object.

Tidegauge has ready made quick plotting routines for viewing time series
and tide gauge location. To look at the tide gauge location:
```
fig, ax = tidegauge.plot_on_map()
```

Or to look at a time series of the sea_level variable:
```
fig, ax = tidegauge.plot_timeseries('sea_level', qc_colors=True)
```

Note that start and end dates can also be specified for plot_timeseries().

As stats and crps are also Tidegauge objects, the same time series plotting
functionality can be used:
```
crps.plot_timeseries('crps')
stats.plot_timeseries('absolute_error')
```

Each Tidegauge object only holds data for a single tidegauge. There is some
functionality for dealing with multiple gauges in COAsT. To load multiple
GESLA tidegauge files, we use the static method create_multiple_tidegauge().
This routine takes a list of files or a wildcard string and loads them all
into a list of Tidegauge objects.
```
from coast.tidegauge import Tidegauge
date0 = datetime.datetime(2007,1,10)
date1 = datetime.datetime(2007,1,12)
tidegauge_list = Tidegauge.create_multiple_tidegauge(fn_tidegauge_mult,
                                                           date0,date1)
```

Now that we have tidegauge_list, we can plot the locations of all tide gauges
as follows:
```
fig, ax = Tidegauge.plot_on_map_multiple(tidegauge_list)
```

To do analysis on multiple gauges, a simple looping script can be setup.
For example, to obtain basic stats:
```
for tg in tidegauge_list:
    tg.obs_operator(nemo, 'ssh')
    tg.basic_stats('interp_ssh', 'sea_level', create_new_object=False)
```

And now some of these new values can be plotted on a map, again using
plot_on_map_multiple:
```
fig, ax = Tidegauge.plot_on_map_multiple(tidegauge_list, color_var_str='rmse')
```
