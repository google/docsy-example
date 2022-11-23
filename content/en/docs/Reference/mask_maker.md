---
title: "Mask_maker"
linkTitle: "Mask_maker"
date: 2022-11-23
description: >
  Docstrings for the Mask_maker class
---
### Objects

[MaskMaker()](#maskmaker)<br />
[MaskMaker.make_mask_dataset()](#maskmakermake_mask_dataset)<br />
[MaskMaker.fill_polygon_by_index()](#maskmakerfill_polygon_by_index)<br />
[MaskMaker.fill_polygon_by_lonlat()](#maskmakerfill_polygon_by_lonlat)<br />
[MaskMaker.region_def_nws_north_sea()](#maskmakerregion_def_nws_north_sea)<br />
[MaskMaker.region_def_nws_outer_shelf()](#maskmakerregion_def_nws_outer_shelf)<br />
[MaskMaker.region_def_nws_norwegian_trench()](#maskmakerregion_def_nws_norwegian_trench)<br />
[MaskMaker.region_def_nws_english_channel()](#maskmakerregion_def_nws_english_channel)<br />
[MaskMaker.region_def_south_north_sea()](#maskmakerregion_def_south_north_sea)<br />
[MaskMaker.region_def_off_shelf()](#maskmakerregion_def_off_shelf)<br />
[MaskMaker.region_def_irish_sea()](#maskmakerregion_def_irish_sea)<br />
[MaskMaker.region_def_kattegat()](#maskmakerregion_def_kattegat)<br />
[MaskMaker.make_region_from_vertices()](#maskmakermake_region_from_vertices)<br />
[MaskMaker.quick_plot()](#maskmakerquick_plot)<br />

Mask maker
#### MaskMaker()
```python
class MaskMaker():
```

```
MaskMasker is a class of methods to assist with making regional masks within COAsT.
Presently these masks are external to MaskMaker.
It constructs a gridded boolean numpy array for each region, which are stacked over a dim_mask dimension and
stored as an xarray object.

A typical workflow might be:

    # Define vertices
    vertices_lon = [-5, -5, 5, 5]
    vertices_lat = [40, 60, 60, 40]

    # input lat/lon as xr.DataArray or numpy arrays. Return gridded boolean mask np.array on target grid
    filled = mm.make_region_from_vertices(
        sci.dataset.longitude, sci.dataset.latitude, vertices_lon, vertices_lat)

    # make xr.Dataset of masks from gridded mask array or list of mask arrays
    gridded_mask = mm.make_mask_dataset(sci.dataset.longitude.values,
                                     sci.dataset.latitude.values,
                                     filled)
    # quick plot
    mm.quick_plot(gridded_mask)


TO DO:
* Sort out region naming to be consistently applied and associated with the masks E.g. defined regions, or user defined masks
* Create final mask as a xr.DataArray, not a xr.Dataset
```

##### MaskMaker.make_mask_dataset()
```python
@staticmethod
def MaskMaker.make_mask_dataset(longitude, latitude, mask_list, mask_names=None):
```
> <br />
> create xr.Dataset for mask with latitude and longitude coordinates. If mask_names are given<br />
> create a dim_mask coordinate of names<br />
> <br />
##### MaskMaker.fill_polygon_by_index()
```python
@staticmethod
def MaskMaker.fill_polygon_by_index(array_to_fill, vertices_r, vertices_c, fill_value=1, additive=False):
```
> <br />
> Draws and fills a polygon onto an existing numpy array based on array<br />
> indices. To create a new mask, give np.zeros(shape) as input.<br />
> Polygon vertices are drawn in the order given.<br />
> <br />
> Parameters<br />
> ----------<br />
> array_to_fill (2D array): Array onto which to fill polygon<br />
> vertices_r (1D array): Row indices for polygon vertices<br />
> vertices_c (1D_array): Column indices for polygon vertices<br />
> fill_value (float, bool or int): Fill value for polygon (Default: 1)<br />
> additive (bool): If true, add fill value to existing array. Otherwise<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   indices will be overwritten. (Default: False)<br />
> <br />
> Returns<br />
> -------<br />
> Filled 2D array<br />
> <br />
##### MaskMaker.fill_polygon_by_lonlat()
```python
@staticmethod
def MaskMaker.fill_polygon_by_lonlat(array_to_fill, longitude, latitude, vertices_lon, vertices_lat, fill_value=1, additive=False):
```
> <br />
> Draws and fills a polygon onto an existing numpy array based on<br />
> vertices defined by longitude and latitude locations. This does NOT<br />
> draw a polygon on a sphere, but instead based on straight lines<br />
> between points. This is OK for small regional areas, but not advisable<br />
> for large and global regions.<br />
> Polygon vertices are drawn in the order given.<br />
> <br />
> Parameters<br />
> ----------<br />
> array_to_fill (2D array): Array onto which to fill polygon<br />
> vertices_r (1D array): Row indices for polygon vertices<br />
> vertices_c (1D_array): Column indices for polygon vertices<br />
> fill_value (float, bool or int): Fill value for polygon (Default: 1)<br />
> additive (bool): If true, add fill value to existing array. Otherwise<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   indices will be overwritten. (Default: False)<br />
> <br />
> Returns<br />
> -------<br />
> Filled 2D np.array<br />
> <br />
##### MaskMaker.region_def_nws_north_sea()
```python
@classmethod
def MaskMaker.region_def_nws_north_sea(cls, longitude, latitude, bath):
```
> <br />
> Regional definition for the North Sea (Northwest European Shelf)<br />
> Longitude, latitude and bath should be 2D arrays corresponding to model<br />
> coordinates and bathymetry. Bath should be positive with depth.<br />
> <br />
##### MaskMaker.region_def_nws_outer_shelf()
```python
@classmethod
def MaskMaker.region_def_nws_outer_shelf(cls, longitude, latitude, bath):
```
> <br />
> Regional definition for the Outer Shelf (Northwest European Shelf)<br />
> Longitude, latitude and bath should be 2D arrays corresponding to model<br />
> coordinates and bathymetry. Bath should be positive with depth.<br />
> <br />
##### MaskMaker.region_def_nws_norwegian_trench()
```python
@classmethod
def MaskMaker.region_def_nws_norwegian_trench(cls, longitude, latitude, bath):
```
> <br />
> Regional definition for the Norwegian Trench (Northwest European Shelf)<br />
> Longitude, latitude and bath should be 2D arrays corresponding to model<br />
> coordinates and bathymetry. Bath should be positive with depth.<br />
> <br />
##### MaskMaker.region_def_nws_english_channel()
```python
@classmethod
def MaskMaker.region_def_nws_english_channel(cls, longitude, latitude, bath):
```
> <br />
> Regional definition for the English Channel (Northwest European Shelf)<br />
> Longitude, latitude and bath should be 2D arrays corresponding to model<br />
> coordinates and bathymetry. Bath should be positive with depth.<br />
> <br />
##### MaskMaker.region_def_south_north_sea()
```python
@classmethod
def MaskMaker.region_def_south_north_sea(cls, longitude, latitude, bath):
```
> <br />
> None<br />
> <br />
##### MaskMaker.region_def_off_shelf()
```python
@classmethod
def MaskMaker.region_def_off_shelf(cls, longitude, latitude, bath):
```
> <br />
> None<br />
> <br />
##### MaskMaker.region_def_irish_sea()
```python
@classmethod
def MaskMaker.region_def_irish_sea(cls, longitude, latitude, bath):
```
> <br />
> None<br />
> <br />
##### MaskMaker.region_def_kattegat()
```python
@classmethod
def MaskMaker.region_def_kattegat(cls, longitude, latitude, bath):
```
> <br />
> None<br />
> <br />
##### MaskMaker.make_region_from_vertices()
```python
@classmethod
def MaskMaker.make_region_from_vertices(cls, longitude, latitude, vertices_lon, vertices_lat):
```
> <br />
> Construct mask on supplied longitude, latitude grid with input lists of lon and lat polygon vertices<br />
> :param longitude: np.array/xr.DataArray of longitudes on target grid<br />
> :param latitude: np.array/xr.DataArray of latitudes on target grid<br />
> :param vertices_lon: list of vertices for bounding polygon<br />
> :param vertices_lat: list of vertices for bounding polygon<br />
> :return: mask: np.array(boolean) on target grid. Ones are bound by polygon vertices<br />
> <br />
##### MaskMaker.quick_plot()
```python
@classmethod
def MaskMaker.quick_plot(cls, mask):
```
> <br />
> Plot a map of masks in the MaskMaker object<br />
> Add labels<br />
> <br />