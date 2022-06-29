---
title: "Gridded"
linkTitle: "Gridded"
date: 2022-06-29
description: >
  Docstrings for the Gridded class
---
### Objects

[Gridded()](#gridded)<br />
[Gridded._setup_grid_obj()](#gridded_setup_grid_obj)<br />
[Gridded.set_grid_vars()](#griddedset_grid_vars)<br />
[Gridded.load_domain()](#griddedload_domain)<br />
[Gridded.merge_domain_into_dataset()](#griddedmerge_domain_into_dataset)<br />
[Gridded.set_grid_ref_attr()](#griddedset_grid_ref_attr)<br />
[Gridded.get_contour_complex()](#griddedget_contour_complex)<br />
[Gridded.set_timezero_depths()](#griddedset_timezero_depths)<br />
[Gridded.subset_indices()](#griddedsubset_indices)<br />
[Gridded.find_j_i()](#griddedfind_j_i)<br />
[Gridded.find_j_i_domain()](#griddedfind_j_i_domain)<br />
[Gridded.transect_indices()](#griddedtransect_indices)<br />
[Gridded.interpolate_in_space()](#griddedinterpolate_in_space)<br />
[Gridded.interpolate_in_time()](#griddedinterpolate_in_time)<br />
[Gridded.construct_density()](#griddedconstruct_density)<br />
[Gridded.trim_domain_size()](#griddedtrim_domain_size)<br />
[Gridded.copy_domain_vars_to_dataset()](#griddedcopy_domain_vars_to_dataset)<br />
[Gridded.differentiate()](#griddeddifferentiate)<br />
[Gridded.apply_doodson_x0_filter()](#griddedapply_doodson_x0_filter)<br />
[Gridded.get_e3_from_ssh()](#griddedget_e3_from_ssh)<br />
[Gridded.harmonics_combine()](#griddedharmonics_combine)<br />
[Gridded.harmonics_convert()](#griddedharmonics_convert)<br />
[Gridded.time_slice()](#griddedtime_slice)<br />

Gridded class
#### Gridded()
```python
class Gridded(Coast):
```

```
Words to describe the NEMO class

kwargs -- define addition keyworded arguemts for domain file. E.g. ln_sco=1
if using s-scoord in an old domain file that does not carry this flag.
```

##### Gridded._setup_grid_obj()
```python

def Gridded._setup_grid_obj(self, chunks, multiple, **kwargs):
```
> <br />
> This is a helper method to reduce the size of def __init__<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks: This is a setting for xarray as to whether dask (parrell processing) should be on and how it works<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  multiple: falg to tell if we are loading one or more files<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **kwargs: pass direct to loaded xarray dataset<br />
> <br />
##### Gridded.set_grid_vars()
```python

def Gridded.set_grid_vars(self):
```
> <br />
> Define the variables to map from the domain file to the NEMO obj<br />
> <br />
##### Gridded.load_domain()
```python

def Gridded.load_domain(self, fn_domain, chunks):
```
> <br />
> Loads domain file and renames dimensions with dim_mapping_domain<br />
> <br />
##### Gridded.merge_domain_into_dataset()
```python

def Gridded.merge_domain_into_dataset(self, dataset_domain):
```
> <br />
> Merge domain dataset variables into self.dataset, using grid_ref<br />
> <br />
##### Gridded.set_grid_ref_attr()
```python

def Gridded.set_grid_ref_attr(self):
```
> <br />
> None<br />
> <br />
##### Gridded.get_contour_complex()
```python

def Gridded.get_contour_complex(self, var, points_x, points_y, points_z, tolerance=0.2):
```
> <br />
> None<br />
> <br />
##### Gridded.set_timezero_depths()
```python

def Gridded.set_timezero_depths(self, dataset_domain):
```
> <br />
> Calculates the depths at time zero (from the domain_cfg input file)<br />
> for the appropriate grid.<br />
> The depths are assigned to domain_dataset.depth_0<br />
> <br />
##### Gridded.subset_indices()
```python

def Gridded.subset_indices(self):
```
> <br />
> based on transect_indices, this method looks to return all indices between the given points.<br />
> This results in a 'box' (Quadrilateral) of indices.<br />
> consequently the returned lists may have different lengths.<br />
> :param start: A lat/lon pair<br />
> :param end: A lat/lon pair<br />
> :return: list of y indices, list of x indices,<br />
> <br />
##### Gridded.find_j_i()
```python

def Gridded.find_j_i(self):
```
> <br />
> A routine to find the nearest y x coordinates for a given latitude and longitude<br />
> Usage: [y,x] = find_j_i(lat=49, lon=-12)<br />
> <br />
> :param lat: latitude<br />
> :param lon: longitude<br />
> :return: the y and x coordinates for the NEMO object's grid_ref, i.e. t,u,v,f,w.<br />
> <br />
##### Gridded.find_j_i_domain()
```python

def Gridded.find_j_i_domain(self):
```
> <br />
> A routine to find the nearest y x coordinates for a given latitude and longitude<br />
> Usage: [y,x] = find_j_i_domain(lat=49, lon=-12, dataset_domain=dataset_domain)<br />
> <br />
> :param lat: latitude<br />
> :param lon: longitude<br />
> :param dataset_domain: dataset domain<br />
> :return: the y and x coordinates for the grid_ref variable within the domain file<br />
> <br />
##### Gridded.transect_indices()
```python

def Gridded.transect_indices(self, start, end):
```
> <br />
> This method returns the indices of a simple straight line transect between two<br />
> lat lon points defined on the NEMO object's grid_ref, i.e. t,u,v,f,w.<br />
> <br />
> :type start: tuple A lat/lon pair<br />
> :type end: tuple A lat/lon pair<br />
> :return: array of y indices, array of x indices, number of indices in transect<br />
> <br />
##### Gridded.interpolate_in_space()
```python
@staticmethod
def Gridded.interpolate_in_space(model_array, new_lon, new_lat, mask=None):
```
> <br />
> Interpolates a provided xarray.DataArray in space to new longitudes<br />
> and latitudes using a nearest neighbour method (BallTree).<br />
> <br />
> Example Usage<br />
> ----------<br />
> # Get an interpolated DataArray for temperature onto two locations<br />
> interpolated = nemo.interpolate_in_space(nemo.dataset.votemper,<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   [0,1], [45,46])<br />
> Parameters<br />
> ----------<br />
> model_array (xr.DataArray): Model variable DataArray to interpolate<br />
> new_lons (1Darray): Array of longitudes (degrees) to compare with model<br />
> new_lats (1Darray): Array of latitudes (degrees) to compare with model<br />
> mask (2D array): Mask array. Where True (or 1), elements of array will<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   not be included. For example, use to mask out land in<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   case it ends up as the nearest point.<br />
> <br />
> Returns<br />
> -------<br />
> Interpolated DataArray<br />
> <br />
##### Gridded.interpolate_in_time()
```python
@staticmethod
def Gridded.interpolate_in_time(model_array, new_times, interp_method=nearest, extrapolate=True):
```
> <br />
> Interpolates a provided xarray.DataArray in time to new python<br />
> datetimes using a specified scipy.interpolate method.<br />
> <br />
> Example Useage<br />
> ----------<br />
> # Get an interpolated DataArray for temperature onto altimetry times<br />
> new_times = altimetry.dataset.time<br />
> interpolated = nemo.interpolate_in_space(nemo.dataset.votemper,<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   new_times)<br />
> Parameters<br />
> ----------<br />
> model_array (xr.DataArray): Model variable DataArray to interpolate<br />
> new_times (array): New times to interpolate to (array of datetimes)<br />
> interp_method (str): Interpolation method<br />
> <br />
> Returns<br />
> -------<br />
> Interpolated DataArray<br />
> <br />
##### Gridded.construct_density()
```python

def Gridded.construct_density(self, eos=EOS10):
```
> <br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Constructs the in-situ density using the salinity, temperture and<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  depth_0 fields and adds a density attribute to the t-grid dataset<br />
> <br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Requirements: The supplied t-grid dataset must contain the<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Practical Salinity and the Potential Temperature variables. The depth_0<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  field must also be supplied. The GSW package is used to calculate<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The Absolute Pressure, Absolute Salinity and Conservate Temperature.<br />
> <br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Note that currently density can only be constructed using the EOS10<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  equation of state.<br />
> <br />
> Parameters<br />
> ----------<br />
> eos : equation of state, optional<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  DESCRIPTION. The default is 'EOS10'.<br />
> <br />
> <br />
> Returns<br />
> -------<br />
> None.<br />
> adds attribute NEMO.dataset.density<br />
> <br />
##### Gridded.trim_domain_size()
```python

def Gridded.trim_domain_size(self, dataset_domain):
```
> <br />
> Trim the domain variables if the dataset object is a spatial subset<br />
> <br />
> Note: This breaks if the SW & NW corner values of nav_lat and nav_lon<br />
> are masked, as can happen if on land...<br />
> <br />
##### Gridded.copy_domain_vars_to_dataset()
```python

def Gridded.copy_domain_vars_to_dataset(self, dataset_domain, grid_vars):
```
> <br />
> Map the domain coordand metric variables to the dataset object.<br />
> Expects the source and target DataArrays to be same sizes.<br />
> <br />
##### Gridded.differentiate()
```python

def Gridded.differentiate(self, in_var_str, config_path=None, dim=z_dim, out_var_str=None, out_obj=None):
```
> <br />
> Derivatives are computed in x_dim, y_dim, z_dim (or i,j,k) directions<br />
> wrt lambda, phi, or z coordinates (with scale factor in metres not degrees).<br />
> <br />
> Derivatives are calculated using the approach adopted in NEMO,<br />
> specifically using the 1st order accurate central difference<br />
> approximation. For reference see section 3.1.2 (sec. Discrete operators)<br />
> of the NEMO v4 Handbook.<br />
> <br />
> Currently the method does not accomodate all possible eventualities. It<br />
> <b>covers:</b><br />
> 1) d(grid_t)/dz --> grid_w<br />
> <br />
> Returns  an object (with the appropriate target grid_ref) containing<br />
> derivative (out_var_str) as xr.DataArray<br />
> <br />
> <b>This is hardwired to expect:</b><br />
> 1) depth_0 and e3_0 fields exist<br />
> 2) xr.DataArrays are 4D<br />
> 3) self.filename_domain if out_obj not specified<br />
> 4) If out_obj is not specified, one is built that is  the size of<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  self.filename_domain. I.e. automatic subsetting of out_obj is not<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  supported.<br />
> <br />
> <b>Example usage:</b><br />
> --------------<br />
> # Initialise DataArrays<br />
> nemo_t = coast.NEMO( fn_data, fn_domain, grid_ref='t-grid' )<br />
> # Compute dT/dz<br />
> nemo_w_1 = nemo_t.differentiate( 'temperature', dim='z_dim' )<br />
> <br />
> # For f(z)=-z. Compute df/dz = -1. Surface value is set to zero<br />
> nemo_t.dataset['depth4D'],_ = xr.broadcast( nemo_t.dataset['depth_0'], nemo_t.dataset['temperature'] )<br />
> nemo_w_4 = nemo_t.differentiate( 'depth4D', dim='z_dim', out_var_str='dzdz' )<br />
> <br />
> <b>Provide an existing target NEMO object and target variable name:</b><br />
> nemo_w_1 = nemo_t.differentiate( 'temperature', dim='z_dim', out_var_str='dTdz', out_obj=nemo_w_1 )<br />
> <br />
> <br />
> Parameters<br />
> ----------<br />
> in_var_str : str, name of variable to differentiate<br />
> config_path : str, path to the w grid config file<br />
> dim : str, dimension to operate over. E.g. {'z_dim', 'y_dim', 'x_dim', 't_dim'}<br />
> out_var_str : str, (optional) name of the target xr.DataArray<br />
> out_obj : exiting NEMO obj to store xr.DataArray (optional)<br />
> <br />
##### Gridded.apply_doodson_x0_filter()
```python

def Gridded.apply_doodson_x0_filter(self, var_str):
```
> <br />
> Applies Doodson X0 filter to a variable.<br />
> <br />
> Input variable is expected to be hourly.<br />
> Output is saved back to original dataset as {var_str}_dxo<br />
> <br />
> !!WARNING: Will load in entire variable to memory. If dataset large,<br />
> then subset before using this method or ensure you have enough free<br />
> RAM to hold the variable (twice).<br />
> <br />
> DB:: Currently not tested in unit_test.py<br />
> <br />
##### Gridded.get_e3_from_ssh()
```python
@staticmethod
def Gridded.get_e3_from_ssh(nemo_t, e3t=True, e3u=False, e3v=False, e3f=False, e3w=False, dom_fn=None):
```
> <br />
> Where the model has been run with a nonlinear free surface<br />
> and z* variable volumne (ln_vvl_zstar=True) then the vertical scale factors<br />
> will vary in time (and space). This function will compute the vertical<br />
> scale factors e3t, e3u, e3v, e3f and e3w by using the sea surface height<br />
> field (ssh variable) and initial scale factors from the domain_cfg file.<br />
> The vertical scale factors will be computed at the same model time as the<br />
> ssh and if the ssh field is averaged in time then the scale factors will<br />
> also be time averages.<br />
> <br />
> A t-grid NEMO object containing the ssh variable must be passed in. Either<br />
> the domain_cfg path must have been passed in as an argument when the NEMO<br />
> object was created or it must be passed in here using the dom_fn argument.<br />
> <br />
> e.g. e3t,e3v,e3f = coast.NEMO.get_e3_from_ssh(nemo_t,true,false,true,true,false)<br />
> <br />
> Parameters<br />
> ----------<br />
> nemo_t : (Coast.NEMO), NEMO object on the t-grid containing the ssh variable<br />
> e3t : (boolean), true if e3t is to be returned. Default True.<br />
> e3u : (boolean), true if e3u is to be returned. Default False.<br />
> e3v : (boolean), true if e3v is to be returned. Default False.<br />
> e3f : (boolean), true if e3f is to be returned. Default False.<br />
> e3w : (boolean), true if e3w is to be returned. Default False.<br />
> dom_fn : (str), Optional, path to domain_cfg file.<br />
> <br />
> Returns<br />
> -------<br />
> Tuple of xarray.DataArrays<br />
> (e3t, e3u, e3v, e3f, e3w)<br />
> Only those requested will be returned, but the ordering is always the same.<br />
> <br />
##### Gridded.harmonics_combine()
```python

def Gridded.harmonics_combine(self, constituents, components=unknown):
```
> <br />
> Contains a new NEMO object containing combined harmonic information<br />
> from the original object.<br />
> <br />
> NEMO saves harmonics to individual variables such as M2x, M2y... etc.<br />
> This routine will combine these variables (depending on constituents)<br />
> into a single data array. This new array will have the new dimension<br />
> 'constituent' and a new data coordinate 'constituent_name'.<br />
> <br />
> Parameters<br />
> ----------<br />
> constituents : List of strings containing constituent names to combine.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     The case of these strings should match that used in<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     NEMO output. If a constituent is not found, no problem,<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     it just won't be in the combined dataset.<br />
> components   : List of strings containing harmonic components to look<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     for. By default, this looks for the complex components<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     'x' and 'y'. E.g. if constituents = ['M2'] and<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     components is left as default, then the routine looks<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     for ['M2x', and 'M2y'].<br />
> <br />
> Returns<br />
> -------<br />
> NEMO() object, containing combined harmonic variables in a new dataset.<br />
> <br />
##### Gridded.harmonics_convert()
```python

def Gridded.harmonics_convert(self, direction=cart2polar, x_var=harmonic_x, y_var=harmonic_y, a_var=harmonic_a, g_var=harmonic_g, degrees=True):
```
> <br />
> Converts NEMO harmonics from cartesian to polar or vice versa.<br />
> Make sure this NEMO object contains combined harmonic variables<br />
> obtained using harmonics_combine().<br />
> <br />
> <b>*Note:</b><br />
> <br />
> Parameters<br />
> ----------<br />
> direction (str) : Choose 'cart2polar' or 'polar2cart'. If 'cart2polar'<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    Then will look for variables x_var and y_var. If<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    polar2cart, will look for a_var (amplitude) and<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    g_var (phase).<br />
> x_var (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : Harmonic x variable name in dataset (or output)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    default = 'harmonic_x'.<br />
> y_var (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : Harmonic y variable name in dataset (or output)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    default = 'harmonic_y'.<br />
> a_var (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : Harmonic amplitude variable name in dataset (or output)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    default = 'harmonic_a'.<br />
> g_var (str)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   : Harmonic phase variable name in dataset (or output)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    default = 'harmonic_g'.<br />
> degrees (bool)  : Whether input/output phase are/will be in degrees.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    Default is True.<br />
> <br />
> Returns<br />
> -------<br />
> Modifies NEMO() dataset in place. New variables added.<br />
> <br />
##### Gridded.time_slice()
```python

def Gridded.time_slice(self, date0, date1):
```
> <br />
> Return new Gridded object, indexed between dates date0 and date1<br />
> <br />