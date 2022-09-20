---
title: "Tidegauge"
linkTitle: "Tidegauge"
date: 2022-09-20
description: >
  Docstrings for the Tidegauge class
---
### Objects

[Tidegauge()](#tidegauge)<br />
[Tidegauge.read_gesla_v3()](#tidegaugeread_gesla_v3)<br />
[Tidegauge.read_gesla()](#tidegaugeread_gesla)<br />
[Tidegauge._read_gesla_header_v5()](#tidegauge_read_gesla_header_v5)<br />
[Tidegauge._read_gesla_header_v3()](#tidegauge_read_gesla_header_v3)<br />
[Tidegauge._read_gesla_data()](#tidegauge_read_gesla_data)<br />
[Tidegauge.read_hlw()](#tidegaugeread_hlw)<br />
[Tidegauge._read_hlw_header()](#tidegauge_read_hlw_header)<br />
[Tidegauge._read_hlw_data()](#tidegauge_read_hlw_data)<br />
[Tidegauge.show()](#tidegaugeshow)<br />
[Tidegauge.get_tide_table_times()](#tidegaugeget_tide_table_times)<br />
[Tidegauge.read_ea_api_to_xarray()](#tidegaugeread_ea_api_to_xarray)<br />
[Tidegauge.read_bodc()](#tidegaugeread_bodc)<br />
[Tidegauge._read_bodc_header()](#tidegauge_read_bodc_header)<br />
[Tidegauge._read_bodc_data()](#tidegauge_read_bodc_data)<br />
[Tidegauge.plot_timeseries()](#tidegaugeplot_timeseries)<br />
[Tidegauge.plot_on_map()](#tidegaugeplot_on_map)<br />
[Tidegauge.plot_on_map_multiple()](#tidegaugeplot_on_map_multiple)<br />
[Tidegauge.obs_operator()](#tidegaugeobs_operator)<br />
[Tidegauge.time_slice()](#tidegaugetime_slice)<br />
[Tidegauge.subset_indices_lonlat_box()](#tidegaugesubset_indices_lonlat_box)<br />

Tide Gauge class
#### Tidegauge()
```python
class Tidegauge(Timeseries):
```

```
This is an object for storage and manipulation of tide gauge data
in a single dataset. This may require some processing of the observations
such as interpolation to a common time step.

This object's dataset should take the form (as with Timeseries):

    Dimensions:
        id_dim   : The locations dimension. Each time series has an index
        time : The time dimension. Each datapoint at each port has an index

    Coordinates:
        longitude (id_dim) : Longitude values for each port index
        latitude  (id_dim) : Latitude values for each port index
        time      (time) : Time values for each time index (datetime)
        id_name   (id_dim)   : Name of index, e.g. port name or mooring id.

An example data variable could be ssh, or ntr (non-tidal residual). This
object can also be used for other instrument types, not just tide gauges.
For example moorings.

Every id index for this object should use the same time coordinates.
Therefore, timeseries need to be aligned before being placed into the
object. If there is any padding needed, then NaNs should be used. NaNs
should also be used for quality control/data rejection.
```

##### Tidegauge.read_gesla_v3()
```python

def Tidegauge.read_gesla_v3(self, fn_gesla, date_start=None, date_end=None):
```
> <br />
> Depreciated method.<br />
> Call generalised method.<br />
> Returns eiter a tidegauge object or a list of tidegauge objects<br />
> <br />
##### Tidegauge.read_gesla()
```python

def Tidegauge.read_gesla(self, fn_gesla, date_start=None, date_end=None, format=v3):
```
> <br />
> For reading from a GESLA2 (Format version 3.0) or GESLA3 (Format v5.0)<br />
> file(s) into an xarray dataset.<br />
> <br />
> v3 formatting according to Woodworth et al. (2017).<br />
> v5 formatting ....<br />
> <br />
> Website: https://www.gesla.org/<br />
> If no data lies between the specified dates, a dataset is still created<br />
> containing information on the tide gauge, but the time dimension will<br />
> be empty.<br />
> Parameters<br />
> ----------<br />
> fn_gesla (str) : path to gesla tide gauge file, list of files or a glob<br />
> date_start (datetime) : start date for returning data<br />
> date_end (datetime) : end date for returning data<br />
> format (str) : accepts "v3" or "v5"<br />
> <br />
> Returns<br />
> -------<br />
> Creates xarray.dataset within tidegauge object containing loaded data.<br />
> If multiple files are provided then instead returns a list of NEW<br />
> tidegauge objects.<br />
> <br />
##### Tidegauge._read_gesla_header_v5()
```python
@classmethod
def Tidegauge._read_gesla_header_v5(cls, fn_gesla):
```
> <br />
> Reads header from a GESLA file (format version 5.0).<br />
> <br />
> Parameters<br />
> ----------<br />
> fn_gesla (str) : path to gesla tide gauge file<br />
> <br />
> Returns<br />
> -------<br />
> dictionary of attributes<br />
> <br />
##### Tidegauge._read_gesla_header_v3()
```python
@classmethod
def Tidegauge._read_gesla_header_v3(cls, fn_gesla):
```
> <br />
> Reads header from a GESLA file (format version 3.0).<br />
> <br />
> Parameters<br />
> ----------<br />
> fn_gesla (str) : path to gesla tide gauge file<br />
> <br />
> Returns<br />
> -------<br />
> dictionary of attributes<br />
> <br />
##### Tidegauge._read_gesla_data()
```python
@classmethod
def Tidegauge._read_gesla_data(cls, fn_gesla, date_start=None, date_end=None, header_length=32):
```
> <br />
> Reads observation data from a GESLA file (format version 3.0 and 5.0).<br />
> <br />
> Parameters<br />
> ----------<br />
> fn_gesla (str) : path to gesla tide gauge file<br />
> date_start (datetime) : start date for returning data<br />
> date_end (datetime) : end date for returning data<br />
> header_length (int) : number of lines in header (to skip when reading)<br />
> <br />
> Returns<br />
> -------<br />
> xarray.Dataset containing times, sealevel and quality control flags<br />
> <br />
##### Tidegauge.read_hlw()
```python

def Tidegauge.read_hlw(self, fn_hlw, date_start=None, date_end=None):
```
> <br />
> For reading from a file of tidetable High and Low Waters (HLW) data into an<br />
> xarray dataset. File contains high water and low water heights and times<br />
> <br />
> If no data lies between the specified dates, a dataset is still created<br />
> containing information on the tide gauge, but the time dimension will<br />
> be empty.<br />
> <br />
> <b>The data takes the form:</b><br />
> LIVERPOOL (GLADSTONE DOCK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  TZ: UT(GMT)/BST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Units: METRES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Datum: Chart Datum<br />
> 01/10/2020  06:29&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1.65<br />
> 01/10/2020  11:54&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  9.01<br />
> 01/10/2020  18:36&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1.87<br />
> ...<br />
> <br />
> Parameters<br />
> ----------<br />
> fn_hlw (str) : path to tabulated High Low Water file<br />
> date_start (datetime) : start date for returning data<br />
> date_end (datetime) : end date for returning data<br />
> <br />
> Returns<br />
> -------<br />
> xarray.Dataset object.<br />
> <br />
##### Tidegauge._read_hlw_header()
```python
@classmethod
def Tidegauge._read_hlw_header(cls, filnam):
```
> <br />
> Reads header from a HWL file.<br />
> <br />
> <b>The data takes the form:</b><br />
> LIVERPOOL (GLADSTONE DOCK) TZ: UT(GMT)/BST Units: METRES Datum: Chart Datum<br />
> 01/10/2020  06:29&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1.65<br />
> 01/10/2020  11:54&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  9.01<br />
> 01/10/2020  18:36&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  1.87<br />
> ...<br />
> <br />
> Parameters<br />
> ----------<br />
> filnam (str) : path to file<br />
> <br />
> Returns<br />
> -------<br />
> dictionary of attributes<br />
> <br />
##### Tidegauge._read_hlw_data()
```python
@classmethod
def Tidegauge._read_hlw_data(cls, filnam, header_dict, date_start=None, date_end=None, header_length=1):
```
> <br />
> Reads HLW data from a tidetable file.<br />
> <br />
> Parameters<br />
> ----------<br />
> filnam (str) : path to HLW tide gauge file<br />
> date_start (np.datetime64) : start date for returning data.<br />
> date_end (np.datetime64) : end date for returning data.<br />
> header_length (int) : number of lines in header (to skip when reading)<br />
> <br />
> Returns<br />
> -------<br />
> xarray.Dataset containing times, High and Low water values<br />
> <br />
##### Tidegauge.show()
```python

def Tidegauge.show(self, timezone=None):
```
> <br />
> Print out the values in the xarray<br />
> Displays with specified timezone<br />
> <br />
##### Tidegauge.get_tide_table_times()
```python

def Tidegauge.get_tide_table_times(self, time_guess=None, time_var=time, measure_var=ssh, method=window, winsize=None):
```
> <br />
> Get tide times and heights from tide table.<br />
> <b>input:</b><br />
> time_guess : np.datetime64 or datetime<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  assumes utc<br />
> time_var : name of time variable [default: 'time']<br />
> measure_var : name of ssh variable [default: 'ssh']<br />
> <br />
> method =<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  window:  +/- hours window size, winsize, (int) return values in that window<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  uses additional variable winsize (int) [default 2hrs]<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  nearest_1: return only the nearest event, if in winsize [default:None]<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  nearest_2: return nearest event in future and the nearest in the past (i.e. high and a low), if in winsize [default:None]<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  nearest_HW: return nearest High Water event (computed as the max of `nearest_2`), if in winsize [default:None]<br />
> <br />
> returns: xr.DataArray( measure_var, coords=time_var)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  E.g. ssh (m), time (utc)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  If value is not found, it returns a NaN with time value as the<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  guess value.<br />
> <br />
##### Tidegauge.read_ea_api_to_xarray()
```python
@classmethod
def Tidegauge.read_ea_api_to_xarray(cls, n_days=5, date_start=None, date_end=None, station_id=E70124):
```
> <br />
> load gauge data via environment.data.gov.uk EA API<br />
> Either loads last n_days, or from date_start:date_end<br />
> <br />
> <b>API Source:</b><br />
> https://environment.data.gov.uk/flood-monitoring/doc/reference<br />
> <br />
> <b>Details of available tidal stations are recovered with:</b><br />
> https://environment.data.gov.uk/flood-monitoring/id/stations?type=TideGauge<br />
> Recover the "stationReference" for the gauge of interest and pass as<br />
> station_id:str. The default station_id="E70124" is Liverpool.<br />
> <br />
> <b>INPUTS:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  n_days : int. Extact the last n_days from now.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  date_start : datetime. UTC format string "yyyy-MM-dd" E.g 2020-01-05<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  date_end : datetime<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  station_id : int. Station id. Also referred to as stationReference in<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   EA API. Default value is for Liverpool.<br />
> <b>OUTPUT:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ssh, time : xr.Dataset<br />
> <br />
##### Tidegauge.read_bodc()
```python

def Tidegauge.read_bodc(self, fn_bodc, date_start=None, date_end=None):
```
> <br />
> For reading from a single BODC (processed) file into an<br />
> xarray dataset.<br />
> If no data lies between the specified dates, a dataset is still created<br />
> containing information on the tide gauge, but the time dimension will<br />
> be empty.<br />
> <br />
> Data name: UK Tide Gauge Network, processed data.<br />
> Source: https://www.bodc.ac.uk/<br />
> See data notes from source for description of QC flags.<br />
> <br />
> <b>The data takes the form:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Port:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    P234<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Site:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    Liverpool, Gladstone Dock<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Latitude:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    53.44969<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Longitude:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   -3.01800<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Start Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  01AUG2020-00.00.00<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  End Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    31AUG2020-23.45.00<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Contributor:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     National Oceanography Centre, Liverpool<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Datum information: The data refer to Admiralty Chart Datum (ACD)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Parameter code:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ASLVBG02 = Surface elevation (unspecified datum)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  of the water body by bubbler tide gauge (second sensor)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    Cycle&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ASLVBG02   Residual<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Number yyyy mm dd hh mi ssf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    f<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   1) 2020/08/01 00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   5.354M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   0.265M<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   2) 2020/08/01 00:15:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   5.016M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   0.243M<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   3) 2020/08/01 00:30:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   4.704M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   0.241M<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   4) 2020/08/01 00:45:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   4.418M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   0.255M<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   5) 2020/08/01 01:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   4.133&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    0.257<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   ...<br />
> <br />
> Parameters<br />
> ----------<br />
> fn_bodc (str) : path to bodc tide gauge file<br />
> date_start (datetime) : start date for returning data<br />
> date_end (datetime) : end date for returning data<br />
> <br />
> Returns<br />
> -------<br />
> xarray.Dataset object.<br />
> <br />
##### Tidegauge._read_bodc_header()
```python
@staticmethod
def Tidegauge._read_bodc_header(fn_bodc):
```
> <br />
> Reads header from a BODC file (format version 3.0).<br />
> <br />
> Parameters<br />
> ----------<br />
> fn_bodc (str) : path to bodc tide gauge file<br />
> <br />
> Returns<br />
> -------<br />
> dictionary of attributes<br />
> <br />
##### Tidegauge._read_bodc_data()
```python
@staticmethod
def Tidegauge._read_bodc_data(fn_bodc, date_start=None, date_end=None, header_length=11):
```
> <br />
> Reads observation data from a BODC file.<br />
> <br />
> Parameters<br />
> ----------<br />
> fn_bodc (str) : path to bodc tide gauge file<br />
> date_start (datetime) : start date for returning data<br />
> date_end (datetime) : end date for returning data<br />
> header_length (int) : number of lines in header (to skip when reading)<br />
> <br />
> Returns<br />
> -------<br />
> xarray.Dataset containing times, sealevel and quality control flags<br />
> <br />
##### Tidegauge.plot_timeseries()
```python

def Tidegauge.plot_timeseries(self, id, var_list=unknown, date_start=None, date_end=None, plot_line=False):
```
> <br />
> Quick plot of time series stored within object's dataset<br />
> Parameters<br />
> ----------<br />
> date_start (datetime) : Start date for plotting<br />
> date_end (datetime) : End date for plotting<br />
> var_list  (str)  : List of variables to plot. Default: just ssh<br />
> plot_line (bool) : If true, draw line between markers<br />
> <br />
> Returns<br />
> -------<br />
> matplotlib figure and axes objects<br />
> <br />
##### Tidegauge.plot_on_map()
```python

def Tidegauge.plot_on_map(self):
```
> <br />
> Show the location of a tidegauge on a map.<br />
> <b>Example usage:</b><br />
> --------------<br />
> # For a TIDEGAUGE object tg<br />
> tg.plot_map()<br />
> <br />
##### Tidegauge.plot_on_map_multiple()
```python
@classmethod
def Tidegauge.plot_on_map_multiple(cls, tidegauge_list, color_var_str=None):
```
> <br />
> Show the location of a tidegauge on a map.<br />
> <b>Example usage:</b><br />
> --------------<br />
> # For a TIDEGAUGE object tg<br />
> tg.plot_map()<br />
> <br />
##### Tidegauge.obs_operator()
```python

def Tidegauge.obs_operator(self, gridded, time_interp=nearest):
```
> <br />
> Regrids a Gridded object onto a tidegauge_multiple object. A nearest<br />
> neighbour interpolation is done for spatial interpolation and time<br />
> interpolation can be specified using the time_interp argument. This<br />
> takes any scipy interpolation string. If Gridded object contains a<br />
> landmask variables, then the nearest WET point is taken for each tide<br />
> gauge.<br />
> <br />
> Output is a new tidegauge_multiple object containing interpolated data.<br />
> <br />
##### Tidegauge.time_slice()
```python

def Tidegauge.time_slice(self, date0, date1):
```
> <br />
> Return new Gridded object, indexed between dates date0 and date1<br />
> <br />
##### Tidegauge.subset_indices_lonlat_box()
```python

def Tidegauge.subset_indices_lonlat_box(self, lonbounds, latbounds):
```
> <br />
> Get a subset of this Profile() object in a spatial box.<br />
> <br />
> lonbounds -- Array of form [min_longitude=-180, max_longitude=180]<br />
> latbounds -- Array of form [min_latitude, max_latitude]<br />
> <br />
> return: A new profile object containing subsetted data<br />
> <br />