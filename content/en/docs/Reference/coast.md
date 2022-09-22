---
title: "Coast"
linkTitle: "Coast"
date: 2022-09-22
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
> Loads a file into a COAsT object's dataset variable using xarray.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file_or_dir (str): file name, OPeNDAP accessor, or directory to multiple files.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (dict): Chunks to use in Dask [default None].<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  multiple (bool): If true, load in multiple files from directory. If false load a single file [default False].<br />
> <br />
##### Coast.load_single()
```python

def Coast.load_single(self, file, chunks=None):
```
> <br />
> Loads a single file into COAsT object's dataset variable.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file (str): Input file.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (Dict): Chunks to use in Dask [default None].<br />
> <br />
##### Coast.load_multiple()
```python

def Coast.load_multiple(self, directory_to_files, chunks=None):
```
> <br />
> Loads multiple files from directory into dataset variable.<br />
> <br />
> <b>Args:</b><br />
> <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  directory_to_files (str):</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (Dict): Chunks to use in Dask [default None].<br />
> <br />
##### Coast.load_dataset()
```python

def Coast.load_dataset(self, dataset):
```
> <br />
> Loads a dataset.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  dataset (xr.Dataset): Dataset to load.<br />
> <br />
##### Coast.set_dimension_mapping()
```python

def Coast.set_dimension_mapping(self):
```
> <br />
> Set mapping of dimensions.<br />
> <br />
##### Coast.set_variable_mapping()
```python

def Coast.set_variable_mapping(self):
```
> <br />
> Set mapping of variable.<br />
> <br />
##### Coast.set_grid_ref_attribute()
```python

def Coast.set_grid_ref_attribute(self):
```
> <br />
> Set grid reference attribute.<br />
> <br />
##### Coast.set_dimension_names()
```python

def Coast.set_dimension_names(self, dim_mapping):
```
> <br />
> Relabel dimensions in COAsT object xarray.dataset to ensure consistent naming throughout the COAsT package.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  dim_mapping (Dict): keys are dimension names to change and values new dimension names.<br />
> <br />
##### Coast.set_variable_names()
```python

def Coast.set_variable_names(self, var_mapping):
```
> <br />
> Relabel variables in COAsT object xarray.dataset to ensure consistent naming throughout the COAsT package.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  var_mapping (Dict): keys are variable names to change and values are new variable names<br />
> <br />
##### Coast.set_variable_grid_ref_attribute()
```python

def Coast.set_variable_grid_ref_attribute(self, grid_ref_attr_mapping):
```
> <br />
> Set attributes for variables to access within package and set grid attributes to identify which grid variable is associated with.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  grid_ref_attr_mapping (Dict): Dict containing mappings.<br />
> <br />
##### Coast.copy()
```python

def Coast.copy(self):
```
> <br />
> Method to copy self.<br />
> <br />
##### Coast.isel()
```python

def Coast.isel(self, indexers=None, drop=False, **kwargs):
```
> <br />
> Indexes COAsT object along specified dimensions using xarray isel.<br />
> <br />
> <b>Input is of same form as xarray.isel. Basic use, hand in either:</b><br />
> 1. dictionary with keys = dimensions, values = indices<br />
> 2. **kwargs of form dimension = indices.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  indexers (Dict): A dict with keys matching dimensions and values given by integers, slice objects or arrays.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  drop (bool): If drop=True, drop coordinates variables indexed by integers instead of making them scalar.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **kwargs (Any): The keyword arguments form of indexers. One of indexers or indexers_kwargs must be provided.<br />
> <br />
##### Coast.sel()
```python

def Coast.sel(self, indexers=None, drop=False, **kwargs):
```
> <br />
> Indexes COAsT object along specified dimensions using xarray sel.<br />
> <br />
> <b>Input is of same form as xarray.sel. Basic use, hand in either:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1. Dictionary with keys = dimensions, values = indices<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  2. **kwargs of form dimension = indices<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  indexers (Dict): A dict with keys matching dimensions and values given by scalars, slices or arrays of tick labels.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  drop (bool): If drop=True, drop coordinates variables in indexers instead of making them scalar.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **kwargs (Any): The keyword arguments form of indexers. One of indexers or indexers_kwargs must be provided.<br />
> <br />
##### Coast.rename()
```python

def Coast.rename(self, rename_dict, **kwargs):
```
> <br />
> Rename dataset.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  rename_dict (Dict): Dictionary whose keys are current variable or dimension names and whose values are the desired names.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **kwargs (Any): Keyword form of name_dict. One of name_dict or names must be provided.<br />
> <br />
##### Coast.subset()
```python

def Coast.subset(self, **kwargs):
```
> <br />
> Subsets all variables within the dataset inside self (a COAsT object).<br />
> <br />
> Input is a set of keyword argument pairs of the form: dimension_name = indices.<br />
> The entire object is then subsetted along this dimension at indices<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **kwargs (Any): The keyword arguments form of indexers. One of indexers or indexers_kwargs must be provided.<br />
> <br />
##### Coast.subset_as_copy()
```python

def Coast.subset_as_copy(self, **kwargs):
```
> <br />
> Similar to COAsT.subset() however applies the subsetting to a copy of the original COAsT object.<br />
> <br />
> This subsetted copy is then returned.Useful for preserving the original object whilst creating smaller subsetted object copies.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **kwargs (Any): The keyword arguments form of indexers. One of indexers or indexers_kwargs must be provided.<br />
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
> Distance is calculated as haversine - see `self.calculate_haversine_distance`.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  centre_lon (float): The longitude of the users central point.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  centre_lat (float): The latitude of the users central point.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  radius (float): The haversine distance (in km) from the central point.<br />
> <br />
> <b>Return:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Tuple[xr.DataArray, xr.DataArray]: All indices in a `tuple` with the haversine distance of the central point.<br />
> <br />
##### Coast.subset_indices_lonlat_box()
```python

def Coast.subset_indices_lonlat_box(self, lonbounds, latbounds):
```
> <br />
> Generates array indices for data which lies in a given lon/lat box.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  lonbounds: Longitude boundaries. List of form [min_longitude=-180, max_longitude=180].<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  latbounds: Latitude boundaries. List of form [min_latitude, max_latitude].<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  np.ndarray: Indices corresponding to datapoints inside specified box.<br />
> <br />
##### Coast.calculate_haversine_distance()
```python
@staticmethod
def Coast.calculate_haversine_distance(lon1, lat1, lon2, lat2):
```
> <br />
> Estimation of geographical distance using the Haversine function.<br />
> <br />
> Input can be single values or 1D arrays of locations. This does NOT create a distance matrix but outputs another 1D array.<br />
> This works for either location vectors of equal length OR a single location and an arbitrary length location vector.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  lon1 (Any): Angles in degrees.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  lat1 (Any): Angles in degrees.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  lon2 (Any): Angles in degrees.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  lat2 (Any): Angles in degrees.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  float: Haversine distance between points.<br />
> <br />
##### Coast.get_subset_as_xarray()
```python

def Coast.get_subset_as_xarray(self, var, points_x, points_y, line_length=None, time_counter=0):
```
> <br />
> This method gets a subset of the data across the x/y indices given for the chosen variable.<br />
> <br />
> Setting time_counter to None will treat `var` as only having 3 dimensions depth, y, x<br />
> there is a check on `var` to see the size of the time_counter, if 1 then time_counter is fixed to index 0.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  var (str): The name of the variable to get data from.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  points_x (slice): A list/array of indices for the x dimension.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  points_y (slice): A list/array of indices for the y dimension.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  line_length (int): The length of your subset (assuming simple line transect). TODO This is unused.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  time_counter (int): Which time slice to get data from, if None and the variable only has one a time<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  channel of length 1 then time_counter is fixed too an index of 0.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  xr.DataArray: Data across all depths for the chosen variable along the given indices.<br />
> <br />
##### Coast.get_2d_subset_as_xarray()
```python

def Coast.get_2d_subset_as_xarray(self, var, points_x, points_y, line_length=None, time_counter=0):
```
> <br />
> Get 2d subset as an xarray.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  var (str): Member of dataset.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  points_x (slice): Keys matching dimensions.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  points_y (slice): Keys matching dimensions.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  line_length (int): Unused.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  time_counter (int): Time counter.<br />
> <br />
> <b>Return:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  xr.Dataset: Subset.<br />
> <br />
##### Coast.plot_simple_2d()
```python

def Coast.plot_simple_2d(self, x, y, data, cmap, plot_info):
```
> <br />
> This is a simple method that will plot data in a 2d. It is a wrapper for matplotlib's 'pcolormesh' method.<br />
> <br />
> `cmap` and `plot_info` are required to run this method, `cmap` is passed directly to `pcolormesh`.<br />
> `plot_info` contains all the required information for setting the figure;<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  - ylim<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  - xlim<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  - clim<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  - title<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  - fig_size<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  - ylabel<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  x (xr.Variable): The variable contain the x axis information.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  y (xr.Variable): The variable contain the y axis information.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  data (xr.DataArray): the DataArray a user wishes to plot.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  cmap (matplotlib.cm): Matplotlib color map.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  plot_info (Dict): Dict containing all the required information for setting the figure.<br />
> <br />
##### Coast.plot_cartopy()
```python

def Coast.plot_cartopy(self, var, plot_var, params, time_counter=0):
```
> <br />
> Plot cartopy.<br />
> <br />
##### Coast.plot_movie()
```python

def Coast.plot_movie(self):
```
> <br />
> Plot movie.<br />
> <br />