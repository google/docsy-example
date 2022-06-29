---
title: "Mask_maker"
linkTitle: "Mask_maker"
date: 2022-06-29
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

Mask maker
#### MaskMaker()
```python
class MaskMaker():
```

```
None
```

##### MaskMaker.make_mask_dataset()
```python
@staticmethod
def MaskMaker.make_mask_dataset(longitude, latitude, mask_list):
```
> <br />
> None<br />
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
> Filled 2D array<br />
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
> Regional definition for the Outher Shelf (Northwest European Shelf)<br />
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