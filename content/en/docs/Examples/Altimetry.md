---
title: "Altimetry"
linkTitle: "Altimetry"
weight: 3

description: >
  Example useage of ALTIMETRY object.
---

Here we give a short tutorial of how to use the ALTIMETRY object for reading data and
comparing to NEMO data.

Begin by importing coast and other packages
```
import coast
```

And by defining some file paths. There are the example files that can be obtained with
the COAsT package:
```
fn_nemo_dat  = './example_files/COAsT_example_NEMO_data.nc'
fn_nemo_dom  = './example_files/COAsT_example_NEMO_domain.nc'
fn_altimetry = './example_files/COAsT_example_altimetry_data.nc'
```

We need to load in a NEMO object for doing NEMO things.
```
nemo = coast.NEMO(fn_nemo_dat, fn_nemo_dom, grid_ref='t-grid')
```

And now we can load in our ALTIMETRY data. By default, ALTIMETRY is set up
to read in CMEMS netCDF files. However, if no path is supplied, then the
object's dataset will be initialised as None. Custom data can then be loaded
if desired, as long as it follows the data formatting for ALTIMETRY.
```
altimetry = coast.ALTIMETRY(fn_altimetry)
```

Before going any further, lets just cut out the bit of the altimetry that
is over the model domain. This can be done using subset_indices_lonlat_box
to find relevant indices and then isel to extract them. The data has also
been thinned slightly.
```
ind = altimetry.subset_indices_lonlat_box([-10,10], [45,60])
ind = ind[::4]
altimetry = altimetry.isel(t_dim=ind)
```

Before comparing our observations to the model, we will interpolate a model
variable to the same time and geographical space as the altimetry. This is
done using the obs_operator() method:
```
altimetry.obs_operator(nemo, mod_var_name='ssh', time_interp='nearest')
```

Doing this has created a new interpolated variable called interp_ssh and
saved it back into our ALTIMETRY object. Take a look at altimetry.dataset
to see for yourself.

Next we will compare this interpolated variable to an observed variable
using some basic metrics. The basic_stats() routine can be used for this,
which calculates some simple metrics including differences, RMSE and
correlations. NOTE: This may not be a wise choice of variables.
```
stats = altimetry.basic_stats('interp_ssh', 'sla_filtered')
```

Take a look inside stats.dataset to see all of the new variables. When using
basic stats, the returned object is also an ALTIMETRY object, so all of the
same methods can be applied. Alternatively, if you want to save the new
metrics to the original altimetry object, set create_new_object = False.

Now we will do a more complex comparison using the Continuous Ranked
Probability Score (CRPS). For this, we need to hand over the model object,
a model variable and an observed variable. We also give it a neighbourhood
radius in km (nh_radius).
```
crps = altimetry.crps(nemo, model_var_name = 'ssh',
                      obs_var_name = 'sla_filtered', nh_radius = 20)
```

Again, take a look inside crps.dataset to see some new variables. Similarly
to basic_stats, create_new_object can be set to false to save output to
the original altimetry object.

ALTIMETRY has a ready built quick_plot() routine for taking a look at any
of the observed or derived quantities above. So to take a look at the
'sla_filtered' variable:
```
fig, ax = altimetry.quick_plot('sla_filtered')
```

As stats and crps are also ALTIMETRY objects, quick_plot() can also be used:
```
fig, ax = crps.quick_plot('crps')
fig, ax = stats.quick_plot('absolute_error')
```
