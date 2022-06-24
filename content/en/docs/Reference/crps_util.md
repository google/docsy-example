---
title: "Crps_util"
linkTitle: "Crps_util"
date: 2022-06-24
description: >
  Docstrings for the Crps_util class
---
### Objects

[crps_empirical()](#crps_empirical)<br />
[crps_empirical.calc()](#crps_empiricalcalc)<br />
[crps_empirical_loop()](#crps_empirical_loop)<br />
[crps_empirical_loop.calc()](#crps_empirical_loopcalc)<br />
[crps_sonf_fixed()](#crps_sonf_fixed)<br />
[crps_sonf_moving()](#crps_sonf_moving)<br />

Python definitions used to aid in the calculation of Continuous Ranked
Probability Score.
*Methods Overview*
    -> crps_sonf_fixed(): Single obs neighbourhood forecast CRPS for fixed obs
    -> crps_song_moving(): Same as above for moving obs
#### crps_empirical()
```python

def crps_empirical(sample, obs):
```
> <br />
> Calculates CRPS for a single observations against a sample of values.<br />
> This sample of values may be an ensemble of model forecasts or a model<br />
> neighbourhood. This is a comparison of a Heaviside function defined by<br />
> the observation value and an Empirical Distribution Function (EDF)<br />
> defined by the sample of values. This sample is sorted to create the<br />
> EDF.<br />
> <br />
> The calculation method is that outlined by Hersbach et al. (2000).<br />
> Each member of a supplied sample is weighted equally.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  sample (array): Array of points (ensemble or neighbourhood)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  xa (float): A single 'observation' value which to compare against<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  sample CDF.<br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  A single CRPS value.<br />
> <br />
##### crps_empirical.calc()
```python

def crps_empirical.calc(alpha, beta, p):
```
> <br />
> None<br />
> <br />
#### crps_empirical_loop()
```python

def crps_empirical_loop(sample, obs):
```
> <br />
> Like crps_empirical, however a loop is used instead of numpy<br />
> boolean indexing. For large samples, will be slower but consume less<br />
> memory.<br />
> <br />
##### crps_empirical_loop.calc()
```python

def crps_empirical_loop.calc(alpha, beta, p):
```
> <br />
> None<br />
> <br />
#### crps_sonf_fixed()
```python

def crps_sonf_fixed(mod_array, obs_lon, obs_lat, obs_var, obs_time, nh_radius, time_interp):
```
> <br />
> Handles the calculation of single-observation neighbourhood forecast CRPS<br />
> for a time series at a fixed observation location. Differs from<br />
> crps_sonf_moving in that it only need calculate a model neighbourhood once.<br />
> Parameters<br />
> ----------<br />
> mod_array   : (xarray DataArray) DataArray from a Model Dataset<br />
> obs_lon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : (float) Longitude of fixed observation point<br />
> obs_lat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : (float) Latitude of fixed observation point<br />
> obs_var&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : (array) of floatArray of variable values, e.g time series<br />
> obs_time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : (array) of datetimeArray of times, corresponding to obs_var<br />
> nh_radius   : (float) Neighbourhood radius in km<br />
> time_interp : (str) Type of time interpolation to use<br />
> Returns<br />
> -------<br />
> crps_list&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : Array of CRPS values<br />
> n_model_pts   : Array containing the number of model points used for<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  each CRPS value<br />
> contains_land : Array of bools indicating where a model neighbourhood<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  contained land.<br />
> <br />
#### crps_sonf_moving()
```python

def crps_sonf_moving(mod_array, obs_lon, obs_lat, obs_var, obs_time, nh_radius, time_interp, obs_batch=10):
```
> <br />
> Handles the calculation of single-observation neighbourhood forecast CRPS<br />
> for a moving observation instrument. Differs from crps_sonf_fixed in that<br />
> latitude and longitude are arrays of locations. Mod_array must contain<br />
> dimensions x_dim, y_dim and t_dim and coordinates longitude, latitude,<br />
> time.<br />
> Parameters<br />
> ----------<br />
> mod_array   : (xarray DataArray) DataArray from a Model Dataset<br />
> obs_lon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : (1Darray) Longitudes of fixed observation point<br />
> obs_lat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : (1Darray) Latitudes of fixed observation point<br />
> obs_var&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : (1Darray) of floatArray of variable values, e.g time series<br />
> obs_time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : (1Darray) of datetimeArray of times, corresponding to obs_var<br />
> nh_radius   : (float) Neighbourhood radius in km<br />
> time_interp : (str) Type of time interpolation to use<br />
> Returns<br />
> -------<br />
> crps_list&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : Array of CRPS values<br />
> n_model_pts   : Array containing the number of model points used for<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  each CRPS value<br />
> contains_land : Array of bools indicating where a model neighbourhood<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  contained land.<br />
> <br />