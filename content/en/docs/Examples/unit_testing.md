---
title: "Unit testing"
linkTitle: "Unit testing"
date: 2020-09-15
weight: 18
description: >
  Further information to describe COAsT's functionality.
---

Code functionality tests are written in
``unit_testing/unit_testing.py`` in the [COAsT](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/unit_testing)
repository, and therefore contain working examples of the package. These are written to verify the package functionality and to maintain operability following code updates.

At the time of writing these included:

### 1. Loading & Initialisation
    a. Loading NEMO data file
    b. Loading Altimetry file
    c. Load data from existing dataset
    d. Set NEMO variable name
    e. Set NEMO grid attribute - dimension names
    f. Load only Domain
    g. Calculate depth_0 for t,u,v,w,f grids
    h. Load NEMO that is a subregion in the domain file
    i. Multi load (over time) for NEMO files

### 2. General Utility Methods in COAsT
    a. Copying a COAsT object
    b. COAsT ``__getitem__`` returns variable
    c. Renaming variables inside a COAsT object

### 3. Diagnostic Methods
    a. Compute vertical spatial derivative
    b. Construct density method inside NEMO class
    c. Construct pycnocline depth and thickness                             
    d. Plot pycnocline depth

### 4. Transect Methods
    a. Determine and extract transect indices
    b. Transport velocity and depth calculations
    c. Transport and velocity plotting
    d. Contrust density on z-levels along the transect. Compare with item 3b.
    e. Geostrophic velocity & transport calculations

### 5. Object Manipulation (e.g. indexing, subsetting)
    a. Subsetting single variable
    b. Indices by distance
    c. Subsetting entire COAsT object and return as copy
    d. Find nearest xy indices
    e. ``NEMO.interpolate_in_space()``
    f. ``NEMO.interpolate_in_time()``

### 6. Validation Methods
    a. Calculate single obs CRPS values using different methods
    b. CRPS map plot
    c. CRPS CDF plot
    d. Interpolate model to altimetry

### 7. Plotting Methods
    a. Altimetry ``quick_plot()``
    b. Open, view and save tide gauge data from GESLA database
