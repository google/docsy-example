---
title: "Stats_util"
linkTitle: "Stats_util"
date: 2022-06-24
description: >
  Docstrings for the Stats_util class
---
### Objects

[quadratic_spline_roots()](#quadratic_spline_roots)<br />
[find_maxima()](#find_maxima)<br />
[doodson_x0_filter()](#doodson_x0_filter)<br />

Python definitions used to aid with statistical calculations.

*Methods Overview*
    -> normal_distribution(): Create values for a normal distribution
    -> cumulative_distribution(): Integration udner a PDF
    -> empirical_distribution(): Estimates CDF empirically
#### quadratic_spline_roots()
```python

def quadratic_spline_roots(spl):
```
> <br />
> A custom function for the roots of a quadratic spline. Cleverness found at<br />
> https://stackoverflow.com/questions/50371298/find-maximum-minimum-of-a-1d-interpolated-function<br />
> Used in find_maxima().<br />
> <br />
> <b>Example usage:</b><br />
> see example_scripts/tidegauge_tutorial.py<br />
> <br />
#### find_maxima()
```python

def find_maxima(x, y, method=comp, **kwargs):
```
> <br />
> Finds maxima of a time series y. Returns maximum values of y (e.g heights)<br />
> and corresponding values of x (e.g. times).<br />
> **kwargs are dependent on method.<br />
> <br />
> <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Methods:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  'comp' :: Find maxima by comparison with neighbouring values.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    Uses scipy.signal.find_peaks. **kwargs passed to this routine<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    will be passed to scipy.signal.find_peaks.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  'cubic' :: Find the maxima and minima by fitting a cubic spline and<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  finding the roots of its derivative.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Expect input as xr.DataArrays<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  DB NOTE: Currently only the 'comp' and 'cubic' method are implemented.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Future methods include linear interpolation.<br />
> <br />
> <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  JP NOTE: Cubic method:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  i) has intelligent fix for NaNs,<br />
> <br />
> <b>Example usage:</b><br />
> see example_scripts/tidegauge_tutorial.py<br />
> <br />
#### doodson_x0_filter()
```python

def doodson_x0_filter(elevation, ax=0):
```
> <br />
> The Doodson X0 filter is a simple filter designed to damp out the main<br />
> tidal frequencies. It takes hourly values, 19 values either side of the<br />
> <b>central one and applies a weighted average using:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    (1010010110201102112 0 2112011020110100101)/30.<br />
> ( http://www.ntslf.org/files/acclaimdata/gloup/doodson_X0.html )<br />
> <br />
> <b>In "Data Analaysis and Methods in Oceanography":</b><br />
> <br />
> "The cosine-Lanczos filter, the transform filter, and the<br />
> Butterworth filter are often preferred to the Godin filter,<br />
> to earlier Doodson filter, because of their superior ability<br />
> to remove tidal period variability from oceanic signals."<br />
> <br />
> This routine can be used for any dimension input array.<br />
> <br />
> Parameters<br />
> ----------<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  elevation (ndarray) : Array of hourly elevation values.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  axis (int) : Time axis of input array. This axis must have >= 39<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  elements<br />
> <br />
> Returns<br />
> -------<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Filtered array of same rank as elevation.<br />
> <br />