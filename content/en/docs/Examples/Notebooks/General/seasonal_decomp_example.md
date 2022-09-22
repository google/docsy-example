---
    title: "Seasonal decomp example"
    linkTitle: "Seasonal decomp example"
    weight: 5

    description: >
        Seasonal decomp example example.
---
## Overview
A function within the Process_data class that will decompose time series into trend, seasonal and residual components. The function is a wrapper that adds functionality to the `seasonal_decompose` function contained in the [statsmodels](https://www.statsmodels.org/stable/generated/statsmodels.tsa.seasonal.seasonal_decompose.html#statsmodels.tsa.seasonal.seasonal_decompose) package to make it more convenient for large geospatial datasets.

Specifically:
1) Multiple time series spread across multiple dimensions, e.g. a gridded dataset, can be processed. The user simply passes in an xarray DataArray that has a "t_dim" dimension and 1 or more additional dimensions, for example gridded spatial dimensions
2) Masked locations, such as land points, are handled
3) A [dask](https://www.dask.org/) wrapper is applied to the function that 
    a) supports lazy evaluation
    b) allows the dataset to be easily seperated into chunks so that processing can be carried out in parallel (rather than processing every time series sequentially)
4) The decomposed time series are returned as xarray DataArrays within a single coast.Gridded object

## An example
Below is an example using the `coast.Process_data.seasonal_decomposition` function with the example data. Note that we will artifically extend the length of the example data time series for demonstrative purposes.

Begin by importing coast, defining paths to the data, and loading the example data into a gridded object:


```python
import coast
import numpy as np
import xarray as xr

# Path to a data file
root = "./"
dn_files = root + "./example_files/"

fn_nemo_dat  = dn_files + "coast_example_nemo_data.nc"
# Set path for domain file if required.
fn_nemo_dom  = dn_files + "coast_example_nemo_domain.nc"
# Set path for model configuration file
config = root + "./config/example_nemo_grid_t.json"

# Read in data (This example uses NEMO data.)
grd = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=config)
```

The loaded example data only has 7 time stamps, the code below creates a new (fake) extended temperature variable with 48 monthly records. This code is not required to use the function, it is only included here to make a set of time series that are long enough to be interesting.


```python
# create a 4 yr monthly time coordinate array
time_array = np.arange(
    np.datetime64("2010-01-01"), np.datetime64("2014-01-01"), np.timedelta64(1, "M"), dtype="datetime64[M]"
).astype("datetime64[s]")

# create 4 years of monthly temperature data based on the loaded data
temperature_array = (
    (np.arange(0, 48) * 0.05)[:, np.newaxis, np.newaxis, np.newaxis]
    + np.random.normal(0, 0.1, 48)[:, np.newaxis, np.newaxis, np.newaxis]
    + np.tile(grd.dataset.temperature[:-1, :2, :, :], (8, 1, 1, 1))
)

# create a new temperature DataArray
temperature = xr.DataArray(
    temperature_array,
    coords={
        "t_dim": time_array,
        "depth_0": grd.dataset.depth_0[:2, :, :],
        "longitude": grd.dataset.longitude,
        "latitude": grd.dataset.latitude,
    },
    dims=["t_dim", "z_dim", "y_dim", "x_dim"],
)
```

Check out the new data


```python
#temperature # uncomment to print data object summary
```


```python
temperature[0,0,:,:].plot()
```




    <matplotlib.collections.QuadMesh at 0x7f54288200a0>




    
![png](/COAsT/seasonal_decomp_example_files/seasonal_decomp_example_7_1.png)
    


Check out time series at 2 different grid points


```python
temperature[:,0,50,50].plot()
temperature[:,0,200,200].plot()
```




    [<matplotlib.lines.Line2D at 0x7f5428659c40>]




    
![png](/COAsT/seasonal_decomp_example_files/seasonal_decomp_example_9_1.png)
    


Create a `coast.Process_data` object, and call the `seasonal_decomposition` function, passing in the required arguments. The first two arguments are:
1. The input data, here the temperature data as an xarray DataArray
2. The number of chuncks to split the data into. Here we split the data into 2 chunks so that the dask scheduler will try to run 4 processes in parallel

The remaining arguments are keyword arguments for the underlying `statsmodels.tsa.seasonal.seasonal_decompose` function, which are documented on the [statsmodels documentation pages](https://www.statsmodels.org/stable/generated/statsmodels.tsa.seasonal.seasonal_decompose.html#statsmodels.tsa.seasonal.seasonal_decompose).  Here we specify:

3. three The type of model, i.e. an additive model
4. The period of the seasonal cycle, here it is 6 months
5. Extrapolate the trend component to cover the entire range of the time series (this is required because the trend is calculated using a convolution filter) 



```python
proc_data = coast.Process_data()
grd = proc_data.seasonal_decomposition(temperature, 2, model="additive", period=6, extrapolate_trend="freq")
```

The returned xarray Dataset contains the decomposed time series (trend, seasonal, residual) as dask arrays


```python
#grd.dataset # uncomment to print data object summary
```

Execute the computation


```python
grd.dataset.compute()
```




<div><svg style="position: absolute; width: 0; height: 0; overflow: hidden">
<defs>
<symbol id="icon-database" viewBox="0 0 32 32">
<path d="M16 0c-8.837 0-16 2.239-16 5v4c0 2.761 7.163 5 16 5s16-2.239 16-5v-4c0-2.761-7.163-5-16-5z"></path>
<path d="M16 17c-8.837 0-16-2.239-16-5v6c0 2.761 7.163 5 16 5s16-2.239 16-5v-6c0 2.761-7.163 5-16 5z"></path>
<path d="M16 26c-8.837 0-16-2.239-16-5v6c0 2.761 7.163 5 16 5s16-2.239 16-5v-6c0 2.761-7.163 5-16 5z"></path>
</symbol>
<symbol id="icon-file-text2" viewBox="0 0 32 32">
<path d="M28.681 7.159c-0.694-0.947-1.662-2.053-2.724-3.116s-2.169-2.030-3.116-2.724c-1.612-1.182-2.393-1.319-2.841-1.319h-15.5c-1.378 0-2.5 1.121-2.5 2.5v27c0 1.378 1.122 2.5 2.5 2.5h23c1.378 0 2.5-1.122 2.5-2.5v-19.5c0-0.448-0.137-1.23-1.319-2.841zM24.543 5.457c0.959 0.959 1.712 1.825 2.268 2.543h-4.811v-4.811c0.718 0.556 1.584 1.309 2.543 2.268zM28 29.5c0 0.271-0.229 0.5-0.5 0.5h-23c-0.271 0-0.5-0.229-0.5-0.5v-27c0-0.271 0.229-0.5 0.5-0.5 0 0 15.499-0 15.5 0v7c0 0.552 0.448 1 1 1h7v19.5z"></path>
<path d="M23 26h-14c-0.552 0-1-0.448-1-1s0.448-1 1-1h14c0.552 0 1 0.448 1 1s-0.448 1-1 1z"></path>
<path d="M23 22h-14c-0.552 0-1-0.448-1-1s0.448-1 1-1h14c0.552 0 1 0.448 1 1s-0.448 1-1 1z"></path>
<path d="M23 18h-14c-0.552 0-1-0.448-1-1s0.448-1 1-1h14c0.552 0 1 0.448 1 1s-0.448 1-1 1z"></path>
</symbol>
</defs>
</svg>
<style>/* CSS stylesheet for displaying xarray objects in jupyterlab.
 *
 */

:root {
  --xr-font-color0: var(--jp-content-font-color0, rgba(0, 0, 0, 1));
  --xr-font-color2: var(--jp-content-font-color2, rgba(0, 0, 0, 0.54));
  --xr-font-color3: var(--jp-content-font-color3, rgba(0, 0, 0, 0.38));
  --xr-border-color: var(--jp-border-color2, #e0e0e0);
  --xr-disabled-color: var(--jp-layout-color3, #bdbdbd);
  --xr-background-color: var(--jp-layout-color0, white);
  --xr-background-color-row-even: var(--jp-layout-color1, white);
  --xr-background-color-row-odd: var(--jp-layout-color2, #eeeeee);
}

html[theme=dark],
body.vscode-dark {
  --xr-font-color0: rgba(255, 255, 255, 1);
  --xr-font-color2: rgba(255, 255, 255, 0.54);
  --xr-font-color3: rgba(255, 255, 255, 0.38);
  --xr-border-color: #1F1F1F;
  --xr-disabled-color: #515151;
  --xr-background-color: #111111;
  --xr-background-color-row-even: #111111;
  --xr-background-color-row-odd: #313131;
}

.xr-wrap {
  display: block !important;
  min-width: 300px;
  max-width: 700px;
}

.xr-text-repr-fallback {
  /* fallback to plain text repr when CSS is not injected (untrusted notebook) */
  display: none;
}

.xr-header {
  padding-top: 6px;
  padding-bottom: 6px;
  margin-bottom: 4px;
  border-bottom: solid 1px var(--xr-border-color);
}

.xr-header > div,
.xr-header > ul {
  display: inline;
  margin-top: 0;
  margin-bottom: 0;
}

.xr-obj-type,
.xr-array-name {
  margin-left: 2px;
  margin-right: 10px;
}

.xr-obj-type {
  color: var(--xr-font-color2);
}

.xr-sections {
  padding-left: 0 !important;
  display: grid;
  grid-template-columns: 150px auto auto 1fr 20px 20px;
}

.xr-section-item {
  display: contents;
}

.xr-section-item input {
  display: none;
}

.xr-section-item input + label {
  color: var(--xr-disabled-color);
}

.xr-section-item input:enabled + label {
  cursor: pointer;
  color: var(--xr-font-color2);
}

.xr-section-item input:enabled + label:hover {
  color: var(--xr-font-color0);
}

.xr-section-summary {
  grid-column: 1;
  color: var(--xr-font-color2);
  font-weight: 500;
}

.xr-section-summary > span {
  display: inline-block;
  padding-left: 0.5em;
}

.xr-section-summary-in:disabled + label {
  color: var(--xr-font-color2);
}

.xr-section-summary-in + label:before {
  display: inline-block;
  content: '►';
  font-size: 11px;
  width: 15px;
  text-align: center;
}

.xr-section-summary-in:disabled + label:before {
  color: var(--xr-disabled-color);
}

.xr-section-summary-in:checked + label:before {
  content: '▼';
}

.xr-section-summary-in:checked + label > span {
  display: none;
}

.xr-section-summary,
.xr-section-inline-details {
  padding-top: 4px;
  padding-bottom: 4px;
}

.xr-section-inline-details {
  grid-column: 2 / -1;
}

.xr-section-details {
  display: none;
  grid-column: 1 / -1;
  margin-bottom: 5px;
}

.xr-section-summary-in:checked ~ .xr-section-details {
  display: contents;
}

.xr-array-wrap {
  grid-column: 1 / -1;
  display: grid;
  grid-template-columns: 20px auto;
}

.xr-array-wrap > label {
  grid-column: 1;
  vertical-align: top;
}

.xr-preview {
  color: var(--xr-font-color3);
}

.xr-array-preview,
.xr-array-data {
  padding: 0 5px !important;
  grid-column: 2;
}

.xr-array-data,
.xr-array-in:checked ~ .xr-array-preview {
  display: none;
}

.xr-array-in:checked ~ .xr-array-data,
.xr-array-preview {
  display: inline-block;
}

.xr-dim-list {
  display: inline-block !important;
  list-style: none;
  padding: 0 !important;
  margin: 0;
}

.xr-dim-list li {
  display: inline-block;
  padding: 0;
  margin: 0;
}

.xr-dim-list:before {
  content: '(';
}

.xr-dim-list:after {
  content: ')';
}

.xr-dim-list li:not(:last-child):after {
  content: ',';
  padding-right: 5px;
}

.xr-has-index {
  font-weight: bold;
}

.xr-var-list,
.xr-var-item {
  display: contents;
}

.xr-var-item > div,
.xr-var-item label,
.xr-var-item > .xr-var-name span {
  background-color: var(--xr-background-color-row-even);
  margin-bottom: 0;
}

.xr-var-item > .xr-var-name:hover span {
  padding-right: 5px;
}

.xr-var-list > li:nth-child(odd) > div,
.xr-var-list > li:nth-child(odd) > label,
.xr-var-list > li:nth-child(odd) > .xr-var-name span {
  background-color: var(--xr-background-color-row-odd);
}

.xr-var-name {
  grid-column: 1;
}

.xr-var-dims {
  grid-column: 2;
}

.xr-var-dtype {
  grid-column: 3;
  text-align: right;
  color: var(--xr-font-color2);
}

.xr-var-preview {
  grid-column: 4;
}

.xr-var-name,
.xr-var-dims,
.xr-var-dtype,
.xr-preview,
.xr-attrs dt {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-right: 10px;
}

.xr-var-name:hover,
.xr-var-dims:hover,
.xr-var-dtype:hover,
.xr-attrs dt:hover {
  overflow: visible;
  width: auto;
  z-index: 1;
}

.xr-var-attrs,
.xr-var-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data {
  grid-column: 1 / -1;
}

dl.xr-attrs {
  padding: 0;
  margin: 0;
  display: grid;
  grid-template-columns: 125px auto;
}

.xr-attrs dt,
.xr-attrs dd {
  padding: 0;
  margin: 0;
  float: left;
  padding-right: 10px;
  width: auto;
}

.xr-attrs dt {
  font-weight: normal;
  grid-column: 1;
}

.xr-attrs dt:hover span {
  display: inline-block;
  background: var(--xr-background-color);
  padding-right: 10px;
}

.xr-attrs dd {
  grid-column: 2;
  white-space: pre-wrap;
  word-break: break-all;
}

.xr-icon-database,
.xr-icon-file-text2 {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:    (t_dim: 48, z_dim: 2, y_dim: 375, x_dim: 297)
Coordinates:
  * t_dim      (t_dim) datetime64[ns] 2010-01-01 2010-02-01 ... 2013-12-01
    depth_0    (z_dim, y_dim, x_dim) float32 0.5 0.5 0.5 0.5 ... 1.5 1.5 1.5 1.5
    longitude  (y_dim, x_dim) float32 -19.89 -19.78 -19.67 ... 12.78 12.89 13.0
    latitude   (y_dim, x_dim) float32 40.07 40.07 40.07 40.07 ... 65.0 65.0 65.0
Dimensions without coordinates: z_dim, y_dim, x_dim
Data variables:
    trend      (t_dim, z_dim, y_dim, x_dim) float64 nan nan nan ... nan nan nan
    seasonal   (t_dim, z_dim, y_dim, x_dim) float64 nan nan nan ... nan nan nan
    residual   (t_dim, z_dim, y_dim, x_dim) float64 nan nan nan ... nan nan nan</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-42e1726b-56fc-4b8e-be20-4bd1af0680b8' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-42e1726b-56fc-4b8e-be20-4bd1af0680b8' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span class='xr-has-index'>t_dim</span>: 48</li><li><span>z_dim</span>: 2</li><li><span>y_dim</span>: 375</li><li><span>x_dim</span>: 297</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-195ff127-68da-49b0-ae87-d6668c5d421f' class='xr-section-summary-in' type='checkbox'  checked><label for='section-195ff127-68da-49b0-ae87-d6668c5d421f' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span class='xr-has-index'>t_dim</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2010-01-01 ... 2013-12-01</div><input id='attrs-63c6d6a4-a8df-4694-a882-216d57622b40' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-63c6d6a4-a8df-4694-a882-216d57622b40' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-4ab6fa35-8d45-4284-99fa-51c6e1e53652' class='xr-var-data-in' type='checkbox'><label for='data-4ab6fa35-8d45-4284-99fa-51c6e1e53652' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2010-01-01T00:00:00.000000000&#x27;, &#x27;2010-02-01T00:00:00.000000000&#x27;,
       &#x27;2010-03-01T00:00:00.000000000&#x27;, &#x27;2010-04-01T00:00:00.000000000&#x27;,
       &#x27;2010-05-01T00:00:00.000000000&#x27;, &#x27;2010-06-01T00:00:00.000000000&#x27;,
       &#x27;2010-07-01T00:00:00.000000000&#x27;, &#x27;2010-08-01T00:00:00.000000000&#x27;,
       &#x27;2010-09-01T00:00:00.000000000&#x27;, &#x27;2010-10-01T00:00:00.000000000&#x27;,
       &#x27;2010-11-01T00:00:00.000000000&#x27;, &#x27;2010-12-01T00:00:00.000000000&#x27;,
       &#x27;2011-01-01T00:00:00.000000000&#x27;, &#x27;2011-02-01T00:00:00.000000000&#x27;,
       &#x27;2011-03-01T00:00:00.000000000&#x27;, &#x27;2011-04-01T00:00:00.000000000&#x27;,
       &#x27;2011-05-01T00:00:00.000000000&#x27;, &#x27;2011-06-01T00:00:00.000000000&#x27;,
       &#x27;2011-07-01T00:00:00.000000000&#x27;, &#x27;2011-08-01T00:00:00.000000000&#x27;,
       &#x27;2011-09-01T00:00:00.000000000&#x27;, &#x27;2011-10-01T00:00:00.000000000&#x27;,
       &#x27;2011-11-01T00:00:00.000000000&#x27;, &#x27;2011-12-01T00:00:00.000000000&#x27;,
       &#x27;2012-01-01T00:00:00.000000000&#x27;, &#x27;2012-02-01T00:00:00.000000000&#x27;,
       &#x27;2012-03-01T00:00:00.000000000&#x27;, &#x27;2012-04-01T00:00:00.000000000&#x27;,
       &#x27;2012-05-01T00:00:00.000000000&#x27;, &#x27;2012-06-01T00:00:00.000000000&#x27;,
       &#x27;2012-07-01T00:00:00.000000000&#x27;, &#x27;2012-08-01T00:00:00.000000000&#x27;,
       &#x27;2012-09-01T00:00:00.000000000&#x27;, &#x27;2012-10-01T00:00:00.000000000&#x27;,
       &#x27;2012-11-01T00:00:00.000000000&#x27;, &#x27;2012-12-01T00:00:00.000000000&#x27;,
       &#x27;2013-01-01T00:00:00.000000000&#x27;, &#x27;2013-02-01T00:00:00.000000000&#x27;,
       &#x27;2013-03-01T00:00:00.000000000&#x27;, &#x27;2013-04-01T00:00:00.000000000&#x27;,
       &#x27;2013-05-01T00:00:00.000000000&#x27;, &#x27;2013-06-01T00:00:00.000000000&#x27;,
       &#x27;2013-07-01T00:00:00.000000000&#x27;, &#x27;2013-08-01T00:00:00.000000000&#x27;,
       &#x27;2013-09-01T00:00:00.000000000&#x27;, &#x27;2013-10-01T00:00:00.000000000&#x27;,
       &#x27;2013-11-01T00:00:00.000000000&#x27;, &#x27;2013-12-01T00:00:00.000000000&#x27;],
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>depth_0</span></div><div class='xr-var-dims'>(z_dim, y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>0.5 0.5 0.5 0.5 ... 1.5 1.5 1.5 1.5</div><input id='attrs-6fabb1e6-5b57-43e1-aba7-dca92c9be95e' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-6fabb1e6-5b57-43e1-aba7-dca92c9be95e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-6bfe2712-4ecb-4cb5-b232-1c63897d9967' class='xr-var-data-in' type='checkbox'><label for='data-6bfe2712-4ecb-4cb5-b232-1c63897d9967' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>m</dd><dt><span>standard_name :</span></dt><dd>Depth at time zero on the t-grid</dd></dl></div><div class='xr-var-data'><pre>array([[[0.5       , 0.5       , 0.5       , ..., 0.5       ,
         0.5       , 0.5       ],
        [0.5       , 0.4975586 , 0.4975586 , ..., 0.10009766,
         0.10009766, 0.5       ],
        [0.5       , 0.4975586 , 0.4975586 , ..., 0.10009766,
         0.10009766, 0.5       ],
        ...,
        [0.5       , 0.10009766, 0.10009766, ..., 0.10009766,
         0.10009766, 0.5       ],
        [0.5       , 0.10009766, 0.10009766, ..., 0.10009766,
         0.10009766, 0.5       ],
        [0.5       , 0.5       , 0.5       , ..., 0.5       ,
         0.5       , 0.5       ]],

       [[1.5       , 1.5       , 1.5       , ..., 1.5       ,
         1.5       , 1.5       ],
        [1.5       , 1.5170898 , 1.5170898 , ..., 0.30029297,
         0.30029297, 1.5       ],
        [1.5       , 1.5170898 , 1.5170898 , ..., 0.30029297,
         0.30029297, 1.5       ],
        ...,
        [1.5       , 0.30029297, 0.30029297, ..., 0.30029297,
         0.30029297, 1.5       ],
        [1.5       , 0.30029297, 0.30029297, ..., 0.30029297,
         0.30029297, 1.5       ],
        [1.5       , 1.5       , 1.5       , ..., 1.5       ,
         1.5       , 1.5       ]]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>-19.89 -19.78 -19.67 ... 12.89 13.0</div><input id='attrs-ce625aa5-f5ac-4e2d-ad32-ebca40a9c01e' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-ce625aa5-f5ac-4e2d-ad32-ebca40a9c01e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-0fb8d520-c977-4e80-ae85-2e611728a593' class='xr-var-data-in' type='checkbox'><label for='data-0fb8d520-c977-4e80-ae85-2e611728a593' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
         13.      ],
       [-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
         13.      ],
       [-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
         13.      ],
       ...,
       [-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
         13.      ],
       [-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
         13.      ],
       [-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
         13.      ]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>40.07 40.07 40.07 ... 65.0 65.0</div><input id='attrs-ae4bec34-c251-43ee-bbfa-1bbf3742ae2c' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-ae4bec34-c251-43ee-bbfa-1bbf3742ae2c' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-8b595fee-8567-4b6c-bee9-df9ee6eaa27c' class='xr-var-data-in' type='checkbox'><label for='data-8b595fee-8567-4b6c-bee9-df9ee6eaa27c' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[40.066406, 40.066406, 40.066406, ..., 40.066406, 40.066406,
        40.066406],
       [40.13379 , 40.13379 , 40.13379 , ..., 40.13379 , 40.13379 ,
        40.13379 ],
       [40.200195, 40.200195, 40.200195, ..., 40.200195, 40.200195,
        40.200195],
       ...,
       [64.868164, 64.868164, 64.868164, ..., 64.868164, 64.868164,
        64.868164],
       [64.93457 , 64.93457 , 64.93457 , ..., 64.93457 , 64.93457 ,
        64.93457 ],
       [65.00098 , 65.00098 , 65.00098 , ..., 65.00098 , 65.00098 ,
        65.00098 ]], dtype=float32)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-3655abc3-dd2e-4152-9675-b21c27f75b5d' class='xr-section-summary-in' type='checkbox'  checked><label for='section-3655abc3-dd2e-4152-9675-b21c27f75b5d' class='xr-section-summary' >Data variables: <span>(3)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>trend</span></div><div class='xr-var-dims'>(t_dim, z_dim, y_dim, x_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-7d68115c-9791-43be-9ff7-39b429ada3ff' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-7d68115c-9791-43be-9ff7-39b429ada3ff' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-0d86bc67-b482-41f9-80b9-1486f8b42e5b' class='xr-var-data-in' type='checkbox'><label for='data-0d86bc67-b482-41f9-80b9-1486f8b42e5b' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[[[        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan, 15.35180752, 15.34855231, ...,         nan,
                  nan,         nan],
         [        nan, 15.34073981, 15.5085458 , ...,         nan,
                  nan,         nan],
         ...,
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan]],

        [[        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan, 15.35083095, 15.34773851, ...,         nan,
                  nan,         nan],
         [        nan, 15.33960049, 15.51245205, ...,         nan,
                  nan,         nan],
...
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan]],

        [[        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan, 17.74338891, 17.74029646, ...,         nan,
                  nan,         nan],
         [        nan, 17.73215844, 17.90501001, ...,         nan,
                  nan,         nan],
         ...,
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan]]]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>seasonal</span></div><div class='xr-var-dims'>(t_dim, z_dim, y_dim, x_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-e7c09f44-3a04-4f0c-9e8d-e0b6bbd134ca' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e7c09f44-3a04-4f0c-9e8d-e0b6bbd134ca' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-68bc32ce-9aa3-4314-9f05-e10864eeaca7' class='xr-var-data-in' type='checkbox'><label for='data-68bc32ce-9aa3-4314-9f05-e10864eeaca7' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[[[            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,  8.11652713e-02, -2.49358288e-03, ...,
                      nan,             nan,             nan],
         [            nan,  1.06881417e-01,  3.36536365e-01, ...,
                      nan,             nan,             nan],
         ...,
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan]],

        [[            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,  7.04230838e-02, -1.33985308e-02, ...,
                      nan,             nan,             nan],
         [            nan,  9.63019900e-02,  3.32630115e-01, ...,
                      nan,             nan,             nan],
...
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan]],

        [[            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan, -3.32605874e-01, -3.15841551e-01, ...,
                      nan,             nan,             nan],
         [            nan, -3.42859780e-01, -6.91492593e-01, ...,
                      nan,             nan,             nan],
         ...,
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan],
         [            nan,             nan,             nan, ...,
                      nan,             nan,             nan]]]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>residual</span></div><div class='xr-var-dims'>(t_dim, z_dim, y_dim, x_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-247f08f0-63ab-4b15-a08b-81cb72b46ec3' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-247f08f0-63ab-4b15-a08b-81cb72b46ec3' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-e35cc6c4-7a1d-4d0b-8605-af9e29e667c5' class='xr-var-data-in' type='checkbox'><label for='data-e35cc6c4-7a1d-4d0b-8605-af9e29e667c5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[[[        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan, -0.18733054, -0.18733054, ...,         nan,
                  nan,         nan],
         [        nan, -0.18733054, -0.18733054, ...,         nan,
                  nan,         nan],
         ...,
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan]],

        [[        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan, -0.18733054, -0.18733054, ...,         nan,
                  nan,         nan],
         [        nan, -0.18733054, -0.18733054, ...,         nan,
                  nan,         nan],
...
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan]],

        [[        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan, -0.08778896, -0.08778896, ...,         nan,
                  nan,         nan],
         [        nan, -0.08778896, -0.08778896, ...,         nan,
                  nan,         nan],
         ...,
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan],
         [        nan,         nan,         nan, ...,         nan,
                  nan,         nan]]]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-72641392-be48-49ad-a6ab-4740b95ff5b5' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-72641392-be48-49ad-a6ab-4740b95ff5b5' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



Plot the decomposed time series


```python
component = xr.DataArray( ["trend","seasonal","residual"], dims="component", name="component" )
temp_decomp = xr.concat( 
    [grd.dataset.trend, grd.dataset.seasonal,grd.dataset.residual], dim=component 
)
temp_decomp.name = "temperature"
temp_decomp[:,:,0,200,200].plot(hue="component")
```




    [<matplotlib.lines.Line2D at 0x7f542850ae50>,
     <matplotlib.lines.Line2D at 0x7f54285abbb0>,
     <matplotlib.lines.Line2D at 0x7f54284fcc10>]




    
![png](/COAsT/seasonal_decomp_example_files/seasonal_decomp_example_17_1.png)
    



```python

```
