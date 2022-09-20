---
title: "Altimetry"
linkTitle: "Altimetry"
date: 2022-09-20
description: >
  Docstrings for the Altimetry class
---
### Objects

[Altimetry()](#altimetry)<br />
[Altimetry.read_cmems()](#altimetryread_cmems)<br />
[Altimetry.load()](#altimetryload)<br />
[Altimetry.load_single()](#altimetryload_single)<br />
[Altimetry.load_multiple()](#altimetryload_multiple)<br />
[Altimetry.subset_indices_lonlat_box()](#altimetrysubset_indices_lonlat_box)<br />
[Altimetry.quick_plot()](#altimetryquick_plot)<br />
[Altimetry.obs_operator()](#altimetryobs_operator)<br />
[Altimetry.crps()](#altimetrycrps)<br />
[Altimetry.difference()](#altimetrydifference)<br />
[Altimetry.absolute_error()](#altimetryabsolute_error)<br />
[Altimetry.mean_absolute_error()](#altimetrymean_absolute_error)<br />
[Altimetry.root_mean_square_error()](#altimetryroot_mean_square_error)<br />
[Altimetry.time_mean()](#altimetrytime_mean)<br />
[Altimetry.time_std()](#altimetrytime_std)<br />
[Altimetry.time_correlation()](#altimetrytime_correlation)<br />
[Altimetry.time_covariance()](#altimetrytime_covariance)<br />
[Altimetry.basic_stats()](#altimetrybasic_stats)<br />

Altimetry class
#### Altimetry()
```python
class Altimetry(Track):
```

```
An object for reading, storing and manipulating altimetry data.
Currently the object contains functionality for reading altimetry netCDF
data from the CMEMS database. This is the default for initialisation.

Data should be stored in an xarray.Dataset, in the form:

* Date Format Overview *

    1. A single dimension (time).
    2. Three coordinates: time, latitude, longitude. All lie on the 'time'
       dimension.
    3. Observed variable DataArrays on the time dimension.

There are currently no naming conventions for the variables however
examples from the CMEMS database include sla_filtered, sla_unfiltered and
mdt (mean dynamic topography).

* Methods Overview *

    *Initialisation and File Reading*
    -> __init__(): Initialises an ALTIMETRY object.
    -> read_cmems(): Reads data from a CMEMS netCDF file.

    *Plotting*
    -> quick_plot(): Makes a quick along-track plot of specified data.

    *Model Comparison*
    -> obs_operator(): For interpolating model data to this object.
    -> cprs(): Calculates the CRPS between a model and obs variable.
    -> difference(): Differences two specified variables
    -> absolute_error(): Absolute difference, two variables
    -> mean_absolute_error(): MAE between two variables
    -> root_mean_square_error(): RMSE between two variables
    -> time_mean(): Mean of a variable in time
    -> time_std(): St. Dev of a variable in time
    -> time_correlation(): Correlation between two variables
    -> time_covariance(): Covariance between two variables
    -> basic_stats(): Calculates multiple of the above metrics.
```

##### Altimetry.read_cmems()
```python

def Altimetry.read_cmems(self, file_path, multiple):
```
> <br />
> Read file.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file_path (str): path to data file<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  multiple (boolean): True if reading multiple files otherwise False<br />
> <br />
##### Altimetry.load()
```python

def Altimetry.load(self, file_or_dir, chunks=None, multiple=False):
```
> <br />
> Loads a file into a object's dataset variable using xarray<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file_or_dir (str) : file name or directory to multiple files.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (dict)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : Chunks to use in Dask [default None]<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  multiple (bool)   : If true, load in multiple files from directory.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  If false load a single file [default False]<br />
> <br />
##### Altimetry.load_single()
```python

def Altimetry.load_single(self, file, chunks=None):
```
> <br />
> Loads a single file into object's dataset variable.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file (str) : file name or directory to multiple files.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (dict) : Chunks to use in Dask [default None]<br />
> <br />
##### Altimetry.load_multiple()
```python

def Altimetry.load_multiple(self, directory_to_files, chunks=None):
```
> <br />
> Loads multiple files from directory into dataset variable.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  directory_to_files (str) : directory path to multiple files.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (dict) : Chunks to use in Dask [default None]<br />
> <br />
##### Altimetry.subset_indices_lonlat_box()
```python

def Altimetry.subset_indices_lonlat_box(self, lonbounds, latbounds):
```
> <br />
> Generates array indices for data which lies in a given lon/lat box.<br />
> <br />
> <b>Keyword arguments:</b><br />
> lon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     -- Longitudes, 1D or 2D.<br />
> lat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     -- Latitudes, 1D or 2D<br />
> lonbounds -- Array of form [min_longitude=-180, max_longitude=180]<br />
> latbounds -- Array of form [min_latitude, max_latitude]<br />
> <br />
> return: Indices corresponding to datapoints inside specified box<br />
> <br />
##### Altimetry.quick_plot()
```python

def Altimetry.quick_plot(self, color_var_str=None):
```
> <br />
> Quick plot<br />
> <br />
##### Altimetry.obs_operator()
```python

def Altimetry.obs_operator(self, model, mod_var_name, time_interp=nearest, model_mask=None):
```
> <br />
> For interpolating a model dataarray onto altimetry locations and times.<br />
> <br />
> <b>For ALTIMETRY, the interpolation is done independently in two steps:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1. Horizontal space<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  2. Time<br />
> Model data is taken at the surface if necessary (0 index).<br />
> <br />
> <b>Example usage:</b><br />
> --------------<br />
> altimetry.obs_operator(nemo_obj, 'sossheig')<br />
> <br />
> Parameters<br />
> ----------<br />
> model : model object (e.g. NEMO)<br />
> mod_var: variable name string to use from model object<br />
> time_interp: time interpolation method (optional, default: 'nearest')<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  This can take any string scipy.interpolate would take. e.g.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  'nearest', 'linear' or 'cubic'<br />
> model_mask : Mask to apply to model data in geographical interpolation<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   of model. For example, use to ignore land points.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   If None, no mask is applied. If 'bathy', model variable<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   (bathymetry==0) is used. Custom 2D mask arrays can be<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   supplied.<br />
> Returns<br />
> -------<br />
> Adds a DataArray to self.dataset, containing interpolated values.<br />
> <br />
##### Altimetry.crps()
```python

def Altimetry.crps(self, model_object, model_var_name, obs_var_name, nh_radius=20, time_interp=linear, create_new_object=True):
```
> <br />
> Comparison of observed variable to modelled using the Continuous<br />
> Ranked Probability Score. This is done using this ALTIMETRY object.<br />
> This method specifically performs a single-observation neighbourhood-<br />
> forecast method.<br />
> <br />
> Parameters<br />
> ----------<br />
> model_object (model) : Model object (NEMO) containing model data<br />
> model_var_name (str) : Name of model variable to compare.<br />
> obs_var_name (str)   : Name of observed variable to compare.<br />
> nh_radius (float)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : Neighbourhood radius (km)<br />
> time_interp (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : Type of time interpolation to use (s)<br />
> create_new_obj (bool): If True, save output to new ALTIMETRY obj.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Otherwise, save to this obj.<br />
> <br />
> Returns<br />
> -------<br />
> xarray.Dataset containing times, sealevel and quality control flags<br />
> <br />
> Example Usage<br />
> -------<br />
> # Compare modelled 'sossheig' with 'sla_filtered' using CRPS<br />
> crps = altimetry.crps(nemo, 'sossheig', 'sla_filtered')<br />
> <br />
##### Altimetry.difference()
```python

def Altimetry.difference(self, var_str0, var_str1, date0=None, date1=None):
```
> <br />
> Difference two variables defined by var_str0 and var_str1 between<br />
> two dates date0 and date1. Returns xr.DataArray<br />
> <br />
##### Altimetry.absolute_error()
```python

def Altimetry.absolute_error(self, var_str0, var_str1, date0=None, date1=None):
```
> <br />
> Absolute difference two variables defined by var_str0 and var_str1<br />
> between two dates date0 and date1. Return xr.DataArray<br />
> <br />
##### Altimetry.mean_absolute_error()
```python

def Altimetry.mean_absolute_error(self, var_str0, var_str1, date0=None, date1=None):
```
> <br />
> Mean absolute difference two variables defined by var_str0 and<br />
> var_str1 between two dates date0 and date1. Return xr.DataArray<br />
> <br />
##### Altimetry.root_mean_square_error()
```python

def Altimetry.root_mean_square_error(self, var_str0, var_str1, date0=None, date1=None):
```
> <br />
> Root mean square difference two variables defined by var_str0 and<br />
> var_str1 between two dates date0 and date1. Return xr.DataArray<br />
> <br />
##### Altimetry.time_mean()
```python

def Altimetry.time_mean(self, var_str, date0=None, date1=None):
```
> <br />
> Time mean of variable var_str between dates date0, date1<br />
> <br />
##### Altimetry.time_std()
```python

def Altimetry.time_std(self, var_str, date0=None, date1=None):
```
> <br />
> Time st. dev of variable var_str between dates date0 and date1<br />
> <br />
##### Altimetry.time_correlation()
```python

def Altimetry.time_correlation(self, var_str0, var_str1, date0=None, date1=None, method=pearson):
```
> <br />
> Time correlation between two variables defined by var_str0,<br />
> var_str1 between dates date0 and date1. Uses Pandas corr().<br />
> <br />
##### Altimetry.time_covariance()
```python

def Altimetry.time_covariance(self, var_str0, var_str1, date0=None, date1=None):
```
> <br />
> Time covariance between two variables defined by var_str0,<br />
> var_str1 between dates date0 and date1. Uses Pandas corr().<br />
> <br />
##### Altimetry.basic_stats()
```python

def Altimetry.basic_stats(self, var_str0, var_str1, date0=None, date1=None, create_new_object=True):
```
> <br />
> Calculates a selection of statistics for two variables defined by<br />
> var_str0 and var_str1, between dates date0 and date1. This will return<br />
> their difference, absolute difference, mean absolute error, root mean<br />
> square error, correlation and covariance. If create_new_object is True<br />
> then this method returns a new ALTIMETRY object containing statistics,<br />
> otherwise variables are saved to the dateset inside this object.<br />
> <br />