---
title: "General_utils"
linkTitle: "General_utils"
date: 2022-06-28
description: >
  Docstrings for the General_utils class
---
### Objects

[determine_season()](#determine_season)<br />
[subset_indices_by_distance_balltree()](#subset_indices_by_distance_balltree)<br />
[subset_indices_by_distance()](#subset_indices_by_distance)<br />
[compare_angles()](#compare_angles)<br />
[cartesian_to_polar()](#cartesian_to_polar)<br />
[polar_to_cartesian()](#polar_to_cartesian)<br />
[subset_indices_lonlat_box()](#subset_indices_lonlat_box)<br />
[calculate_haversine_distance()](#calculate_haversine_distance)<br />
[remove_indices_by_mask()](#remove_indices_by_mask)<br />
[reinstate_indices_by_mask()](#reinstate_indices_by_mask)<br />
[nearest_indices_2d()](#nearest_indices_2d)<br />
[data_array_time_slice()](#data_array_time_slice)<br />
[day_of_week()](#day_of_week)<br />

A general utility file.
#### determine_season()
```python

def determine_season(t):
```
> <br />
> Determine season (or array of seasons) from a time (Datetime or xarray)<br />
> object. Put in an array of times, get out an array of seasons.<br />
> <br />
#### subset_indices_by_distance_balltree()
```python

def subset_indices_by_distance_balltree(longitude, latitude, centre_lon, centre_lat, radius, mask=None):
```
> <br />
> Returns the indices of points that lie within a specified radius (km) of<br />
> central latitude and longitudes. This makes use of BallTree.query_radius.<br />
> <br />
> Parameters<br />
> ----------<br />
> longitude   : (numpy.ndarray) longitudes in degrees<br />
> latitude&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : (numpy.ndarray) latitudes in degrees<br />
> centre_lon  : Central longitude. Can be single value or array of values<br />
> centre_lat  : Central latitude. Can be single value or array of values<br />
> radius&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    : (float) Radius in km within which to find indices<br />
> mask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : (numpy.ndarray) of same dimension as longitude and latitude.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    If specified, will mask out points from the routine.<br />
> Returns<br />
> -------<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Returns an array of indices corresponding to points within radius.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  If more than one central location is specified, this will be a list<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  of index arrays. Each element of which corresponds to one centre.<br />
> <b>If longitude is 1D:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Returns one array of indices per central location<br />
> <b>If longitude is 2D:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Returns arrays of x and y indices per central location.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ind_y corresponds to row indices of the original input arrays.<br />
> <br />
#### subset_indices_by_distance()
```python

def subset_indices_by_distance(longitude, latitude, centre_lon, centre_lat, radius):
```
> <br />
> This method returns a `tuple` of indices within the `radius` of the<br />
> lon/lat point given by the user.<br />
> Scikit-learn BallTree is used to obtain indices.<br />
> :param longitude: The longitude of the users central point<br />
> :param latitude: The latitude of the users central point<br />
> :param radius: The haversine distance (in km) from the central point<br />
> :return: All indices in a `tuple` with the haversine distance of the<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  central point<br />
> <br />
#### compare_angles()
```python

def compare_angles(a1, a2, degrees=True):
```
> <br />
> # Compares the difference between two angles. e.g. it is 2 degrees between<br />
> # 359 and 1 degree. If degrees = False then will treat angles as radians.<br />
> <br />
#### cartesian_to_polar()
```python

def cartesian_to_polar(x, y, degrees=True):
```
> <br />
> # Conversion of cartesian to polar coordinate system<br />
> # Output theta is in radians<br />
> <br />
#### polar_to_cartesian()
```python

def polar_to_cartesian(r, theta, degrees=True):
```
> <br />
> # Conversion of polar to cartesian coordinate system<br />
> # Input theta must be in radians<br />
> <br />
#### subset_indices_lonlat_box()
```python

def subset_indices_lonlat_box(array_lon, array_lat, lon_min, lon_max, lat_min, lat_max):
```
> <br />
> None<br />
> <br />
#### calculate_haversine_distance()
```python

def calculate_haversine_distance(lon1, lat1, lon2, lat2):
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
#### remove_indices_by_mask()
```python

def remove_indices_by_mask(array, mask):
```
> <br />
> Removes indices from a 2-dimensional array, A, based on true elements of<br />
> mask. A and mask variable should have the same shape.<br />
> <br />
#### reinstate_indices_by_mask()
```python

def reinstate_indices_by_mask(array_removed, mask, fill_value=unknown):
```
> <br />
> Rebuilds a 2D array from a 1D array created using remove_indices_by_mask().<br />
> False elements of mask will be populated using array_removed. MAsked<br />
> indices will be replaced with fill_value<br />
> <br />
#### nearest_indices_2d()
```python

def nearest_indices_2d(mod_lon, mod_lat, new_lon, new_lat, mask=None):
```
> <br />
> Obtains the 2 dimensional indices of the nearest model points to specified<br />
> lists of longitudes and latitudes. Makes use of sklearn.neighbours<br />
> and its BallTree haversine method. Ensure there are no NaNs in<br />
> input longitude/latitude arrays (or mask them using "mask"")<br />
> <br />
> Example Usage<br />
> ----------<br />
> # Get indices of model points closest to altimetry points<br />
> ind_x, ind_y = nemo.nearest_indices(altimetry.dataset.longitude,<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  altimetry.dataset.latitude)<br />
> # Nearest neighbour interpolation of model dataset to these points<br />
> interpolated = nemo.dataset.isel(x_dim = ind_x, y_dim = ind_y)<br />
> <br />
> Parameters<br />
> ----------<br />
> mod_lon (2D array): Model longitude (degrees) array (2-dimensional)<br />
> mod_lat (2D array): Model latitude (degrees) array (2-dimensions)<br />
> new_lon (1D array): Array of longitudes (degrees) to compare with model<br />
> new_lat (1D array): Array of latitudes (degrees) to compare with model<br />
> mask (2D array): Mask array. Where True (or 1), elements of array will<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   not be included. For example, use to mask out land in<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   case it ends up as the nearest point.<br />
> <br />
> Returns<br />
> -------<br />
> Array of x indices, Array of y indices<br />
> <br />
#### data_array_time_slice()
```python

def data_array_time_slice(data_array, date0, date1):
```
> <br />
> Takes an xr.DataArray object and returns a new object with times<br />
> sliced between dates date0 and date1. date0 and date1 may be a string or<br />
> datetime type object.<br />
> <br />
#### day_of_week()
```python

def day_of_week(date=None):
```
> <br />
> Return the day of the week (3 letter str)<br />
> <br />