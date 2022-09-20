---
title: "Profile_analysis"
linkTitle: "Profile_analysis"
date: 2022-09-20
description: >
  Docstrings for the Profile_analysis class
---
### Objects

[ProfileAnalysis()](#profileanalysis)<br />
[ProfileAnalysis.depth_means()](#profileanalysisdepth_means)<br />
[ProfileAnalysis.bottom_means()](#profileanalysisbottom_means)<br />
[ProfileAnalysis.determine_mask_indices()](#profileanalysisdetermine_mask_indices)<br />
[ProfileAnalysis.mask_means()](#profileanalysismask_means)<br />
[ProfileAnalysis.difference()](#profileanalysisdifference)<br />
[ProfileAnalysis.interpolate_vertical()](#profileanalysisinterpolate_vertical)<br />
[ProfileAnalysis.average_into_grid_boxes()](#profileanalysisaverage_into_grid_boxes)<br />

Profile Class
#### ProfileAnalysis()
```python
class ProfileAnalysis(Indexed):
```

```
A set of analysis routines suitable for datasets in a Profile object.
See individual docstrings in each method for more info.
```

##### ProfileAnalysis.depth_means()
```python
@classmethod
def ProfileAnalysis.depth_means(cls, profile, depth_bounds):
```
> <br />
> Calculates a mean of all variable data that lie between two depths.<br />
> Returns a new Profile() object containing the meaned data<br />
> <br />
> <b>INPUTS:</b><br />
>  dataset (Dataset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : A dataset from a Profile object.<br />
>  depth_bounds (Tuple) : A tuple of length 2 describing depth bounds<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Should be of form: (lower, upper) and in metres<br />
> <br />
##### ProfileAnalysis.bottom_means()
```python
@classmethod
def ProfileAnalysis.bottom_means(cls, profile, layer_thickness, depth_thresholds=unknown):
```
> <br />
> Averages profile data in some layer above the bathymetric depth. This<br />
> routine requires there to be a 'bathymetry' variable in the Profile dataset.<br />
> It can apply a constant averaging layer thickness across all profiles<br />
> or a bespoke thickness dependent on the bathymetric depth. For example,<br />
> you may want to define the 'bottom' as the average of 100m above the<br />
> bathymetry in very deep ocean but only 10m in the shallower ocean.<br />
> If there is no data available in the layer specified (e.g. CTD cast not<br />
> deep enough or model bathymetry wrong) then it will be NaN<br />
> <br />
> To apply constant thickness, you only need to provide a value (in metre)<br />
> for layer_thickness. For different thicknesses, you also need to give<br />
> depth_thresholds. The last threshold must always be np.inf, i.e. all<br />
> data below a specific bathymetry depth.<br />
> <br />
> For example, to apply 10m to everywhere <100m, 50m to 100m -> 500m and<br />
> <b>100m elsewhere, use:</b><br />
> <br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  layer_thickness = [10, 50, 100]<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  depth_thresholds = [100, 500, np.inf]<br />
> <br />
> The bottom bound is always assumed to be 0.<br />
> <br />
> *NOTE: If time related issues arise, then remove any time variables<br />
> from the profile dataset before running this routine.<br />
> <br />
> <b>INPUTS:</b><br />
>  layer_thickness (array) : A scalar layer thickness or list of values<br />
>  depth_thresholds (array) : Optional. List of bathymetry thresholds.<br />
> <br />
> <b>OUTPUTS:</b><br />
>  New profile object containing bottom averaged data.<br />
> <br />
##### ProfileAnalysis.determine_mask_indices()
```python
@classmethod
def ProfileAnalysis.determine_mask_indices(cls, profile, mask_dataset):
```
> <br />
> Determines whether each profile is within a mask (region) or not.<br />
> These masks should be in Dataset form, as returned by<br />
> Mask_maker().make_mask_dataset(). I.E, each mask<br />
> should be a 2D array with corresponding 2D longitude and latitude<br />
> arrays. Multiple masks should be stored along a dim_mask dimension.<br />
> <br />
> Parameters<br />
> ----------<br />
> dataset : xarray.Dataset<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  A dataset from a profile object<br />
> mask_dataset : xarray.Dataset<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Dataset with dimensions (dim_mask, x_dim, y_dim).<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Should contain longitude, latitude and mask. Mask has dimensions<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  (dim_mask, y_dim, x_dim). Spatial dimensions should align with<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  longitude and latitude<br />
> <br />
> Returns<br />
> -------<br />
> Dataset describing which profiles are in which mask/region.<br />
> Ready for input to Profile.mask_means()<br />
> <br />
##### ProfileAnalysis.mask_means()
```python
@classmethod
def ProfileAnalysis.mask_means(cls, profile, mask_indices):
```
> <br />
> Averages all data inside a given profile dataset across a regional mask<br />
> or for multiples regional masks.<br />
> <br />
> Parameters<br />
> ----------<br />
> dataset : xarray.Dataset<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The profile dataset to average.<br />
> mask_indices : xarray.Dataset<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Describes which profiles are in which region. Returned from<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  profile_analysis.determine_mask_indices().<br />
> <br />
> Returns<br />
> -------<br />
> xarray.Dataset containing meaned data.<br />
> <br />
##### ProfileAnalysis.difference()
```python
@classmethod
def ProfileAnalysis.difference(cls, profile1, profile2, absolute_diff=True, square_diff=True):
```
> <br />
> Calculates differences between all matched variables in two Profile<br />
> datasets. Difference direction is dataset1 - dataset2.<br />
> <br />
> Parameters<br />
> ----------<br />
> dataset1 : xarray.Dataset<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  First profile dataset<br />
> dataset2 : xarray.Dataset<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Second profile dataset<br />
> absolute_diff : bool, optional<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Whether to calculate absolute differences. The default is True.<br />
> square_diff : bool, optional<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Whether to calculate square differences. The default is True.<br />
> <br />
> Returns<br />
> -------<br />
> New Profile object containing differenced dataset.<br />
> Differences have suffix diff_<br />
> Absolute differences have suffix abs_<br />
> Square differences have suffic square_<br />
> <br />
##### ProfileAnalysis.interpolate_vertical()
```python
@classmethod
def ProfileAnalysis.interpolate_vertical(cls, profile, new_depth, interp_method=linear, print_progress=False):
```
> <br />
> (04/10/2021)<br />
> Author: David Byrne<br />
> <br />
> For vertical interpolation of all profiles within this object. User<br />
> should pass an array describing the new depths or another profile object<br />
> containing the same number of profiles as this object.<br />
> <br />
> If a 1D numpy array is passed then all profiles will be interpolated<br />
> onto this single set of depths. If a xarray.DataArray is passed, it<br />
> should have dimensions (id_dim, z_dim) and contain a variable called<br />
> depth. This DataArray should contain the same number of profiles as<br />
> this object and will map profiles in order for interpolation. If<br />
> another profile object is passed, profiles will be mapped and<br />
> interpolated onto the other objects depth array.<br />
> <br />
> <b>INPUTS:</b><br />
>  new_depth (array or dataArray) : new depths onto which to interpolate<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    see description above for more info.<br />
>  interp_method (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : Any scipy interpolation string.<br />
> <br />
> <b>OUTPUTS:</b><br />
>  Returns a new PROFILE object containing the interpolated dataset.<br />
> <br />
##### ProfileAnalysis.average_into_grid_boxes()
```python
@classmethod
def ProfileAnalysis.average_into_grid_boxes(cls, profile, grid_lon, grid_lat, min_datapoints=1, season=None, var_modifier=):
```
> <br />
> Takes the contents of this Profile() object and averages each variables<br />
> into geographical grid boxes. At the moment, this expects there to be<br />
> no vertical dimension (z_dim), so make sure to slice the data out you<br />
> want first using isel, Profile.depth_means() or Profile.bottom_means().<br />
> <br />
> INPUTS<br />
>  grid_lon (array)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : 1d array of longitudes<br />
>  grid_lat (array)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : 1d array of latitude<br />
>  min_datapoints (int) : Minimum N of datapoints at which to average<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  into box. Will return Nan in boxes with smaller N.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  NOTE this routine will also return the variable<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  grid_N, which tells you how many points were<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  averaged into each box.<br />
> season (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    : 'DJF','MAM','JJA' or 'SON'. Will only average<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  data from specified season.<br />
> var_modifier (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  : Suffix to add to all averaged variables in the<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  output dataset. For example you may want to add<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  _DJF to all vars if restricting only to winter.<br />
> <br />
> OUTPUTS<br />
>  COAsT Gridded object containing averaged data.<br />
> <br />