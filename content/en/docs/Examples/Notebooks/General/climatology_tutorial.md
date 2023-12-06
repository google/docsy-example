---
    title: "Climatology tutorial"
    linkTitle: "Climatology tutorial"
    weight: 5

    description: >
        Climatology tutorial example.
---
This demonstration has two parts:

1)  Climatology.make_climatology():
    This demonstration uses the COAsT package to calculate a climatological mean of an
    input dataset at a desired output frequency. Output can be written straight
    to file.

2) Climatology.make_multiyear_climatology():
    This demonstrations uses the COAsT package to calculate a climatological mean of an
    input dataset at a desired output frequency, over multiple years, but will work with single year datasets too.

COAsT and xarray should preserve any lazy loading and chunking. If defined
properly in the read function, memory issues can be avoided and parallel
processes will automatically be used.


```python
import coast
```

    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pydap/lib.py:5: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap.responses')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2350: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap.handlers')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2350: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap.tests')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2350: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('sphinxcontrib')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages


### Usage of coast.Climatology.make_climatology().

Calculates mean over a given period of time. This doesn't take different years into account, unless using the
'years' frequency.


```python
root = "./"
# Paths to a single or multiple data files.
dn_files = root + "./example_files/"
fn_nemo_dat = dn_files + "coast_example_nemo_data.nc"
fn_nemo_config = root + "./config/example_nemo_grid_t.json"
# Set path for domain file if required.
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
# Define output filepath (optional: None or str)
fn_out = None

# Read in multiyear data (This example uses NEMO data from a single file.)
nemo_data = coast.Gridded(fn_data=fn_nemo_dat,
                          fn_domain=fn_nemo_dom,
                          config=fn_nemo_config,
                          ).dataset

```

    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/dataset.py:278: UserWarning: The specified chunks separate the stored chunks along dimension "time_counter" starting at index 2. This could degrade performance. Instead, consider rechunking after loading.


Calculate the climatology for temperature and sea surface height (ssh) as an example:


```python
# Select specific data variables.
data = nemo_data[["temperature", "ssh"]]

# Define frequency -- Any xarray time string: season, month, etc
climatology_frequency = "month"

# Calculate the climatology and write to file.
clim = coast.Climatology()
clim_mean = clim.make_climatology(data, climatology_frequency, fn_out=fn_out)
```

Below shows the structure of a dataset returned, containing 1 month worth of meaned temperature and sea surface height data:


```python
#clim_mean  # uncomment to print data object summary
```

### Usage of coast.Climatology.multiyear_averages().

Calculates the mean over a specified period and groups the data by year-period. Here a fully working example is not available as multi-year example data is not in the `example_files`. However a working example using synthetic data is given in: `tests/test_climatology.py`. This method is designed to be compatible with multi-year datasets, but will work with single year datasets too.

```
# Paths to a single or multiple data files.
fn_nemo_data = "/path/to/nemo/*.nc"
# Set path for domain file if required.
fn_nemo_domain = None
# Set path to configuration file
fn_nemo_config = "/path/to/nemo/*.json"

# Read in multiyear data (This example uses NEMO data from multiple datafiles.)
nemo_data = coast.Gridded(fn_data=fn_nemo_data,
                          fn_domain=fn_nemo_domain,
                          config=fn_nemo_config,
                          multiple=True).dataset

```

Now calculate temperature and ssh means of each season across multiple years for specified data, using seasons module to specify time period.

```
from coast._utils import seasons

# Select specific data variables.
data = nemo_data[["temperature", "ssh"]]

clim = coast.Climatology()
# SPRING, SUMMER, AUTUMN, WINTER, ALL are valid values for seasons.
clim_multiyear = clim.multiyear_averages(data, seasons.ALL, time_var='time', time_dim='t_dim')

# Or explicitly defining specific month periods.
# A list of tuples defining start and end month integers. The start months should be in chronological order.
# (you may need to read/load the data again if it gives an error)

month_periods = [(1,2), (12,2)] # Specifies January -> February and December -> February for each year of data. 
clim_multiyear = clim.multiyear_averages(data, month_periods , time_var='time', time_dim='t_dim')
```


```python

```
