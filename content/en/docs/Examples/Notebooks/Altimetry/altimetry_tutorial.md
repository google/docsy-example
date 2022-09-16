---
    title: "Altimetry tutorial"
    linkTitle: "Altimetry tutorial"
    weight: 5

    description: >
        Altimetry tutorial example.
---
This is a demonstration script for using the Altimetry object in the COAsT package. This object has strict data formatting requirements, which are outlined in altimetry.py.

### Relevant imports and filepath configuration


```python
# Begin by importing coast and other packages
import coast

root = "./"
# And by defining some file paths
dn_files = root + "./example_files/"
fn_nemo_dat = dn_files + "coast_example_nemo_data.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
fn_nemo_config = root + "./config/example_nemo_grid_t.json"
fn_altimetry = dn_files + "coast_example_altimetry_data.nc"
fn_altimetry_config = root + "./config/example_altimetry.json"
```

### Load data


```python
# We need to load in a NEMO object for doing NEMO things.
nemo = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=fn_nemo_config)

# And now we can load in our Altimetry data. By default, Altimetry is set up
# to read in CMEMS netCDF files. However, if no path is supplied, then the
# object's dataset will be initialised as None. Custom data can then be loaded
# if desired, as long as it follows the data formatting for Altimetry.
# altimetry = coast.Altimetry(fn_altimetry)
altimetry = coast.Altimetry(fn_altimetry, config=fn_altimetry_config)
```

    ././config/example_altimetry.json
    Altimetry object at 0x563984dcbfc0 initialised


### Subsetting


```python
# Before going any further, lets just cut out the bit of the altimetry that
# is over the model domain. This can be done using `subset_indices_lonlat_box`
# to find relevant indices and then `isel` to extract them. The data here is then also
# also thinned slightly.
ind = altimetry.subset_indices_lonlat_box([-10, 10], [45, 60])
ind = ind[::4]
altimetry = altimetry.isel(t_dim=ind)
```

    Subsetting Altimetry object at 0x563984dcbfc0 indices in [-10, 10], [45, 60]


### Model interpolation


```python
# Before comparing our observations to the model, we will interpolate a model
# variable to the same time and geographical space as the altimetry. This is
# done using the obs_operator() method:
altimetry.obs_operator(nemo, mod_var_name="ssh", time_interp="nearest")

# Doing this has created a new interpolated variable called interp_ssh and
# saved it back into our Altimetry object. Take a look at altimetry.dataset
# to see for yourself.
```

    Interpolating Gridded object at 0x563984dcbfc0 "ssh" with time_interp "nearest"



```python
#altimetry.dataset # uncomment to print data object summary
```

### Interpolated vs observed


```python
# Next we will compare this interpolated variable to an observed variable
# using some basic metrics. The basic_stats() routine can be used for this,
# which calculates some simple metrics including differences, RMSE and
# correlations. NOTE: This may not be a wise choice of variables.
stats = altimetry.basic_stats("ocean_tide_standard_name", "interp_ssh")
```

    Altimetry object at 0x563984dcbfc0 initialised



```python
# Take a look inside stats.dataset to see all of the new variables. When using
# basic stats, the returned object is also an Altimetry object, so all of the
# same methods can be applied. Alternatively, if you want to save the new
# metrics to the original altimetry object, set 'create_new_object = False'.

#stats.dataset  # uncomment to print data object summary
```


```python
# Now we will do a more complex comparison using the Continuous Ranked
# Probability Score (CRPS). For this, we need to hand over the model object,
# a model variable and an observed variable. We also give it a neighbourhood
# radius in km (nh_radius).
crps = altimetry.crps(nemo, model_var_name="ssh", obs_var_name="ocean_tide_standard_name", nh_radius=20)

# Again, take a look inside `crps.dataset` to see some new variables. Similarly
# to basic_stats, `create_new_object` keyword arg can be set to `false` to save output to
# the original altimetry object.

#crps.dataset  # uncomment to print data object summary
```

    Altimetry object at 0x563984dcbfc0 initialised


### Plotting data


```python
# Altimetry has a ready built quick_plot() routine for taking a look at any
# of the observed or derived quantities above. So to take a look at the
# 'sla_filtered' variable:
fig, ax = altimetry.quick_plot("ocean_tide_standard_name")
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3775/1478867203.py in <cell line: 4>()
          2 # of the observed or derived quantities above. So to take a look at the
          3 # 'sla_filtered' variable:
    ----> 4 fig, ax = altimetry.quick_plot("ocean_tide_standard_name")
    

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/data/altimetry.py in quick_plot(self, color_var_str)
        155             title = "Altimetry observation locations"
        156         info("Drawing a quick plot...")
    --> 157         fig, ax = plot_util.geo_scatter(self.dataset.longitude, self.dataset.latitude, c=color_var, title=title)
        158         info("Plot ready, displaying!")
        159         return fig, ax


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/_utils/plot_util.py in geo_scatter(longitude, latitude, c, s, scatter_kwargs, coastline_kwargs, gridline_kwargs, figure_kwargs, title, figsize)
        280 
        281     ax = plt.subplot(111, projection=ccrs.PlateCarree())
    --> 282     sca = ax.scatter(longitude, y=latitude, c=c, s=s, zorder=100, **scatter_kwargs)
        283     coast = NaturalEarthFeature(category="physical", **coastline_kwargs)
        284     ax.add_feature(coast, edgecolor="gray")


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in wrapper(self, *args, **kwargs)
        308 
        309         kwargs['transform'] = transform
    --> 310         return func(self, *args, **kwargs)
        311     return wrapper
        312 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in scatter(self, *args, **kwargs)
       1545 
       1546         result = matplotlib.axes.Axes.scatter(self, *args, **kwargs)
    -> 1547         self.autoscale_view()
       1548         return result
       1549 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in autoscale_view(self, tight, scalex, scaley)
        852 
        853     def autoscale_view(self, tight=None, scalex=True, scaley=True):
    --> 854         matplotlib.axes.Axes.autoscale_view(self, tight=tight,
        855                                             scalex=scalex, scaley=scaley)
        856         # Limit the resulting bounds to valid area.


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in autoscale_view(self, tight, scalex, scaley)
       2970             # End of definition of internal function 'handle_single_axis'.
       2971 
    -> 2972         handle_single_axis(
       2973             scalex, self._shared_axes["x"], 'x', self.xaxis, self._xmargin,
       2974             x_stickies, self.set_xbound)


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in handle_single_axis(scale, shared_axes, name, axis, margin, stickies, set_bound)
       2967             if not self._tight:
       2968                 x0, x1 = locator.view_limits(x0, x1)
    -> 2969             set_bound(x0, x1)
       2970             # End of definition of internal function 'handle_single_axis'.
       2971 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in set_xbound(self, lower, upper)
       3564             lower, upper = lower
       3565 
    -> 3566         old_lower, old_upper = self.get_xbound()
       3567         if lower is None:
       3568             lower = old_lower


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in get_xbound(self)
       3536         invert_xaxis, xaxis_inverted
       3537         """
    -> 3538         left, right = self.get_xlim()
       3539         if left < right:
       3540             return left, right


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in get_xlim(self)
       3594         be greater than the *right* value.
       3595         """
    -> 3596         return tuple(self.viewLim.intervalx)
       3597 
       3598     def _validate_converted_limits(self, limit, convert):


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in viewLim(self)
        813     @property
        814     def viewLim(self):
    --> 815         self._unstale_viewLim()
        816         return self._viewLim
        817 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in _unstale_viewLim(self)
        808                 for ax in self._shared_axes[name].get_siblings(self):
        809                     ax._stale_viewlims[name] = False
    --> 810             self.autoscale_view(**{f"scale{name}": scale
        811                                    for name, scale in need_scale.items()})
        812 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in autoscale_view(self, tight, scalex, scaley)
        855                                             scalex=scalex, scaley=scaley)
        856         # Limit the resulting bounds to valid area.
    --> 857         if scalex and self._autoscaleXon:
        858             bounds = self.get_xbound()
        859             self.set_xbound(max(bounds[0], self.projection.x_limits[0]),


    AttributeError: 'GeoAxesSubplot' object has no attribute '_autoscaleXon'



    
![png](/COAsT/altimetry_tutorial_files/altimetry_tutorial_15_1.png)
    



```python
# As stats and crps are also Altimetry objects, quick_plot() can also be used:
# crps quick_plot:
fig, ax = crps.quick_plot("crps")
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3775/3088798311.py in <cell line: 3>()
          1 # As stats and crps are also Altimetry objects, quick_plot() can also be used:
          2 # crps quick_plot:
    ----> 3 fig, ax = crps.quick_plot("crps")
    

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/data/altimetry.py in quick_plot(self, color_var_str)
        155             title = "Altimetry observation locations"
        156         info("Drawing a quick plot...")
    --> 157         fig, ax = plot_util.geo_scatter(self.dataset.longitude, self.dataset.latitude, c=color_var, title=title)
        158         info("Plot ready, displaying!")
        159         return fig, ax


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/_utils/plot_util.py in geo_scatter(longitude, latitude, c, s, scatter_kwargs, coastline_kwargs, gridline_kwargs, figure_kwargs, title, figsize)
        280 
        281     ax = plt.subplot(111, projection=ccrs.PlateCarree())
    --> 282     sca = ax.scatter(longitude, y=latitude, c=c, s=s, zorder=100, **scatter_kwargs)
        283     coast = NaturalEarthFeature(category="physical", **coastline_kwargs)
        284     ax.add_feature(coast, edgecolor="gray")


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in wrapper(self, *args, **kwargs)
        308 
        309         kwargs['transform'] = transform
    --> 310         return func(self, *args, **kwargs)
        311     return wrapper
        312 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in scatter(self, *args, **kwargs)
       1545 
       1546         result = matplotlib.axes.Axes.scatter(self, *args, **kwargs)
    -> 1547         self.autoscale_view()
       1548         return result
       1549 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in autoscale_view(self, tight, scalex, scaley)
        852 
        853     def autoscale_view(self, tight=None, scalex=True, scaley=True):
    --> 854         matplotlib.axes.Axes.autoscale_view(self, tight=tight,
        855                                             scalex=scalex, scaley=scaley)
        856         # Limit the resulting bounds to valid area.


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in autoscale_view(self, tight, scalex, scaley)
       2970             # End of definition of internal function 'handle_single_axis'.
       2971 
    -> 2972         handle_single_axis(
       2973             scalex, self._shared_axes["x"], 'x', self.xaxis, self._xmargin,
       2974             x_stickies, self.set_xbound)


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in handle_single_axis(scale, shared_axes, name, axis, margin, stickies, set_bound)
       2967             if not self._tight:
       2968                 x0, x1 = locator.view_limits(x0, x1)
    -> 2969             set_bound(x0, x1)
       2970             # End of definition of internal function 'handle_single_axis'.
       2971 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in set_xbound(self, lower, upper)
       3564             lower, upper = lower
       3565 
    -> 3566         old_lower, old_upper = self.get_xbound()
       3567         if lower is None:
       3568             lower = old_lower


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in get_xbound(self)
       3536         invert_xaxis, xaxis_inverted
       3537         """
    -> 3538         left, right = self.get_xlim()
       3539         if left < right:
       3540             return left, right


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in get_xlim(self)
       3594         be greater than the *right* value.
       3595         """
    -> 3596         return tuple(self.viewLim.intervalx)
       3597 
       3598     def _validate_converted_limits(self, limit, convert):


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in viewLim(self)
        813     @property
        814     def viewLim(self):
    --> 815         self._unstale_viewLim()
        816         return self._viewLim
        817 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in _unstale_viewLim(self)
        808                 for ax in self._shared_axes[name].get_siblings(self):
        809                     ax._stale_viewlims[name] = False
    --> 810             self.autoscale_view(**{f"scale{name}": scale
        811                                    for name, scale in need_scale.items()})
        812 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in autoscale_view(self, tight, scalex, scaley)
        855                                             scalex=scalex, scaley=scaley)
        856         # Limit the resulting bounds to valid area.
    --> 857         if scalex and self._autoscaleXon:
        858             bounds = self.get_xbound()
        859             self.set_xbound(max(bounds[0], self.projection.x_limits[0]),


    AttributeError: 'GeoAxesSubplot' object has no attribute '_autoscaleXon'



    
![png](/COAsT/altimetry_tutorial_files/altimetry_tutorial_16_1.png)
    



```python
# stats quick_plot:
fig, ax = stats.quick_plot("absolute_error")
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3775/4195741849.py in <cell line: 2>()
          1 # stats quick_plot:
    ----> 2 fig, ax = stats.quick_plot("absolute_error")
    

    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/data/altimetry.py in quick_plot(self, color_var_str)
        155             title = "Altimetry observation locations"
        156         info("Drawing a quick plot...")
    --> 157         fig, ax = plot_util.geo_scatter(self.dataset.longitude, self.dataset.latitude, c=color_var, title=title)
        158         info("Plot ready, displaying!")
        159         return fig, ax


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/coast/_utils/plot_util.py in geo_scatter(longitude, latitude, c, s, scatter_kwargs, coastline_kwargs, gridline_kwargs, figure_kwargs, title, figsize)
        280 
        281     ax = plt.subplot(111, projection=ccrs.PlateCarree())
    --> 282     sca = ax.scatter(longitude, y=latitude, c=c, s=s, zorder=100, **scatter_kwargs)
        283     coast = NaturalEarthFeature(category="physical", **coastline_kwargs)
        284     ax.add_feature(coast, edgecolor="gray")


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in wrapper(self, *args, **kwargs)
        308 
        309         kwargs['transform'] = transform
    --> 310         return func(self, *args, **kwargs)
        311     return wrapper
        312 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in scatter(self, *args, **kwargs)
       1545 
       1546         result = matplotlib.axes.Axes.scatter(self, *args, **kwargs)
    -> 1547         self.autoscale_view()
       1548         return result
       1549 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in autoscale_view(self, tight, scalex, scaley)
        852 
        853     def autoscale_view(self, tight=None, scalex=True, scaley=True):
    --> 854         matplotlib.axes.Axes.autoscale_view(self, tight=tight,
        855                                             scalex=scalex, scaley=scaley)
        856         # Limit the resulting bounds to valid area.


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in autoscale_view(self, tight, scalex, scaley)
       2970             # End of definition of internal function 'handle_single_axis'.
       2971 
    -> 2972         handle_single_axis(
       2973             scalex, self._shared_axes["x"], 'x', self.xaxis, self._xmargin,
       2974             x_stickies, self.set_xbound)


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in handle_single_axis(scale, shared_axes, name, axis, margin, stickies, set_bound)
       2967             if not self._tight:
       2968                 x0, x1 = locator.view_limits(x0, x1)
    -> 2969             set_bound(x0, x1)
       2970             # End of definition of internal function 'handle_single_axis'.
       2971 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in set_xbound(self, lower, upper)
       3564             lower, upper = lower
       3565 
    -> 3566         old_lower, old_upper = self.get_xbound()
       3567         if lower is None:
       3568             lower = old_lower


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in get_xbound(self)
       3536         invert_xaxis, xaxis_inverted
       3537         """
    -> 3538         left, right = self.get_xlim()
       3539         if left < right:
       3540             return left, right


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in get_xlim(self)
       3594         be greater than the *right* value.
       3595         """
    -> 3596         return tuple(self.viewLim.intervalx)
       3597 
       3598     def _validate_converted_limits(self, limit, convert):


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in viewLim(self)
        813     @property
        814     def viewLim(self):
    --> 815         self._unstale_viewLim()
        816         return self._viewLim
        817 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/matplotlib/axes/_base.py in _unstale_viewLim(self)
        808                 for ax in self._shared_axes[name].get_siblings(self):
        809                     ax._stale_viewlims[name] = False
    --> 810             self.autoscale_view(**{f"scale{name}": scale
        811                                    for name, scale in need_scale.items()})
        812 


    /usr/share/miniconda/envs/coast-site/lib/python3.8/site-packages/cartopy/mpl/geoaxes.py in autoscale_view(self, tight, scalex, scaley)
        855                                             scalex=scalex, scaley=scaley)
        856         # Limit the resulting bounds to valid area.
    --> 857         if scalex and self._autoscaleXon:
        858             bounds = self.get_xbound()
        859             self.set_xbound(max(bounds[0], self.projection.x_limits[0]),


    AttributeError: 'GeoAxesSubplot' object has no attribute '_autoscaleXon'



    
![png](/COAsT/altimetry_tutorial_files/altimetry_tutorial_17_1.png)
    



```python

```
