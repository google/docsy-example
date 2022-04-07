---
title: "Profile"
linkTitle: "Profile"
weight: 5

description: >
  Example useage of Profile object.
---

# Overview

INDEXED type class for storing data from a CTD Profile (or similar
down and up observations). The structure of the class is based around having
discrete profile locations with independent depth dimensions and coords. 
The class dataset should contain two dimensions:

    > id_dim      :: The profiles dimension. Each element of this dimension
                 contains data (e.g. cast) for an individual location.
    > z_dim   :: The dimension for depth levels. A profile object does not
                 need to have shared depths, so NaNs might be used to
                 pad any depth array.

Alongside these dimensions, the following minimal coordinates should also
be available:

    > longitude (id_dim)   :: 1D array of longitudes, one for each id_dim
    > latitude  (id_dim)   :: 1D array of latitudes, one for each id_dim
    > time      (id_dim)   :: 1D array of times, one for each id_dim
    > depth     (id_dim, z_dim)  :: 2D array of depths, with different depth
                                levels being provided for each profile.
                                Note that these depth levels need to be
                                stored in a 2D array, so NaNs can be used
                                to pad out profiles with shallower depths.
    > id_name   (id_dim)   :: [Optional] Name of id_dim/case or id_dim number.

# Example Useage

Below is a description of the available example scripts for this class as well
as an overview of validation using` Profile` and `ProfileAnalysis`.

### Example Scripts

Please see COAsT/example_scripts/profile_validation for some scripts which
demonstrate how to use the Profile and ProfileAnalysis classes for model
validation. 

1. `analysis_preprocess_en4.py` : If you're using EN4 data, this kind of script
might be your first step for analysis.

2. `analysis_extract_and_compare.py`: This script shows you how to extract
the nearest model profiles, compare them with EN4 observations and get errors
throughout the vertical dimension and averaged in surface and bottom zones

3. `analysis_extract_and_compare_single_process.py`: This script does the same
as number 2. However, it is modified slightly to take a command line argument
which helps it figure out which dates to analyse. This means that this script
can act as a template for `jug` type parallel processing on, e.g. JASMIN.

4. `analysis_mask_means.py`: This script demonstrates how to use boolean masks
to obtain regional averages of profiles and errors.

5. `analysis_average_into_grid_boxes.py`: This script demonstrates how to 
average the data inside a `Profile` object into regular grid boxes and 
seasonal climatologies.

### Basic useage

We can create a new Profile object easily:

```
profile = coast.Profile()
```

Currently, this object is empty, and contains no dataset. There are some
reading routines currently available in Profile for reading EN4 or WOD data
files. These can be used to easily read data into your new profile object:

```
# Read WOD data into profile object (OVERWRITES DATASET)
profile.read_wod( filename )

# Read EN4 data into profile object
profile.read_en4( filename )
```

Alternatively, you can pass an `xarray.dataset` straight to Profile:
```
profile = coast.Profile( dataset = your_dataset, config = config_file [opt] )
```

We can do some simple spatial and temporal manipulations of this data:

```
# Cut out a geographical box
profile = profile.subset_indices_lonlat_box(lonbounds = [-15, 15], 
                                            latbounds = [45, 65])

# Cut out a time window
profile = profile.time_slice( date0 = datetime(2004, 1, 1), date1 = datetime(2005,1,1))
```

If you are using EN4 data, you can use the `process_en4()` routine to apply 
quality control flags to the data (replacing with NaNs):

```
processed_profile = profile.process_en4()
```

### Direct Model Comparison

There are a number of routines available for interpolating in the horizontal,
vertical and in time to do direct comparisons of model and profile data.
`Profile.obs_operator` will do a nearest neighbour spatial interpolation of
the data in a `Gridded` object to profile latitudes/longitudes. It will also
do a custom time interpolation. For example:

```
# Create gridded object:
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config=fn_cfg_nemo)

# Create a landmask array in Gridded
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})

# Use obs operator for horizontal remapping of Gridded onto Profile.
model_profiles = profile.obs_operator(nemo)
```

In the above example we added a `landmask` variable to the `Gridded` dataset.
When this is present, the `obs_operator` will use this to interpolation to the
nearest *wet* point. If not present, it will just take the nearest grid point.

Now that we have interpolated the model onto Profiles, we have a new Profile
object called `model_profiles`. This can be used to do some comparisons with
our original `processed_profile` object, which we created above. First lets
make our ProfileAnalysis object:

```
analysis = coast.ProfileAnalysis()
```

We can use `ProfileAnalysis.interpolate_vertical` to interpolate all variables
within a Profile object. This can be done onto a set of reference depths or,
matching another object's depth coordinates by passing another profile object.
Let's interpolate our model profiles onto observations depths, then interpolate
both onto a set of reference depths:

```
# Interpolate model profiles onto observation depths
model_profiles_interp = analysis.interpolate_vertical(model_profiles, profile, interp_method="linear")

# Vertical interpolation of model profiles to reference depths
model_profiles_interp = panalysis.interpolate_vertical(model_profiles_interp, ref_depth)

# Interpolation of obs profiles to reference depths
profile_interp = analysis.interpolate_vertical(profile, ref_depth)
```

Now that we have two Profile objects that are horizontally and vertically 
comparable, we can use `difference()` to get some basic errors:

```
differences = analysis.difference(profile_interp, model_profiles_interp)
``` 

This will return a new `Profile` object that contains the variable difference,
absolute differences and square differences at all depths and means for each
profile.

### Layer Averaging

We can use the `Profile` object to get mean values between specific depth levels
or for some layer above the bathymetric depth. The former can be done using
`ProfileAnalysis.depth_means()`, for example the following will return a new
Profile object containing the means of all variables between 0m and 5m:

```
profile_surface = analysis.depth_means(profile, [0, 5])
```

This can be done for any arbitrary depth layer defined by two depths. In some
cases it may be that one of the depth levels is not defined by a constant, e.g.
when calculating bottom means. In this case you may want to calculate averages
in some layer above the seabed. This can be done using 
`ProfileAnalysis.bottom_means()`. For example:

```
bottom_height = [10, 30, 100]  # Use bottom heights of 10m, 30m and 100m for...
bottom_thresh = [100, 500, np.inf]  # ...depths less than 100m, 500m and infinite
profile_bottom = analysis.bottom_means(profile, bottom_height, bottom_thresh)
```

This will calculate bottom means differently depending upon the actualy depth.
For depths less than 100m, it will take the average of the bottom 10m. For less
than 500 m (and greater than 100m), it will take the average of the bottom 30m.
And so on. This routine will look for a variable in the input Profile called
`bathymetry`. If this is not present you will need to insert it yourself, e.g:

```
profile.dataset["bathymetry"] = (["id_dim"], obs_bathymetry_array)
```

**NOTE1: The `bathymetry` variable does not actually need to contain bathymetric
depths, it can also be used to calculate means above any non-constant surface.
For example, it could be mixed layer depth.

**NOTE2: This can be done for any Profile object. So, you could use this 
workflow to also average a Profile derived from the `difference()` routine.

### Regional (Mask) Averaging

We can use `Profile` in combination with `MaskMaker` to calculate averages over
regions defined by masks. For example, to get the mean errors in the North Sea.
Start by creating a list of boolean masks we would like to use:

```
mm = coast.MaskMaker()

# Define Regional Masks
regional_masks = []
bath = nemo.dataset.bathymetry.values

# Add regional mask for whole domain
regional_masks.append(np.ones(lon.shape))

# Add regional mask for North Sea
regional_masks.append(mm.region_def_nws_north_sea(lon, lat, bath))

region_names = ["whole_domain","north_sea",]
```

Next, we must make these masks into datasets using `MaskMaker.make_mask_dataset`.
Masks should be 2D datasets defined by booleans. In our example here we have used
the latitude/longitude array from the nemo object, however it can be defined
however you like.

```
mask_list = mm.make_mask_dataset(lon, lat, regional_masks)
```

Then we use `ProfileAnalysis.determine_mask_indices` to figure out which
profiles in a `Profile` object lie within each regional mask:

```
mask_indices = analysis.determine_mask_indices(profile, mask_list)
```

This returns an object called `mask_indices`, which is required to pass to
`ProfileAnalysis.mask_means()`. This routine will return a new xarray dataset
containing averaged data for each region:

```
mask_means = analysis.mask_means(profile, mask_indices)
```

### Gridding Profile Data

If you have large amount of profile data you may want to average it into
grid boxes to get, for example, mean error maps or climatologies. This can be
done using `ProfileAnalysis.average_into_grid_boxes()`.

We can create a gridded dataset of all the data using:

```
grid_lon = np.arange(-15, 15, 0.5)
grid_lat = np.arange(45, 65, 0.5)
prof_gridded = analysis.average_into_grid_boxes(grid_lon, grid_lat)
```

Alternatively, we can calculate averages for each season:

```
prof_gridded_DJF = profile_analysis.average_into_grid_boxes(grid_lon, grid_lat, season="DJF", var_modifier="_DJF")
prof_gridded_MAM = profile_analysis.average_into_grid_boxes(grid_lon, grid_lat, season="MAM", var_modifier="_MAM")
prof_gridded_JJA = profile_analysis.average_into_grid_boxes(grid_lon, grid_lat, season="JJA", var_modifier="_JJA")
prof_gridded_SON = profile_analysis.average_into_grid_boxes(grid_lon, grid_lat, season="SON", var_modifier="_SON")
```

Here, `season` specifies which season to average over and `var_modifier` is added to the end of 
all variable names in the object's dataset. 

This function returns a new Gridded object. It also contains a new variable
called `grid_N`, which stores how many profiles were averaged into each grid box.
You may want to use this when using the analysis.
