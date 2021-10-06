---
title: "Profile"
linkTitle: "Profile"
weight: 5

description: >
  Example useage of Profile object.
---

The Profile object is able to store and manipulate depth profile data. This object is a 
child of the INDEXED object and has dimensions ('profile','t_dim'). Please ensure any
variables in this objects dataset also adhere to this dimension order.

Below is a set of examples of how you can use a Profile object for validation of
a Gridded object.

You may want to take bits and pieces from this script to use as you wish.

Many of these routines utilise xarray and Dask's lazy loading and chunking
capabilities. Not all of them do however. If working with very large datasets
it is recommended that the resulting datasets are saved to file at every step
and read into a new profile object, with new chunking, before continuing. This
can be done easily by calling xarrays to_netcdf().

### 1. Setup

First, Import some things to make this script work

```
import coast
import xarray as xr
import numpy as np
import coast.general_utils as general_utils
import matplotlib.pyplot as plt
```

Define some file paths

```
fn_dat = "/Users/dbyrne/Projects/coast/workshops/07092021/data/25hourm.grid_T_20180101.nc"
fn_dom = "/Users/dbyrne/Projects/coast/workshops/07092021/data/mesh_mask.nc"
fn_en4 = "/Users/dbyrne/Projects/coast/workshops/07092021/data/EN.4*"
```

Create a Gridded object using your data and domain files.

```
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config="./config/example_nemo_grid_t.json")
```

Create a landmask array and put it into the nemo object.
Here, using the bottom_level == 0 variable from the domain file is enough.

```
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
```

### 2. Read in EN4 data and subset to domain

Create a Profile object. Here we use EN4 data.
```
profile = coast.Profile(fn_en4, multiple=True, config="./config/example_en4_profiles.json")
```

Do some processing of the EN4 data. Here, we cut out a box of the
EN4 data for the region over out model domain. The process_en4()
routine is called to handle quality control of the data.

Get indices of obs within a geographical box and index the profile

```
ind = profile.subset_indices_lonlat_box([-25.47, 16.25], [44, 63.5])[0]
profile = profile.isel(profile=ind)
```

### 3. Process EN4 data
Create a new profile object called processed, containing the quality
controlled data. NOTE: .compute() or .load() will need to be called on
processed.dataset to access data

```
processed = profile.process_en4()
```

At this point, you can continue is the dataset is small, or save this
processed data to file using processed.dataset.to_netcdf(<filename>)
  
### 3. Interpolate Gridded object to Profile locations

Extract profiles from the model at nearest locations and times
For this we use Profile.obs_operator().
```
model_profiles = processed.obs_operator(nemo)
```
  
Inside this new profile object, there will be the extracted data and 5 new
variables describing the spatial and time differences in the interpolation
and the x, y and t indices used in the nearest neighbour.

Lets remove any points where the nearest neighbour was further than x km from
the original point.
```
too_far = 5
keep_indices = model_profiles.dataset.interp_dist <= too_far
model_profiles = model_profiles.isel(profile=keep_indices)
processed = processed.isel(profile=keep_indices)
```

### 4. Interpolate Obs and Gridded onto Reference Depths                                                     
Interpolate both model and observed profiles onto reference depths.

Define our reference depths
```
reference_depths = np.arange(0, 500, 2)
```
                                                           
Take just temperature for this example
```
model_profiles.dataset = model_profiles.dataset[["temperature"]]
```
                                                           
Vertical interpolation of model profiles using interpolate_vertical().
```        
model_profiles_interp = model_profiles.interpolate_vertical(reference_depths, interp_method="linear")
```

Vertical interpolation of processed observations
```           
processed.dataset = processed.dataset[["temperature", "depth"]]
processed_interp = processed.interpolate_vertical(reference_depths, interp_method="linear")
```

### 5. Calculate Errors & Differences
                                                           
Data differences/errors. Now that we have our model and observed data on the same depths,
we can do some differencing to get errors. We use the
Profile.difference() routine, which will calculate differences,
absolute differences and square differences

Calculate differences as obs minus model
```
differences = processed_interp.difference(model_profiles_interp)
```
Load the differences to memory.
```                              
differences.dataset.load()
```

                                                           
### 6. Calculate Regional Average Errors
                                                           
Average the differences into masked regions
By averaging the differences into regions, we can get an idea of the
errors or anomalies in, for example, the North Sea. For this we use
the coast.Mask_maker() object as an aid

First let's make some masks to define regions of the model domain
```
mm = coast.MaskMaker()
```
Make some variables easier to access
```
bath = nemo.dataset.bathymetry.values
lon = nemo.dataset.longitude.values
lat = nemo.dataset.latitude.values
```
Make a North Sea and Whole Domain mask
```
mm_north_sea = mm.region_def_nws_north_sea(lon, lat, bath)
mm_whole_domain = np.ones(lon.shape)
mask_list = [mm_north_sea, mm_whole_domain]
mask_names = ["North Sea", "Whole Domain"]
```
Turn mask list into an xarray dataset
```
mask_list = coast.MaskMaker.make_mask_dataset(lon, lat, mask_list)
```
Determine whether each profile is in each masked region or not
```
mask_indices = model_profiles_interp.determine_mask_indices(mask_list)
```
Do average differences for each region
```
mask_means = differences.mask_means(mask_indices)
```
  

### 6. Calculate Surface and Bottom Values/Errors
  
Surface and bottom averaging.
We can use a couple of routines to get surface and bottom values
for the profile data. This can be used to give us maps of e.g. SST.
It also allows us to calculate more statistics such as the CRPS

Lets get surface values by averaging over the top 5m of data
```
surface = 5
model_profiles_surface = model_profiles.depth_means([0, surface])
obs_profiles_surface = processed.depth_means([0, surface])
```
Get differences
```
surface_errors = obs_profiles_surface.difference(model_profiles_surface)
```

Lets get bottom values by averaging over the bottom 30m, except whether
depth is <100m, then average over the bottom 10m
```
model_profiles_bottom = model_profiles.bottom_means([10, 30], [100, np.inf])
obs_bathymetry = model_profiles.dataset["bathymetry"].values
processed.dataset["bathymetry"] = (["profile"], obs_bathymetry)
obs_profiles_bottom = processed.bottom_means([10, 30], [100, np.inf])
```
Get differences
```
bottom_errors = obs_profiles_bottom.difference(model_profiles_bottom)
```
