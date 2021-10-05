---
title: "Unit testing"
linkTitle: "Unit testing"
date: 2021-10-05
weight: 18
description: >
  Further information to describe COAsT's functionality.
---

Code functionality tests are written in
``unit_testing/unit_testing.py`` in the [COAsT](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/unit_testing)
repository, and therefore contain working examples of the package. These are written to verify the package functionality and to maintain operability following code updates.

At the time of writing these included:

### 1. Loading & Initialisation
    a. Loading Gridded NEMO data file
    b. Load data from existing dataset
    c. Set Gridded variable name
    d. Set Gridded grid attribute - dimension names
    e. Load only Domain
    f. Calculate depth_0 for t,u,v,w,f grids
    g. Load a subregion dataset with a full domain (AMM7)
    h. Load and combine multiple files.
    i. Load and combine harmonics
    j. Convert harmonics to a/g and back
    k. Compute e3[t,u,v,f,w] from SSH


### 2. General Utility Methods in COAsT
    a. Copying a COAsT object
    b. COAsT __getitem__ returns variable
    c. Renaming variables inside a COAsT object
    d. day of the week function

### 3. Diagnostic Methods
    a. Compute vertical spatial derivative
    b. Construct density method inside Gridded class
    c. Construct pycnocline depth and thickness                             
    d. Plot pycnocline depth

### 4. Transect Methods
    a. Determine and extract transect indices
    b. Transport velocity and depth calculations
    c. Transport and velocity plotting
    d. Construct density on z-levels along the transect. Compare with item 3b.
    e. Geostrophic velocity & transport calculations

### 5. Object Manipulation (e.g. indexing, subsetting)
    a. Subsetting single variable
    b. Indices by distance
    c. Find nearest xy indices
    d. Gridded.interpolate_in_space()
    e. Gridded.interpolate_in_time()

### 6. Altimetry Methods
    a. Load example data
    b. Subset altimetry data
    c. Interpolate model onto altimetry using obs_operator
    d. Calculate CRPS
    e. ALTIMETRY basic stats
    f. Altimetry plotting

### 7. TIDEGAUGE Methods
    a. Load GESLA data
    b. Load BODC data
    c. Load EA data via API
    d. TIDEGAUGE obs operator
    e. Tidegauge CRPS
    f. Tiudegauge basic stats
    g. Resample TIDEGAUGE
    h. Apply Doodson XO Filter to data
    i. Loading multiple tidegauges
    j. Plotting a single tidegauge location
    k. Plotting multiple tidegauge locations
    l. Tidegauge time series plot
    m. TIDEGAUGE method for tabulated data
    n. TIDEGAUGE method for finding peaks and troughs, compare neighbours
    o. TIDEGAUGE method for finding extrema and troughs, fit cubic spline

### 8. Isobath Contour Methods
    a. Extract isbath contour between two points
    b. Plot contour on map
    c. Calculate pressure along contour
    d. Calculate flow across contour
    e. Calculate pressure gradient driven flow across contour

### 9. EOF methods
    a. Compute EOFs, projections and variance
    b. Compute HEOFs, projections and variance

### 10. Profile Methods
    a. Load En4 data
    b. Process En4 data
    c. Gridded obs_operator
    d. Vertical Interpolation
    e. Profile differencing
    f. Regional averaging
    g. Surface and Bottm averaging.

### 11. Plotting Utility
    a. scatter_with_fit()
    b. create_geo_axes()
    c. determine_colorbar_extension()
    d. determine_clim_by_standard_deviation()

### 12. Stats Utility
    a. find_maxima()

### 13. MASK_MASKER
    a. Create mask by indices
    b. Create mask by lonlat

### 14. CLIMATOLOGY
    a. Create monthly and seasonal climatology, write to file

### N. Example script testing
    a. tutorials using example_files (E.g. altimetry and tidegauges, ...)
    b. tutorial on AMM15 data
    c. tutorial on AMM60 data
    d. tutorial on Belize data
    e. tutorial on SEAsia data
    f. tutorial on WCSSP-India data
    g. tutorial on internal tides
