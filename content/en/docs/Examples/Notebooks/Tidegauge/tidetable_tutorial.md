---
    title: "Tidetable tutorial"
    linkTitle: "Tidetable tutorial"
    weight: 5

    description: >
        Tidetable tutorial example.
---
### Tutorial for processing tabulated tide gauge data.

Tidal highs and lows can be scraped from a website such as:<br>
https://www.ntslf.org/tides/tidepred?port=Liverpool<br>
![NTSLF tidal predictions](https://www.ntslf.org/files/ntslf_php/plottide.php?port=Liverpool)

and format them into a csv file:<br>

LIVERPOOL (GLADSTONE DOCK)    TZ: UT(GMT)/BST     Units: METRES    Datum: Chart Datum<br>
01/10/2020  06:29    1.65<br>
01/10/2020  11:54    9.01<br>
01/10/2020  18:36    1.87<br>

The data can be used in the following demonstration.


```python
import coast
import numpy as np
```

Load and plot High and Low Water data.


```python
print("load and plot HLW data")
filnam = "./example_files/Gladstone_2020-10_HLW.txt"
```

    load and plot HLW data


Set the start and end dates.


```python
date_start = np.datetime64("2020-10-12 23:59")
date_end = np.datetime64("2020-10-14 00:01")
```

Initiate a TideGauge object, if a filename is passed it assumes it is a GESLA type object.


```python
tg = coast.Tidegauge()
```

    Tidegauge object at 0x55af750be980 initialised


Specify the data read as a High Low Water dataset.


```python
tg.read_hlw(filnam, date_start, date_end)
```

Show dataset. If timezone is specified then it is presented as requested, otherwise uses UTC.


```python
print("Try the TideGauge.show() method:")
tg.show(timezone="Europe/London")
```

    Try the TideGauge.show() method:



    ---------------------------------------------------------------------------

    IndexError                                Traceback (most recent call last)

    Cell In[6], line 2
          1 print("Try the TideGauge.show() method:")
    ----> 2 tg.show(timezone="Europe/London")


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/coast/data/tidegauge.py:599, in Tidegauge.show(self, timezone)
        594 else:  # display timezone aware times
        595     for ssh, idx in enumerate(self.dataset.ssh):
        596         # debug('time:', self.dataset.time[i].values,
        597         debug(
        598             "time (" + timezone + "):",
    --> 599             general_utils.day_of_week(self.dataset.time[idx].values),
        600             np.datetime_as_string(self.dataset.time[idx], unit="m", timezone=pytz.timezone(timezone)),
        601             "height:",
        602             ssh.values,
        603             "m",
        604         )


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/dataarray.py:851, in DataArray.__getitem__(self, key)
        848     return self._getitem_coord(key)
        849 else:
        850     # xarray-style array indexing
    --> 851     return self.isel(indexers=self._item_key_to_dict(key))


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/dataarray.py:1453, in DataArray.isel(self, indexers, drop, missing_dims, **indexers_kwargs)
       1450 indexers = either_dict_or_kwargs(indexers, indexers_kwargs, "isel")
       1452 if any(is_fancy_indexer(idx) for idx in indexers.values()):
    -> 1453     ds = self._to_temp_dataset()._isel_fancy(
       1454         indexers, drop=drop, missing_dims=missing_dims
       1455     )
       1456     return self._from_temp_dataset(ds)
       1458 # Much faster algorithm for when all indexers are ints, slices, one-dimensional
       1459 # lists, or zero or one-dimensional np.ndarray's


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/dataset.py:2947, in Dataset._isel_fancy(self, indexers, drop, missing_dims)
       2944 valid_indexers = dict(self._validate_indexers(indexers, missing_dims))
       2946 variables: dict[Hashable, Variable] = {}
    -> 2947 indexes, index_variables = isel_indexes(self.xindexes, valid_indexers)
       2949 for name, var in self.variables.items():
       2950     if name in index_variables:


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/indexes.py:1796, in isel_indexes(indexes, indexers)
       1792 def isel_indexes(
       1793     indexes: Indexes[Index],
       1794     indexers: Mapping[Any, Any],
       1795 ) -> tuple[dict[Hashable, Index], dict[Hashable, Variable]]:
    -> 1796     return _apply_indexes(indexes, indexers, "isel")


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/indexes.py:1780, in _apply_indexes(indexes, args, func)
       1778 index_args = {k: v for k, v in args.items() if k in index_dims}
       1779 if index_args:
    -> 1780     new_index = getattr(index, func)(index_args)
       1781     if new_index is not None:
       1782         new_indexes.update({k: new_index for k in index_vars})


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/indexes.py:726, in PandasIndex.isel(self, indexers)
        722 if not isinstance(indxr, slice) and is_scalar(indxr):
        723     # scalar indexer: drop index
        724     return None
    --> 726 return self._replace(self.index[indxr])


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pandas/core/indexes/base.py:5196, in Index.__getitem__(self, key)
       5193     else:
       5194         key = np.asarray(key, dtype=bool)
    -> 5196 result = getitem(key)
       5197 # Because we ruled out integer above, we always get an arraylike here
       5198 if result.ndim > 1:


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pandas/core/arrays/datetimelike.py:370, in DatetimeLikeArrayMixin.__getitem__(self, key)
        362 """
        363 This getitem defers to the underlying array, which by-definition can
        364 only handle list-likes, slices, and integer scalars
        365 """
        366 # Use cast as we know we will get back a DatetimeLikeArray or DTScalar,
        367 # but skip evaluating the Union at runtime for performance
        368 # (see https://github.com/pandas-dev/pandas/pull/44624)
        369 result = cast(
    --> 370     "Union[DatetimeLikeArrayT, DTScalarOrNaT]", super().__getitem__(key)
        371 )
        372 if lib.is_scalar(result):
        373     return result


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pandas/core/arrays/_mixins.py:280, in NDArrayBackedExtensionArray.__getitem__(self, key)
        277 # error: Incompatible types in assignment (expression has type "ExtensionArray",
        278 # variable has type "Union[int, slice, ndarray]")
        279 key = extract_array(key, extract_numpy=True)  # type: ignore[assignment]
    --> 280 key = check_array_indexer(self, key)
        281 result = self._ndarray[key]
        282 if lib.is_scalar(result):


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pandas/core/indexers/utils.py:553, in check_array_indexer(array, indexer)
        549         raise ValueError(
        550             "Cannot index with an integer indexer containing NA values"
        551         ) from err
        552 else:
    --> 553     raise IndexError("arrays used as indices must be of integer or boolean type")
        555 return indexer


    IndexError: arrays used as indices must be of integer or boolean type


Do a basic plot of these points.


```python
tg.dataset.plot.scatter(x="time", y="ssh")
```




    <matplotlib.collections.PathCollection at 0x7f5effe29a50>




    
![png](/COAsT/tidetable_tutorial_files/tidetable_tutorial_14_1.png)
    


There is a method to locate HLW events around an approximate date and time.
First state the time of interest.


```python
time_guess = np.datetime64("2020-10-13 12:48")
```

Then recover all the HLW events in a +/- window, of specified size (iteger hrs).
The default winsize = 2 (hrs).


```python
HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="window", winsize=24)
```

Alternatively recover the closest HLW event to the input timestamp.


```python
HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_1")
```

Or the nearest two events to the input timestamp.


```python
HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_2")
```

Extract the Low Tide value.


```python
print("Try the TideGauge.get_tidetabletimes() methods:")
print("LT:", HLW[np.argmin(HLW.data)].values, "m at", HLW[np.argmin(HLW.data)].time.values)
```

    Try the TideGauge.get_tidetabletimes() methods:
    LT: 2.83 m at 2020-10-13T14:36:00.000000000


Extract the High Tide value.


```python
print("HT:", HLW[np.argmax(HLW.data)].values, "m at", HLW[np.argmax(HLW.data)].time.values)
```

    HT: 8.01 m at 2020-10-13T07:59:00.000000000


Or use the the nearest High Tide method to get High Tide.


```python
HT = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_HW")
print("HT:", HT.values, "m at", HT.time.values)
```

    HT: [8.01] m at 2020-10-13T07:59:00.000000000


The get_tidetabletimes() method can take extra paremeters such as a window size, an integer number of hours to seek either side of the guess.


```python
HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), winsize=2, method="nearest_1")


HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), winsize=1, method="nearest_1")
```

    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/coast/data/tidegauge.py:676: UserWarning: Converting non-nanosecond precision datetime values to nanosecond precision. This behavior can eventually be relaxed in xarray, as it is an artifact from pandas which is now beginning to support non-nanosecond precision values. This warning is caused by passing non-nanosecond np.datetime64 or np.timedelta64 values to the DataArray or Variable constructor; it can be silenced by converting the values to nanosecond precision ahead of time.
      return xr.DataArray([np.NaN], dims=(time_var), coords={time_var: [time_guess]})[0]



```python

```
