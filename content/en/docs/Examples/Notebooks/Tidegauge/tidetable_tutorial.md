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

    Tidegauge object at 0x5632479c1fc0 initialised


Specify the data read as a High Low Water dataset.


```python
tg.read_hlw(filnam, date_start, date_end)
```


    ---------------------------------------------------------------------------

    FileNotFoundError                         Traceback (most recent call last)

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in read_hlw(self, fn_hlw, date_start, date_end)
        437         try:
    --> 438             header_dict = self._read_hlw_header(fn_hlw)
        439             dataset = self._read_hlw_data(fn_hlw, header_dict, date_start, date_end)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in _read_hlw_header(cls, filnam)
        474         debug(f'Reading HLW header from "{filnam}" ')
    --> 475         fid = open(filnam)
        476 


    FileNotFoundError: [Errno 2] No such file or directory: './example_files/Gladstone_2020-10_HLW.txt'

    
    During handling of the above exception, another exception occurred:


    Exception                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/366676465.py in <cell line: 1>()
    ----> 1 tg.read_hlw(filnam, date_start, date_end)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in read_hlw(self, fn_hlw, date_start, date_end)
        446 
        447         except:
    --> 448             raise Exception("Problem reading HLW file: " + fn_hlw)
        449 
        450         dataset.attrs = header_dict


    Exception: Problem reading HLW file: ./example_files/Gladstone_2020-10_HLW.txt


Show dataset. If timezone is specified then it is presented as requested, otherwise uses UTC.


```python
print("Try the TideGauge.show() method:")
tg.show(timezone="Europe/London")
```

    Try the TideGauge.show() method:



    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3701/292700469.py in <cell line: 2>()
          1 print("Try the TideGauge.show() method:")
    ----> 2 tg.show(timezone="Europe/London")
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in show(self, timezone)
        584                 )
        585         else:  # display timezone aware times
    --> 586             for i in range(len(self.dataset.ssh)):
        587                 #               debug('time:', self.dataset.time[i].values,
        588                 debug(


    AttributeError: 'NoneType' object has no attribute 'ssh'


Do a basic plot of these points.


```python
tg.dataset.plot.scatter(x="time", y="ssh")
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    /tmp/ipykernel_3701/400671403.py in <cell line: 1>()
    ----> 1 tg.dataset.plot.scatter(x="time", y="ssh")
    

    AttributeError: 'NoneType' object has no attribute 'plot'


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


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/3968300378.py in <cell line: 1>()
    ----> 1 HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="window", winsize=24)
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in get_tide_table_times(self, time_guess, time_var, measure_var, method, winsize)
        638             # initialise start_index and end_index
        639             start_index = 0
    --> 640             end_index = len(self.dataset[time_var])
        641 
        642             date_start = time_guess - np.timedelta64(winsize, "h")


    TypeError: 'NoneType' object is not subscriptable


Alternatively recover the closest HLW event to the input timestamp.


```python
HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_1")
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/3989562489.py in <cell line: 1>()
    ----> 1 HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_1")
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in get_tide_table_times(self, time_guess, time_var, measure_var, method, winsize)
        651 
        652         elif method == "nearest_1":
    --> 653             dt = np.abs(self.dataset[time_var] - time_guess)
        654             index = np.argsort(dt).values
        655             if winsize is not None:  # if search window trucation exists


    TypeError: 'NoneType' object is not subscriptable


Or the nearest two events to the input timestamp.


```python
HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_2")
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/1681129912.py in <cell line: 1>()
    ----> 1 HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_2")
    

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in get_tide_table_times(self, time_guess, time_var, measure_var, method, winsize)
        668 
        669         elif method == "nearest_2":
    --> 670             index = np.argsort(np.abs(self.dataset[time_var] - time_guess)).values
        671             nearest_2 = self.dataset[measure_var].isel(time=index[0 : 1 + 1])  # , self.dataset.time[index[0:1+1]]
        672             return nearest_2[0]


    TypeError: 'NoneType' object is not subscriptable


Extract the Low Tide value.


```python
print("Try the TideGauge.get_tidetabletimes() methods:")
print("LT:", HLW[np.argmin(HLW.data)].values, "m at", HLW[np.argmin(HLW.data)].time.values)
```

    Try the TideGauge.get_tidetabletimes() methods:



    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/1456069890.py in <cell line: 2>()
          1 print("Try the TideGauge.get_tidetabletimes() methods:")
    ----> 2 print("LT:", HLW[np.argmin(HLW.data)].values, "m at", HLW[np.argmin(HLW.data)].time.values)
    

    NameError: name 'HLW' is not defined


Extract the High Tide value.


```python
print("HT:", HLW[np.argmax(HLW.data)].values, "m at", HLW[np.argmax(HLW.data)].time.values)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/2493043573.py in <cell line: 1>()
    ----> 1 print("HT:", HLW[np.argmax(HLW.data)].values, "m at", HLW[np.argmax(HLW.data)].time.values)
    

    NameError: name 'HLW' is not defined


Or use the the nearest High Tide method to get High Tide.


```python
HT = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_HW")
print("HT:", HT.values, "m at", HT.time.values)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/1194467985.py in <cell line: 1>()
    ----> 1 HT = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), method="nearest_HW")
          2 print("HT:", HT.values, "m at", HT.time.values)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in get_tide_table_times(self, time_guess, time_var, measure_var, method, winsize)
        673 
        674         elif method == "nearest_HW":
    --> 675             index = np.argsort(np.abs(self.dataset[time_var] - time_guess)).values
        676             # return self.dataset.ssh[ index[np.argmax( self.dataset.ssh[index[0:1+1]]] )] #, self.dataset.time[index[0:1+1]]
        677             nearest_2 = self.dataset[measure_var].isel(time=index[0 : 1 + 1])  # , self.dataset.time[index[0:1+1]]


    TypeError: 'NoneType' object is not subscriptable


The get_tidetabletimes() method can take extra paremeters such as a window size, an integer number of hours to seek either side of the guess.


```python
HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), winsize=2, method="nearest_1")


HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), winsize=1, method="nearest_1")
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    /tmp/ipykernel_3701/1377186462.py in <cell line: 1>()
    ----> 1 HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), winsize=2, method="nearest_1")
          2 
          3 
          4 HLW = tg.get_tide_table_times(np.datetime64("2020-10-13 12:48"), winsize=1, method="nearest_1")


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/coast/data/tidegauge.py in get_tide_table_times(self, time_guess, time_var, measure_var, method, winsize)
        651 
        652         elif method == "nearest_1":
    --> 653             dt = np.abs(self.dataset[time_var] - time_guess)
        654             index = np.argsort(dt).values
        655             if winsize is not None:  # if search window trucation exists


    TypeError: 'NoneType' object is not subscriptable



```python

```
