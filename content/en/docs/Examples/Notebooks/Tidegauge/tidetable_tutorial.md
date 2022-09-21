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

    Tidegauge object at 0x55eff512cfc0 initialised


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


Do a basic plot of these points.


```python
tg.dataset.plot.scatter(x="time", y="ssh")
```




    <matplotlib.collections.PathCollection at 0x7f00e173aa30>




    
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
print("LT:", HLW[np.argmin(HLW)].values, "m at", HLW[np.argmin(HLW)].time.values)
```

    Try the TideGauge.get_tidetabletimes() methods:



    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in _wrapfunc(obj, method, *args, **kwds)
         56     try:
    ---> 57         return bound(*args, **kwds)
         58     except TypeError:


    TypeError: argmin() got an unexpected keyword argument 'out'

    
    During handling of the above exception, another exception occurred:


    ValueError                                Traceback (most recent call last)

    /tmp/ipykernel_3891/599271272.py in <cell line: 2>()
          1 print("Try the TideGauge.get_tidetabletimes() methods:")
    ----> 2 print("LT:", HLW[np.argmin(HLW)].values, "m at", HLW[np.argmin(HLW)].time.values)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/overrides.py in argmin(*args, **kwargs)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in argmin(a, axis, out, keepdims)
       1310     """
       1311     kwds = {'keepdims': keepdims} if keepdims is not np._NoValue else {}
    -> 1312     return _wrapfunc(a, 'argmin', axis=axis, out=out, **kwds)
       1313 
       1314 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in _wrapfunc(obj, method, *args, **kwds)
         64         # Call _wrapit from within the except clause to ensure a potential
         65         # exception has a traceback chain.
    ---> 66         return _wrapit(obj, method, *args, **kwds)
         67 
         68 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in _wrapit(obj, method, *args, **kwds)
         45         if not isinstance(result, mu.ndarray):
         46             result = asarray(result)
    ---> 47         result = wrap(result)
         48     return result
         49 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/dataarray.py in __array_wrap__(self, obj, context)
       3485 
       3486     def __array_wrap__(self: T_DataArray, obj, context=None) -> T_DataArray:
    -> 3487         new_var = self.variable.__array_wrap__(obj, context)
       3488         return self._replace(new_var)
       3489 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/variable.py in __array_wrap__(self, obj, context)
       2494 
       2495     def __array_wrap__(self, obj, context=None):
    -> 2496         return Variable(self.dims, obj)
       2497 
       2498     def _unary_op(self, f, *args, **kwargs):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/variable.py in __init__(self, dims, data, attrs, encoding, fastpath)
        318         """
        319         self._data = as_compatible_data(data, fastpath=fastpath)
    --> 320         self._dims = self._parse_dimensions(dims)
        321         self._attrs = None
        322         self._encoding = None


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/variable.py in _parse_dimensions(self, dims)
        578         dims = tuple(dims)
        579         if len(dims) != self.ndim:
    --> 580             raise ValueError(
        581                 f"dimensions {dims} must have the same length as the "
        582                 f"number of data dimensions, ndim={self.ndim}"


    ValueError: dimensions ('time',) must have the same length as the number of data dimensions, ndim=0


Extract the High Tide value.


```python
print("HT:", HLW[np.argmax(HLW)].values, "m at", HLW[np.argmax(HLW)].time.values)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in _wrapfunc(obj, method, *args, **kwds)
         56     try:
    ---> 57         return bound(*args, **kwds)
         58     except TypeError:


    TypeError: argmax() got an unexpected keyword argument 'out'

    
    During handling of the above exception, another exception occurred:


    ValueError                                Traceback (most recent call last)

    /tmp/ipykernel_3891/219298863.py in <cell line: 1>()
    ----> 1 print("HT:", HLW[np.argmax(HLW)].values, "m at", HLW[np.argmax(HLW)].time.values)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/overrides.py in argmax(*args, **kwargs)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in argmax(a, axis, out, keepdims)
       1214     """
       1215     kwds = {'keepdims': keepdims} if keepdims is not np._NoValue else {}
    -> 1216     return _wrapfunc(a, 'argmax', axis=axis, out=out, **kwds)
       1217 
       1218 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in _wrapfunc(obj, method, *args, **kwds)
         64         # Call _wrapit from within the except clause to ensure a potential
         65         # exception has a traceback chain.
    ---> 66         return _wrapit(obj, method, *args, **kwds)
         67 
         68 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/numpy/core/fromnumeric.py in _wrapit(obj, method, *args, **kwds)
         45         if not isinstance(result, mu.ndarray):
         46             result = asarray(result)
    ---> 47         result = wrap(result)
         48     return result
         49 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/dataarray.py in __array_wrap__(self, obj, context)
       3485 
       3486     def __array_wrap__(self: T_DataArray, obj, context=None) -> T_DataArray:
    -> 3487         new_var = self.variable.__array_wrap__(obj, context)
       3488         return self._replace(new_var)
       3489 


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/variable.py in __array_wrap__(self, obj, context)
       2494 
       2495     def __array_wrap__(self, obj, context=None):
    -> 2496         return Variable(self.dims, obj)
       2497 
       2498     def _unary_op(self, f, *args, **kwargs):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/variable.py in __init__(self, dims, data, attrs, encoding, fastpath)
        318         """
        319         self._data = as_compatible_data(data, fastpath=fastpath)
    --> 320         self._dims = self._parse_dimensions(dims)
        321         self._attrs = None
        322         self._encoding = None


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/core/variable.py in _parse_dimensions(self, dims)
        578         dims = tuple(dims)
        579         if len(dims) != self.ndim:
    --> 580             raise ValueError(
        581                 f"dimensions {dims} must have the same length as the "
        582                 f"number of data dimensions, ndim={self.ndim}"


    ValueError: dimensions ('time',) must have the same length as the number of data dimensions, ndim=0


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


```python

```
