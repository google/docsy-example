---
title: "Profile"
linkTitle: "Profile"
weight: 5

description: >
  Example useage of Profile object.
---

# Overview

The `Profile` data class is designed to store and manipulate depth profile data. The data is structured around a set of 'discrete' profiles, each having a vertical dimension and its own depth coordinate. Profiles are discrete and can be irregularly placed in space and time. The Profile class contains a number of routines for reading from different databases of profiles, manipulating the data within the object and interpolating Gridded data onto profile locations and times. There is also a corresponding analysis class called `ProfileAnalysis()`, which contains analysis routines for comparison with `Gridded` data (e.g. NEMO).

There are examples for using Profile and ProfileAnalysis for model validation in COAsT/example_scripts/profile_validation. You can easily get these files by downloading or cloning the github repository. Please see the `Example Useage` section at the end of this page for some short examples.

# Profile Class

INDEXED type class for storing data from a CTD Profile (or similar down and up observations). The structure of the class is based around having discrete profile locations with independent depth dimensions and coords. 

The class dataset should contain two dimensions:

        > id_dim  :: The profiles dimension. Each element of this dimension
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

## Data structure

## Methods

{{< card header="**read_en4(self, fn_en4, chunks: dict = {}, multiple=False)**" 
          title="" subtitle="" footer="">>}}
        Reads a single or multiple EN4 netCDF files into the COAsT profile
        data structure.

        Parameters
        ----------
        fn_en4 : TYPE
            path to data file.
        chunks : dict, optional
            Chunking specification
        multiple : TYPE, optional
            True if reading multiple files otherwise False

        Returns
        -------
        None. Populates dataset within Profile object.
        """

…
{{< /card >}}

# `ProfileAnalysis` Method

# Example Useage


