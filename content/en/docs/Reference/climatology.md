---
title: "Climatology"
linkTitle: "Climatology"
date: 2022-09-22
description: >
  Docstrings for the Climatology class
---
### Objects

[Climatology()](#climatology)<br />
[Climatology.make_climatology()](#climatologymake_climatology)<br />
[Climatology._get_date_ranges()](#climatology_get_date_ranges)<br />
[Climatology.multiyear_averages()](#climatologymultiyear_averages)<br />

Climatology class
#### Climatology()
```python
class Climatology(Coast):
```

```
A Python class containing methods for lazily creating climatologies of
NEMO data (or any xarray datasets) and writing to file. Also for resampling
methods.
```

##### Climatology.make_climatology()
```python
@staticmethod
def Climatology.make_climatology(ds, output_frequency, monthly_weights=False, time_var_name=time, time_dim_name=t_dim, fn_out=None):
```
> <br />
> Calculates a climatology for all variables in a supplied dataset.<br />
> The resulting xarray dataset will NOT be loaded to RAM. Instead,<br />
> it is a set of dask operations. To load to RAM use, e.g. .compute().<br />
> However, if the original data was large, this may take a long time and<br />
> a lot of memory. Make sure you have the available RAM or chunking<br />
> and parallel processes are specified correctly.<br />
> <br />
> Otherwise, it is recommended that you access the climatology data<br />
> in an indexed way. I.E. compute only at specific parts of the data<br />
> are once.<br />
> <br />
> The resulting cliamtology dataset can be written to disk using<br />
> .to_netcdf(). Again, this may take a while for larger datasets.<br />
> <br />
> ds :: xarray dataset object from a Coast object.<br />
> <b>output_frequency :: any xarray groupby string. i.e:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  'month'<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  'season'<br />
> time_var_name :: the string name of the time variable in dataset<br />
> time_dim_name :: the string name of the time dimension variable in dataset<br />
> fn_out :: string defining full output netcdf file path and name.<br />
> <br />
##### Climatology._get_date_ranges()
```python
@staticmethod
def Climatology._get_date_ranges(years, month_periods):
```
> <br />
> Calculates a list of datetime date ranges for a given list of years and a specified start/end month.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  years (list): A list of years to calculate date ranges for.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  month_periods (list): A list containing tuples of start and end month integers.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  (i.e. [(3,5),(12, 2)] is Mar -> May, Dec -> Feb). Must be in chronological order.<br />
> <br />
> <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  date_ranges (list): A list of tuples, each containing a start and end datetime.date object.<br />
> <br />
##### Climatology.multiyear_averages()
```python
@classmethod
def Climatology.multiyear_averages(cls, ds, month_periods, time_var=time, time_dim=t_dim):
```
> <br />
> Calculate multiyear means for all Data variables in a dataset between a given start and end month.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ds (xr.Dataset): xarray dataset containing data.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  month_periods (list): A list containing tuples of start and end month integers.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  (i.e. [(3,5),(12, 2)] is Mar -> May, Dec -> Feb). Must be in chronological order.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The seasons module can be used for convenience (e.g. seasons.WINTER, seasons.ALL etc. )<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  time_var (str): String representing the time variable name within the dataset.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  time_dim (str): String representing the time dimension name within the dataset.<br />
> <b>returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ds_mean (xr.Dataset): A new dataset containing mean averages for each data variable across all years and<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  date periods. Indexed by the multi-index 'year_period' (i.e. (2000, 'Dec-Feb')).<br />
> <br />