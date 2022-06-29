---
title: "Coast"
linkTitle: "Coast"
date: 2022-06-29
description: >
  Docstrings for the Coast class
---
### Objects

[setup_dask_client()](#setup_dask_client)<br />
[Coast()](#coast)<br />
[Coast.load()](#coastload)<br />
[Coast.load_single()](#coastload_single)<br />
[Coast.load_multiple()](#coastload_multiple)<br />
[Coast.load_dataset()](#coastload_dataset)<br />
[Coast.set_dimension_mapping()](#coastset_dimension_mapping)<br />
[Coast.set_variable_mapping()](#coastset_variable_mapping)<br />
[Coast.set_grid_ref_attribute()](#coastset_grid_ref_attribute)<br />
[Coast.set_dimension_names()](#coastset_dimension_names)<br />
[Coast.set_variable_names()](#coastset_variable_names)<br />
[Coast.set_variable_grid_ref_attribute()](#coastset_variable_grid_ref_attribute)<br />
[Coast.copy()](#coastcopy)<br />
[Coast.isel()](#coastisel)<br />
[Coast.sel()](#coastsel)<br />
[Coast.rename()](#coastrename)<br />
[Coast.subset()](#coastsubset)<br />
[Coast.subset_as_copy()](#coastsubset_as_copy)<br />
[Coast.distance_between_two_points()](#coastdistance_between_two_points)<br />
[Coast.subset_indices_by_distance()](#coastsubset_indices_by_distance)<br />
[Coast.subset_indices_lonlat_box()](#coastsubset_indices_lonlat_box)<br />
[Coast.calculate_haversine_distance()](#coastcalculate_haversine_distance)<br />
[Coast.get_subset_as_xarray()](#coastget_subset_as_xarray)<br />
[Coast.get_2d_subset_as_xarray()](#coastget_2d_subset_as_xarray)<br />
[Coast.plot_simple_2d()](#coastplot_simple_2d)<br />
[Coast.plot_cartopy()](#coastplot_cartopy)<br />
[Coast.plot_movie()](#coastplot_movie)<br />

The coast class is the main access point into this package.
#### setup_dask_client()
```python

def setup_dask_client(workers=2, threads=2, memory_limit_per_worker=2GB):
```
> <br />
> None<br />
> <br />
#### Coast()
```python
class Coast():
```

```
None
```

##### Coast.load()
```python

def Coast.load(self, file_or_dir, chunks=None, multiple=False):
```
> <br />
> Loads a file into a COAsT object's dataset variable using xarray<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file_or_dir (str): file name, OPeNDAP accessor, or directory to multiple files.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (dict): Chunks to use in Dask [default None]<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  multiple (bool): If true, load in multiple files from directory.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   If false load a single file [default False]<br />
> <br />
##### Coast.load_single()
```python

def Coast.load_single(self, file, chunks=None):
```
> <br />
> Loads a single file into COAsT object's dataset variable.<br />
> <br />
##### Coast.load_multiple()
```python

def Coast.load_multiple(self, directory_to_files, chunks=None):
```
> <br />
> Loads multiple files from directory into dataset variable.<br />
> <br />
##### Coast.load_dataset()
```python

def Coast.load_dataset(self, dataset):
```
> <br />
> :param dataset: The dataset to use<br />
> :type dataset: xarray.Dataset<br />
> <br />
##### Coast.set_dimension_mapping()
```python

def Coast.set_dimension_mapping(self):
```
> <br />
> None<br />
> <br />
##### Coast.set_variable_mapping()
```python

def Coast.set_variable_mapping(self):
```
> <br />
> None<br />
> <br />
##### Coast.set_grid_ref_attribute()
```python

def Coast.set_grid_ref_attribute(self):
```
> <br />
> None<br />
> <br />
##### Coast.set_dimension_names()
```python

def Coast.set_dimension_names(self, dim_mapping):
```
> <br />
> Relabel dimensions in COAsT object xarray.dataset to ensure<br />
> consistent naming throughout the COAsT package.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  dim_mapping (dict): keys are dimension names to change and values<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  new dimension names<br />
> <br />
##### Coast.set_variable_names()
```python

def Coast.set_variable_names(self, var_mapping):
```
> <br />
> Relabel variables in COAsT object xarray.dataset to ensure<br />
> consistent naming throughout the COAsT package.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  var_mapping (dict): keys are variable names to change and values<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  are new variable names<br />
> <br />
##### Coast.set_variable_grid_ref_attribute()
```python

def Coast.set_variable_grid_ref_attribute(self, grid_ref_attr_mapping):
```
> <br />
> Set attributes for variables to access within package.<br />
> Set grid attributes to identify with grid variable is associated with.<br />
> <br />
##### Coast.copy()
```python

def Coast.copy(self):
```
> <br />
> None<br />
> <br />
##### Coast.isel()
```python

def Coast.isel(self, indexers=None, drop=False, **kwargs):
```
> <br />
> Indexes COAsT object along specified dimensions using xarray isel.<br />
> <b>Input is of same form as xarray.isel. Basic use, hand in either:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1. dictionary with keys = dimensions, values = indices<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  2. **kwargs of form dimension = indices<br />
> <br />
##### Coast.sel()
```python

def Coast.sel(self, indexers=None, drop=False, **kwargs):
```
> <br />
> Indexes COAsT object along specified dimensions using xarray sel.<br />
> <b>Input is of same form as xarray.sel. Basic use, hand in either:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1. Dictionary with keys = dimensions, values = indices<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  2. **kwargs of form dimension = indices<br />
> <br />
##### Coast.rename()
```python

def Coast.rename(self, rename_dict, **kwargs):
```
> <br />
> None<br />
> <br />
##### Coast.subset()
```python

def Coast.subset(self, **kwargs):
```
> <br />
> Subsets all variables within the dataset inside self (a COAsT object).<br />
> <b>Input is a set of keyword argument pairs of the form:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  dimension_name = indices<br />
> The entire object is then subsetted along this dimension at indices<br />
> <br />
##### Coast.subset_as_copy()
```python

def Coast.subset_as_copy(self, **kwargs):
```
> <br />
> Similar to COAsT.subset() however applies the subsetting to a copy of<br />
> the original COAsT object. This subsetted copy is then returned.<br />
> Useful for preserving the original object whilst creating smaller<br />
> subsetted object copies.<br />
> <br />
##### Coast.distance_between_two_points()
```python

def Coast.distance_between_two_points(self):
```
> <br />
> None<br />
> <br />
##### Coast.subset_indices_by_distance()
```python

def Coast.subset_indices_by_distance(self, centre_lon, centre_lat, radius):
```
> <br />
> This method returns a `tuple` of indices within the `radius` of the lon/lat point given by the user.<br />
> <br />
> Distance is calculated as haversine - see `self.calculate_haversine_distance`<br />
> <br />
> :param centre_lon: The longitude of the users central point<br />
> :param centre_lat: The latitude of the users central point<br />
> :param radius: The haversine distance (in km) from the central point<br />
> :return: All indices in a `tuple` with the haversine distance of the central point<br />
> <br />
##### Coast.subset_indices_lonlat_box()
```python

def Coast.subset_indices_lonlat_box(self, lonbounds, latbounds):
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
##### Coast.calculate_haversine_distance()
```python
@staticmethod
def Coast.calculate_haversine_distance(lon1, lat1, lon2, lat2):
```
> <br />
> # Estimation of geographical distance using the Haversine function.<br />
> # Input can be single values or 1D arrays of locations. This<br />
> # does NOT create a distance matrix but outputs another 1D array.<br />
> # This works for either location vectors of equal length OR a single loc<br />
> # and an arbitrary length location vector.<br />
> #<br />
> # lon1, lat1 :: Location(s) 1.<br />
> # lon2, lat2 :: Location(s) 2.<br />
> <br />
##### Coast.get_subset_as_xarray()
```python

def Coast.get_subset_as_xarray(self, var, points_x, points_y, line_length=None, time_counter=0):
```
> <br />
> This method gets a subset of the data across the x/y indices given for the chosen variable.<br />
> <br />
> Setting time_counter to None will treat `var` as only having 3 dimensions depth, y, x<br />
> <br />
> there is a check on `var` to see the size of the time_counter, if 1 then time_counter is fixed to index 0.<br />
> <br />
> :param var: the name of the variable to get data from<br />
> :param points_x: a list/array of indices for the x dimension<br />
> :param points_y: a list/array of indices for the y dimension<br />
> :param line_length: (Optional) the length of your subset (assuming simple line transect)  TODO This is unsued<br />
> :param time_counter: (Optional) which time slice to get data from, if None and the variable only has one a time<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   channel of length 1 then time_counter is fixed too an index of 0<br />
> :return: data across all depths for the chosen variable along the given indices<br />
> <br />
##### Coast.get_2d_subset_as_xarray()
```python

def Coast.get_2d_subset_as_xarray(self, var, points_x, points_y, line_length=None, time_counter=0):
```
> <br />
> <b>:param var:</b><br />
> <b>:param points_x:</b><br />
> <b>:param points_y:</b><br />
> <b>:param line_length:</b><br />
> <b>:param time_counter:</b><br />
> <b>:return:</b><br />
> <br />
##### Coast.plot_simple_2d()
```python

def Coast.plot_simple_2d(self, x, y, data, cmap, plot_info):
```
> <br />
> This is a simple method that will plot data in a 2d. It is a wrapper for matplotlib's 'pcolormesh' method.<br />
> <br />
> `cmap` and `plot_info` are required to run this method, `cmap` is passed directly to `pcolormesh`.<br />
> <br />
> `plot_info` contains all the required information for setting the figure;<br />
>  - ylim<br />
>  - xlim<br />
>  - clim<br />
>  - title<br />
>  - fig_size<br />
>  - ylabel<br />
> <br />
> :param x: The variable contain the x axis information<br />
> :param y: The variable contain the y axis information<br />
> :param data: the DataArray a user wishes to plot<br />
> <b>:param cmap:</b><br />
> <b>:param plot_info:</b><br />
> <b>:return:</b><br />
> <br />
##### Coast.plot_cartopy()
```python

def Coast.plot_cartopy(self, var, plot_var, params, time_counter=0):
```
> <br />
> None<br />
> <br />
##### Coast.plot_movie()
```python

def Coast.plot_movie(self):
```
> <br />
> None<br />
> <br />