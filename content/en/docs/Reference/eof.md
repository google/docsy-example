---
title: "Eof"
linkTitle: "Eof"
date: 2022-06-28
description: >
  Docstrings for the Eof class
---
### Objects

[compute_eofs()](#compute_eofs)<br />
[compute_hilbert_eofs()](#compute_hilbert_eofs)<br />
[_compute()](#_compute)<br />

This is file deals with empirical orthogonal functions.
#### compute_eofs()
```python

def compute_eofs(variable, full_matrices=False, time_dim_name=t_dim):
```
> <br />
> Compute some numbers is a helper method.<br />
> <br />
> Computes the Empirical Orthogonal Functions (EOFs) of a variable (time series)<br />
> that has 3 dimensions where one is time, i.e. (x,y,time)<br />
> <br />
> Returns the set of EOF modes, the associated temporal projections and the<br />
> variance explained by each mode as DataArrays within an xarray Dataset.<br />
> <br />
> All-NaN time series, such as those at land points, are handled and ignored;<br />
> however, isolated NaNs within a time series, i.e. missing data point, must<br />
> be filled before calling the function.<br />
> <br />
> The variable will be de-meaned in time before the EOFs are computed, normalisation<br />
> should be carried out before calling the function if desired. The returned EOFs and<br />
> temporal projections are not scaled or normalised.<br />
> <br />
> Parameters<br />
> ----------<br />
> variable : (xarray.DataArray), 3-dimensional variable of size (I,J,T),<br />
> containing I*J time series<br />
> full_matrices : (boolean, default False) if false computes only first K EOFs<br />
> where K=min(I*J,T), where T is total number of time points. Setting to True<br />
> could demand significant memory.<br />
> time_dim_name : (string, default 't_dim') the name of the time dimension.<br />
> <br />
> Returns<br />
> -------<br />
> dataset : xarray Dataset, containing the EOFs, temporal projections and<br />
> variance explained as xarray DataArrays. The relevent coordinates<br />
> from the original data variable are also included<br />
> <br />
#### compute_hilbert_eofs()
```python

def compute_hilbert_eofs(variable, full_matrices=False, time_dim_name=t_dim):
```
> <br />
> Compute with hilbert is a helper method.<br />
> <br />
> Computes the complex Hilbert Empirical Orthogonal Functions (HEOFs) of a<br />
> variable (time series) that has 3 dimensions where one is time, i.e. (x,y,time).<br />
> See https://doi.org/10.1002/joc.1499<br />
> <br />
> Returns the set of HEOF amplitude and phase modes, the associated temporal<br />
> projection amplitudes and phases and the variance explained by each mode<br />
> as DataArrays within an xarray Dataset.<br />
> <br />
> All-NaN time series, such as those at land points, are handled and ignored;<br />
> however, isolated NaNs within a time series, i.e. missing data point, must<br />
> be filled before calling the function.<br />
> <br />
> The variable will be de-meaned in time before the EOFs are computed, normalisation<br />
> should be carried out before calling the function if desired. The returned EOFs and<br />
> temporal projections are not scaled or normalised.<br />
> <br />
> Parameters<br />
> ----------<br />
> variable : (xarray.DataArray), 3-dimensional variable of size (I,J,T),<br />
> containing I*J time series<br />
> full_matrices : (boolean, default False) if false computes only first K EOFs<br />
> where K=min(I*J,T), where T is total number of time points.<br />
> time_dim_name : (string, default 't_dim') the name of the time dimension.<br />
> <br />
> Returns<br />
> -------<br />
> dataset : xarray Dataset, containing the EOF amplitudes and phases,<br />
> temporal projection amplitude and phases and the variance explained<br />
> as xarray DataArrays. The relevent coordinates<br />
> from the original data variable are also in the dataset.<br />
> <br />
#### _compute()
```python

def _compute(signal, full_matrices, active_ind, number_points):
```
> <br />
> Private compute method is a helper method.<br />
> <br />
> Compute eofs, projections and variance explained using a Singular Value Decomposition<br />
> <br />
> Parameters<br />
> ----------<br />
> signal : (array) the signal<br />
> full_matrices : (boolean) whether to return a full or abbreviated SVD<br />
> active_ind : (array) indices of points with non-null signal<br />
> number_points : (int) number of points in original data set<br />
> <br />
> Returns<br />
> -------<br />
> EOFs : (array) the EOFs in 2d form<br />
> projections : (array) the projection of the EOFs<br />
> variance_explained : (array) variance explained by each mode<br />
> mode_count : (int) number of modes computed<br />
> <br />