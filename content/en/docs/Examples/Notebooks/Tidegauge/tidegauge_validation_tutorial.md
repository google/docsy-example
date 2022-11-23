---
    title: "Tidegauge validation tutorial"
    linkTitle: "Tidegauge validation tutorial"
    weight: 5

    description: >
        Tidegauge validation tutorial example.
---
This tutorial gives an overview of some of validation tools available when
using the Tidegauge objects in COAsT.

This includes:
- creating tidegauge objects
    - reading in tidegauge data
    - creating tidegauge object from gridded simulation data
- basic plotting
    - on maps and timeseries
- analysis
    - harmonic analysis and calculation of non-tidal residual
    - doodsonX0 tidal filtering
    - threshold statistics
    - error calculation: mean errors, mean absolute error (MAE), mean square error (MSE)
    

### Import necessary libraries



```python
import xarray as xr
import numpy as np
import coast
import datetime
import matplotlib.pyplot as plt
```

### Define paths



```python
fn_dom = "<PATH_TO_NEMO_DOMAIN>"
fn_dat = "<PATH_TO_NEMO_DATA>"
fn_config = "<PATH_TO_CONFIG.json>"
fn_tg = "<PATH_TO_TIDEGAUGE_NETCDF>"  # This should already be processed, on the same time dimension

# Change this to 0 to not use default files.
if 1:
    #print(f"Use default files")
    dir = "./example_files/"
    fn_dom = dir + "coast_example_nemo_domain.nc"
    fn_dat = dir + "coast_example_nemo_data.nc"
    fn_config = "./config/example_nemo_grid_t.json"
    fn_tidegauge = dir + "tide_gauges/lowestoft-p024-uk-bodc"
    fn_tg = dir + "tide_gauges/coast_example_tidegauges.nc"  # These are a collection (xr.DataSet) of tidegauge observations. Created for this demonstration, they are synthetic.
```

### Reading data

We can create our empty tidegauge object:


```python
tidegauge = coast.Tidegauge()
```

    Tidegauge object at 0x55faea1b3fc0 initialised


The `Tidegauge` class contains multiple methods for reading different typical
tidegauge formats. This includes reading from the GESLA and BODC databases.
To read a gesla file between two dates, we can use:


```python
date0 = datetime.datetime(2007,1,10)
date1 = datetime.datetime(2007,1,12)
tidegauge.read_gesla_v3(fn_tidegauge, date_start = date0, date_end = date1)
```

A Tidegauge object is a type of Timeseries object, so it has the form:


```python
tidegauge.dataset
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
body[data-theme=dark],
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

.xr-index-preview {
  grid-column: 2 / 5;
  color: var(--xr-font-color2);
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
.xr-var-data,
.xr-index-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data,
.xr-index-data-in:checked ~ .xr-index-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-index-name div,
.xr-index-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data,
.xr-index-data {
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
.xr-icon-file-text2,
.xr-no-icon {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:    (id_dim: 1, t_dim: 193)
Coordinates:
    time       (t_dim) datetime64[ns] 2007-01-10 ... 2007-01-12
    longitude  (id_dim) float64 1.751
    latitude   (id_dim) float64 52.47
    id_name    (id_dim) &lt;U9 &#x27;Lowestoft&#x27;
Dimensions without coordinates: id_dim, t_dim
Data variables:
    ssh        (id_dim, t_dim) float64 2.818 2.823 2.871 ... 3.214 3.257 3.371
    qc_flags   (id_dim, t_dim) int64 1 1 1 1 1 1 1 1 1 1 ... 1 1 1 1 1 1 1 1 1 1</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-ec4ec7c6-0984-44aa-9a72-1e4c3bb4ff17' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-ec4ec7c6-0984-44aa-9a72-1e4c3bb4ff17' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>id_dim</span>: 1</li><li><span>t_dim</span>: 193</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-ffe74613-2817-478c-a957-c38229429d89' class='xr-section-summary-in' type='checkbox'  checked><label for='section-ffe74613-2817-478c-a957-c38229429d89' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-10 ... 2007-01-12</div><input id='attrs-5a07c090-16e7-4db3-ad6f-ca86a60221c3' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-5a07c090-16e7-4db3-ad6f-ca86a60221c3' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-366a1acd-873a-4a68-91de-143edffef3a2' class='xr-var-data-in' type='checkbox'><label for='data-366a1acd-873a-4a68-91de-143edffef3a2' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-10T00:00:00.000000000&#x27;, &#x27;2007-01-10T00:15:00.000000000&#x27;,
       &#x27;2007-01-10T00:30:00.000000000&#x27;, &#x27;2007-01-10T00:45:00.000000000&#x27;,
       &#x27;2007-01-10T01:00:00.000000000&#x27;, &#x27;2007-01-10T01:15:00.000000000&#x27;,
       &#x27;2007-01-10T01:30:00.000000000&#x27;, &#x27;2007-01-10T01:45:00.000000000&#x27;,
       &#x27;2007-01-10T02:00:00.000000000&#x27;, &#x27;2007-01-10T02:15:00.000000000&#x27;,
       &#x27;2007-01-10T02:30:00.000000000&#x27;, &#x27;2007-01-10T02:45:00.000000000&#x27;,
       &#x27;2007-01-10T03:00:00.000000000&#x27;, &#x27;2007-01-10T03:15:00.000000000&#x27;,
       &#x27;2007-01-10T03:30:00.000000000&#x27;, &#x27;2007-01-10T03:45:00.000000000&#x27;,
       &#x27;2007-01-10T04:00:00.000000000&#x27;, &#x27;2007-01-10T04:15:00.000000000&#x27;,
       &#x27;2007-01-10T04:30:00.000000000&#x27;, &#x27;2007-01-10T04:45:00.000000000&#x27;,
       &#x27;2007-01-10T05:00:00.000000000&#x27;, &#x27;2007-01-10T05:15:00.000000000&#x27;,
       &#x27;2007-01-10T05:30:00.000000000&#x27;, &#x27;2007-01-10T05:45:00.000000000&#x27;,
       &#x27;2007-01-10T06:00:00.000000000&#x27;, &#x27;2007-01-10T06:15:00.000000000&#x27;,
       &#x27;2007-01-10T06:30:00.000000000&#x27;, &#x27;2007-01-10T06:45:00.000000000&#x27;,
       &#x27;2007-01-10T07:00:00.000000000&#x27;, &#x27;2007-01-10T07:15:00.000000000&#x27;,
       &#x27;2007-01-10T07:30:00.000000000&#x27;, &#x27;2007-01-10T07:45:00.000000000&#x27;,
       &#x27;2007-01-10T08:00:00.000000000&#x27;, &#x27;2007-01-10T08:15:00.000000000&#x27;,
       &#x27;2007-01-10T08:30:00.000000000&#x27;, &#x27;2007-01-10T08:45:00.000000000&#x27;,
       &#x27;2007-01-10T09:00:00.000000000&#x27;, &#x27;2007-01-10T09:15:00.000000000&#x27;,
       &#x27;2007-01-10T09:30:00.000000000&#x27;, &#x27;2007-01-10T09:45:00.000000000&#x27;,
...
       &#x27;2007-01-11T14:30:00.000000000&#x27;, &#x27;2007-01-11T14:45:00.000000000&#x27;,
       &#x27;2007-01-11T15:00:00.000000000&#x27;, &#x27;2007-01-11T15:15:00.000000000&#x27;,
       &#x27;2007-01-11T15:30:00.000000000&#x27;, &#x27;2007-01-11T15:45:00.000000000&#x27;,
       &#x27;2007-01-11T16:00:00.000000000&#x27;, &#x27;2007-01-11T16:15:00.000000000&#x27;,
       &#x27;2007-01-11T16:30:00.000000000&#x27;, &#x27;2007-01-11T16:45:00.000000000&#x27;,
       &#x27;2007-01-11T17:00:00.000000000&#x27;, &#x27;2007-01-11T17:15:00.000000000&#x27;,
       &#x27;2007-01-11T17:30:00.000000000&#x27;, &#x27;2007-01-11T17:45:00.000000000&#x27;,
       &#x27;2007-01-11T18:00:00.000000000&#x27;, &#x27;2007-01-11T18:15:00.000000000&#x27;,
       &#x27;2007-01-11T18:30:00.000000000&#x27;, &#x27;2007-01-11T18:45:00.000000000&#x27;,
       &#x27;2007-01-11T19:00:00.000000000&#x27;, &#x27;2007-01-11T19:15:00.000000000&#x27;,
       &#x27;2007-01-11T19:30:00.000000000&#x27;, &#x27;2007-01-11T19:45:00.000000000&#x27;,
       &#x27;2007-01-11T20:00:00.000000000&#x27;, &#x27;2007-01-11T20:15:00.000000000&#x27;,
       &#x27;2007-01-11T20:30:00.000000000&#x27;, &#x27;2007-01-11T20:45:00.000000000&#x27;,
       &#x27;2007-01-11T21:00:00.000000000&#x27;, &#x27;2007-01-11T21:15:00.000000000&#x27;,
       &#x27;2007-01-11T21:30:00.000000000&#x27;, &#x27;2007-01-11T21:45:00.000000000&#x27;,
       &#x27;2007-01-11T22:00:00.000000000&#x27;, &#x27;2007-01-11T22:15:00.000000000&#x27;,
       &#x27;2007-01-11T22:30:00.000000000&#x27;, &#x27;2007-01-11T22:45:00.000000000&#x27;,
       &#x27;2007-01-11T23:00:00.000000000&#x27;, &#x27;2007-01-11T23:15:00.000000000&#x27;,
       &#x27;2007-01-11T23:30:00.000000000&#x27;, &#x27;2007-01-11T23:45:00.000000000&#x27;,
       &#x27;2007-01-12T00:00:00.000000000&#x27;], dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.751</div><input id='attrs-951dd6cb-527b-497d-a354-3aed22dc9a9e' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-951dd6cb-527b-497d-a354-3aed22dc9a9e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-08ebc636-b467-402a-be9d-fe4d8503e9a1' class='xr-var-data-in' type='checkbox'><label for='data-08ebc636-b467-402a-be9d-fe4d8503e9a1' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([1.75083])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>52.47</div><input id='attrs-fa4aed50-894b-4ae6-aca4-858fcb3b682e' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-fa4aed50-894b-4ae6-aca4-858fcb3b682e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-48ce4fa3-1f64-4b93-b8d5-ff38acbffb2c' class='xr-var-data-in' type='checkbox'><label for='data-48ce4fa3-1f64-4b93-b8d5-ff38acbffb2c' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([52.473])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>id_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>&lt;U9</div><div class='xr-var-preview xr-preview'>&#x27;Lowestoft&#x27;</div><input id='attrs-e10f58cc-f103-48f2-89b9-799baddbc214' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e10f58cc-f103-48f2-89b9-799baddbc214' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-8c6722d2-fbc9-4943-a6b6-e2465e3a56e5' class='xr-var-data-in' type='checkbox'><label for='data-8c6722d2-fbc9-4943-a6b6-e2465e3a56e5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Lowestoft&#x27;], dtype=&#x27;&lt;U9&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-a6db8e6b-9b46-4a16-ad2c-4c271e8eb7be' class='xr-section-summary-in' type='checkbox'  checked><label for='section-a6db8e6b-9b46-4a16-ad2c-4c271e8eb7be' class='xr-section-summary' >Data variables: <span>(2)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>ssh</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>2.818 2.823 2.871 ... 3.257 3.371</div><input id='attrs-0db530c4-e856-4e8a-a89e-b74d34675293' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-0db530c4-e856-4e8a-a89e-b74d34675293' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-aeb13b99-9b6c-4dce-a127-77fa10e0fe10' class='xr-var-data-in' type='checkbox'><label for='data-aeb13b99-9b6c-4dce-a127-77fa10e0fe10' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[ 2.818,  2.823,  2.871,  2.931,  2.961,  2.979,  2.953,  2.913,
         2.864,  2.806,  2.723,  2.664,  2.606,  2.511,  2.43 ,  2.379,
         2.296,  2.201,  2.105,  2.006,  1.908,  1.801,  1.684,  1.579,
         1.494,  1.402,  1.306,  1.233,  1.171,  1.102,  1.054,  1.028,
         0.989,  0.97 ,  0.983,  1.004,  1.026,  1.068,  1.153,  1.225,
         1.296,  1.362,  1.436,  1.481,  1.536,  1.615,  1.695,  1.726,
         1.802,  1.842,  1.86 ,  1.872,  1.897,  1.912,  1.946,  1.994,
         2.006,  2.028,  2.067,  2.081,  2.098,  2.137,  2.113,  2.068,
         2.053,  1.985,  1.917,  1.869,  1.803,  1.695,  1.642,  1.545,
         1.463,  1.463,  1.466,  1.462,  1.476,  1.524,  1.574,  1.633,
         1.661,  1.717,  1.818,  1.918,  2.018,  2.093,  2.14 ,  2.223,
         2.278,  2.303,  2.372,  2.375,  2.395,  2.468,  2.481,  2.487,
         2.535,  2.543,  2.578,  2.621,  2.627,  2.626,  2.585,  2.563,
         2.529,  2.451,  2.335,  2.207,  2.086,  1.982,  1.855,  1.741,
         1.618,  1.531,  1.429,  1.342,  1.246,  1.141,  1.031,  0.902,
         0.784,  0.673,  0.571,  0.457,  0.323,  0.203,  0.13 ,  0.056,
        -0.028, -0.077, -0.093, -0.143, -0.181, -0.211, -0.217, -0.182,
        -0.1  , -0.046,  0.02 ,  0.121,  0.247,  0.358,  0.468,  0.65 ,
         0.845,  0.987,  1.059,  1.199,  1.322,  1.38 ,  1.465,  1.519,
         1.559,  1.691,  1.775,  1.844,  2.019,  2.113,  2.159,  2.266,
         2.311,  2.406,  2.512,  2.533,  2.43 ,  2.309,  2.185,  2.136,
         2.086,  2.066,  2.114,  2.114,  2.051,  2.033,  2.055,  2.1  ,
         2.192,  2.278,  2.334,  2.421,  2.497,  2.548,  2.603,  2.679,
         2.803,  2.859,  2.875,  3.001,  3.075,  3.135,  3.214,  3.257,
         3.371]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>qc_flags</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>int64</div><div class='xr-var-preview xr-preview'>1 1 1 1 1 1 1 1 ... 1 1 1 1 1 1 1 1</div><input id='attrs-018e0bff-ad43-410a-829a-39a4d0086077' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-018e0bff-ad43-410a-829a-39a4d0086077' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-85c0d7f7-4bcd-4ada-acff-f599b38ad589' class='xr-var-data-in' type='checkbox'><label for='data-85c0d7f7-4bcd-4ada-acff-f599b38ad589' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-6c332ea4-eeb8-47d0-8faa-6be88cef2a80' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-6c332ea4-eeb8-47d0-8faa-6be88cef2a80' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-81e32af2-8254-41f7-ba35-ea1d70d19fbd' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-81e32af2-8254-41f7-ba35-ea1d70d19fbd' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



An example data variable could be ssh, or ntr (non-tidal residual). This object can also be used for other instrument types, not just tide gauges. For example moorings.

Every id index for this object should use the same time coordinates. Therefore, timeseries need to be aligned before being placed into the object. If there is any padding needed, then NaNs should be used. NaNs should also be used for quality control/data rejection.


For the rest of our examples, we will use data from multiple tide gauges
on the same time dimension. It will be read in from a simple netCDF file:


```python
tt = xr.open_dataset(fn_tg)
obs = coast.Tidegauge(dataset=tt)
```

    Tidegauge object at 0x55faea1b3fc0 initialised



```python
# Create the object and then inset the netcdf dataset
tt = xr.open_dataset(fn_tg)
obs = coast.Tidegauge(dataset=tt)
obs.dataset = obs.dataset.set_coords("time")
```

    Tidegauge object at 0x55faea1b3fc0 initialised


## Quick plotting to visualise Tidegauge data

Tidegauge has ready made quick plotting routines for viewing time series and tide gauge location. To look at the tide gauge location:


```python
fig, ax = obs.plot_on_map()
```

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/cartopy/io/__init__.py:241: DownloadWarning: Downloading: https://naturalearth.s3.amazonaws.com/50m_physical/ne_50m_coastline.zip
      warnings.warn(f'Downloading: {url}', DownloadWarning)



    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_16_1.png)
    


There is also a slightly expanded version where you can plot multiple tidegauge objects, included as a list, and also the colour (if it is a dataarray with one value per location).


```python
# plot a list tidegauge datasets (here repeating obs for the point of demonstration) and colour
fig, ax = obs.plot_on_map_multiple([obs,obs], color_var_str="latitude")
```


    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_18_0.png)
    


Time series can be plotted using `matplotlib.pyplot` methods. However `xarray` has its own plotting wrappers that can be used, which offers some conveniences with labelling


```python
stn_id=26  # pick a gauge station

plt.subplot(2,1,1)
obs.dataset.ssh[stn_id].plot()  # rename time dimension to enable automatic x-axis labelling

plt.subplot(2,1,2)
obs.dataset.ssh[stn_id].swap_dims({'t_dim':'time'}).plot()  # rename time dimension to enable automatic x-axis labelling
plt.tight_layout()
plt.show()
```


    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_20_0.png)
    


Or you can use the `Tidegauge.plot_timeseries()` method, in which start and end dates can also be specified.


```python
obs.isel(id_dim=stn_id).plot_timeseries(date_start=np.datetime64('2007-01-01'),
                                        date_end = np.datetime64('2007-01-31') )
```




    (<Figure size 1000x1000 with 1 Axes>,
     <matplotlib.collections.PathCollection at 0x7fa3ffb3bb50>)




    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_22_1.png)
    


## Basic manipulation: subsetting + plotting



We can do some simple spatial and temporal manipulations of this data:



```python
# Cut out a time window
obs_cut = obs.time_slice( date0 = datetime.datetime(2007, 1, 1), date1 = datetime.datetime(2007,1,31))

# Cut out geographical boxes
obs_upper = obs_cut.subset_indices_lonlat_box(lonbounds = [0, 3],
                                            latbounds = [50, 55])
obs_lower = obs_cut.subset_indices_lonlat_box(lonbounds = [-9, -3],
                                            latbounds = [55.5, 59])

#fig, ax = obs_cut.plot_on_map()
fig, ax = obs_upper.plot_on_map_multiple([obs_upper, obs_lower], color_var_str="latitude")
```

    Tidegauge object at 0x55faea1b3fc0 initialised
    Tidegauge object at 0x55faea1b3fc0 initialised
    Tidegauge object at 0x55faea1b3fc0 initialised



    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_24_1.png)
    


### Gridded model comparison

To compare our observations to the model, we will interpolate a model variable to the same time and geographical space as the tidegauge. This is done using the `obs_operator()` method.

But first load some gridded data and manipulate some variable names for convenience


```python
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config=fn_config)
# Rename depth_0 to be depth
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
#nemo.dataset = nemo.dataset[["ssh", "landmask"]]
```

interpolate model onto obs locations
```
tidegauge_from_model = obs.obs_operator(nemo, time_interp='nearest')
```

Doing this would create a new interpolated tidegauge called `tidegauge_from_model`
Take a look at `tidegauge_from_model.dataset` to see for yourself. If a `landmask`
variable is present in the `Gridded` dataset then the nearest wet points will
be taken. Otherwise, just the nearest point is taken. If `landmask` is required
but not present you will need to insert it into the dataset yourself. For nemo
data, you could use the `bottom_level` or `mbathy` variables to do this. E.g:



```python
# Create a landmask array and put it into the nemo object.
# Here, using the bottom_level == 0 variable from the domain file is enough.
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0

# Then do the interpolation
tidegauge_from_model = obs.obs_operator(nemo, time_interp='nearest')
```

    Calculating spatial indices.
    Calculating time indices.
     Indexing model data at tide gauge locations.. 
    Calculating interpolation distances.
    Interpolating in time...
    Tidegauge object at 0x55faea1b3fc0 initialised


However, the new `tidegauge_from_model` will the same number of time entries as the `obs` data, rather than the model data (so this will include lots of empty values). So, for a more useful demonstration we trim the observed gauge data so it better matches the model data.


```python
# Cut down data to be only in 2007 to match model data.
start_date = datetime.datetime(2007, 1, 1)
end_date = datetime.datetime(2007, 1, 31)
obs = obs.time_slice(start_date, end_date)
```

    Tidegauge object at 0x55faea1b3fc0 initialised


### Interpolate model data onto obs locations


```python
model_timeseries = obs.obs_operator(nemo)

# Take a look
model_timeseries.dataset
```

    Calculating spatial indices.
    Calculating time indices.
     Indexing model data at tide gauge locations.. 
    Calculating interpolation distances.
    Interpolating in time...
    Tidegauge object at 0x55faea1b3fc0 initialised





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
body[data-theme=dark],
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

.xr-index-preview {
  grid-column: 2 / 5;
  color: var(--xr-font-color2);
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
.xr-var-data,
.xr-index-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data,
.xr-index-data-in:checked ~ .xr-index-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-index-name div,
.xr-index-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data,
.xr-index-data {
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
.xr-icon-file-text2,
.xr-no-icon {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:        (z_dim: 51, axis_nbounds: 2, t_dim: 720, id_dim: 61)
Coordinates:
    longitude      (id_dim) float32 1.444 -4.0 -5.333 ... 7.666 -9.111 8.777
    latitude       (id_dim) float32 51.93 51.53 58.0 51.67 ... 58.0 51.53 53.87
    depth          (z_dim, id_dim) float32 0.1001 0.2183 0.2529 ... 27.32 10.11
  * time           (t_dim) datetime64[ns] 2007-01-01 ... 2007-01-30T23:00:00
Dimensions without coordinates: z_dim, axis_nbounds, t_dim, id_dim
Data variables:
    deptht_bounds  (z_dim, axis_nbounds) float32 0.0 6.157 ... 5.924e+03
    ssh            (t_dim, id_dim) float32 nan nan nan ... 0.3721 -0.0752 0.7412
    temperature    (t_dim, z_dim, id_dim) float32 nan nan nan ... nan nan nan
    bathymetry     (id_dim) float32 10.0 21.81 6.075 15.56 ... 17.8 14.06 10.0
    e1             (id_dim) float32 7.618e+03 7.686e+03 ... 7.686e+03 7.285e+03
    e2             (id_dim) float32 7.414e+03 7.414e+03 ... 7.414e+03 7.414e+03
    e3_0           (z_dim, id_dim) float32 0.2002 0.4365 0.5059 ... 0.541 0.2002
    bottom_level   (id_dim) float32 50.0 50.0 12.0 32.0 ... 44.0 17.0 26.0 50.0
    landmask       (id_dim) bool False False False False ... False False False
    interp_dist    (id_dim) float64 10.56 4.33 15.65 6.018 ... 5.835 4.96 3.957
Attributes:
    name:         AMM7_1d_20070101_20070131_25hourm_grid_T
    description:  ocean T grid variables, 25h meaned
    title:        ocean T grid variables, 25h meaned
    Conventions:  CF-1.6
    timeStamp:    2019-Dec-26 04:35:28 GMT
    uuid:         96cae459-d3a1-4f4f-b82b-9259179f95f7
    history:      Tue May 19 12:07:51 2020: ncks -v votemper,sossheig -d time...
    NCO:          4.4.7</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-2c6b1860-d882-4f5c-a292-aad8b88d59c5' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-2c6b1860-d882-4f5c-a292-aad8b88d59c5' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>z_dim</span>: 51</li><li><span>axis_nbounds</span>: 2</li><li><span class='xr-has-index'>t_dim</span>: 720</li><li><span>id_dim</span>: 61</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-e0251dc7-f185-4726-92fc-17a6076c2dd1' class='xr-section-summary-in' type='checkbox'  checked><label for='section-e0251dc7-f185-4726-92fc-17a6076c2dd1' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>1.444 -4.0 -5.333 ... -9.111 8.777</div><input id='attrs-da59b583-a87e-4865-a2e4-28cfa7742e23' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-da59b583-a87e-4865-a2e4-28cfa7742e23' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-dd97b8ad-9479-496e-a1e3-f9715e21b9ea' class='xr-var-data-in' type='checkbox'><label for='data-dd97b8ad-9479-496e-a1e3-f9715e21b9ea' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 1.4443359 , -4.        , -5.333008  , -5.111328  , -3.        ,
       -3.1113281 , -5.2226562 , -3.        , -1.4443359 ,  1.4443359 ,
       -4.666992  ,  1.3330078 , -6.2226562 , -2.555664  , -3.7783203 ,
       -4.333008  ,  1.1113281 , -0.55566406, -5.555664  , -5.111328  ,
       -1.4443359 , -2.        , -1.1113281 , -2.8886719 , -1.8886719 ,
       -6.333008  , -3.1113281 , -6.2226562 , -0.        ,  0.11132812,
       -4.        ,  1.3330078 , -2.7783203 , -2.1113281 , -1.4443359 ,
       -3.555664  , -1.4443359 , -2.7783203 , -3.2226562 ,  1.7773438 ,
       -5.        , -5.555664  , -3.1113281 , -1.1113281 , -6.333008  ,
       -5.        , -4.7783203 , -6.666992  , -2.7783203 , -1.4443359 ,
       -4.111328  , -4.111328  , -1.4443359 , 11.22168   , 11.777344  ,
        4.888672  , 11.22168   , -7.333008  ,  7.6660156 , -9.111328  ,
        8.777344  ], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>51.93 51.53 58.0 ... 51.53 53.87</div><input id='attrs-b3fdd618-f863-4f64-a9d7-6536178023bb' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-b3fdd618-f863-4f64-a9d7-6536178023bb' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-cd7855d5-e9b0-45a4-82a9-6bb9e92467f5' class='xr-var-data-in' type='checkbox'><label for='data-cd7855d5-e9b0-45a4-82a9-6bb9e92467f5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([51.933594, 51.53418 , 58.000977, 51.666992, 54.000977, 51.26758 ,
       58.467773, 58.467773, 55.067383, 51.933594, 53.333984, 52.933594,
       56.66797 , 50.600586, 53.333984, 50.333984, 51.53418 , 54.467773,
       50.067383, 54.80078 , 55.067383, 57.13379 , 60.20117 , 51.53418 ,
       50.666992, 49.933594, 53.467773, 55.600586, 53.600586, 50.7334  ,
       57.600586, 51.067383, 51.53418 , 49.13379 , 55.067383, 54.666992,
       55.067383, 51.53418 , 56.000977, 52.467773, 52.067383, 54.666992,
       51.26758 , 50.7334  , 58.13379 , 55.734375, 54.067383, 55.26758 ,
       51.53418 , 55.067383, 52.734375, 51.26758 , 55.067383, 58.333984,
       57.66797 , 61.93457 , 64.868164, 55.40039 , 58.000977, 51.53418 ,
       53.867188], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>depth</span></div><div class='xr-var-dims'>(z_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>0.1001 0.2183 ... 27.32 10.11</div><input id='attrs-593f07f2-6310-4a7c-b279-bddc5e886831' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-593f07f2-6310-4a7c-b279-bddc5e886831' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-86b0cac4-4ed7-4d49-8b61-e7802e5519be' class='xr-var-data-in' type='checkbox'><label for='data-86b0cac4-4ed7-4d49-8b61-e7802e5519be' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>m</dd><dt><span>standard_name :</span></dt><dd>Depth at time zero on the t-grid</dd></dl></div><div class='xr-var-data'><pre>array([[1.00097656e-01, 2.18261719e-01, 2.52929688e-01, ...,
        5.02441406e-01, 2.70507812e-01, 1.00097656e-01],
       [3.00292969e-01, 6.54785156e-01, 7.58789062e-01, ...,
        1.49365234e+00, 8.11523438e-01, 3.00292969e-01],
       [5.00488281e-01, 1.09130859e+00, 1.26464844e+00, ...,
        2.46826172e+00, 1.35253906e+00, 5.00488281e-01],
       ...,
       [9.70947266e+00, 2.11713867e+01, 2.45341797e+01, ...,
        1.70940918e+02, 2.62392578e+01, 9.70947266e+00],
       [9.90966797e+00, 2.16079102e+01, 2.50400391e+01, ...,
        1.75505371e+02, 2.67802734e+01, 9.90966797e+00],
       [1.01098633e+01, 2.20444336e+01, 2.55458984e+01, ...,
        1.79002441e+02, 2.73212891e+01, 1.01098633e+01]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span class='xr-has-index'>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-01 ... 2007-01-30T23:00:00</div><input id='attrs-e9a67925-66da-44db-91a7-cb218dc66c1d' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-e9a67925-66da-44db-91a7-cb218dc66c1d' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-0df4f013-0ed3-4fdb-b044-06bfb5f67729' class='xr-var-data-in' type='checkbox'><label for='data-0df4f013-0ed3-4fdb-b044-06bfb5f67729' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>axis :</span></dt><dd>T</dd><dt><span>standard_name :</span></dt><dd>time</dd><dt><span>long_name :</span></dt><dd>Time axis</dd><dt><span>time_origin :</span></dt><dd>1900-01-01 00:00:00</dd><dt><span>bounds :</span></dt><dd>time_counter_bounds</dd></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-01T00:00:00.000000000&#x27;, &#x27;2007-01-01T01:00:00.000000000&#x27;,
       &#x27;2007-01-01T02:00:00.000000000&#x27;, ..., &#x27;2007-01-30T21:00:00.000000000&#x27;,
       &#x27;2007-01-30T22:00:00.000000000&#x27;, &#x27;2007-01-30T23:00:00.000000000&#x27;],
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-5b951bfb-75b4-4be4-a427-4ba20c4da7f5' class='xr-section-summary-in' type='checkbox'  checked><label for='section-5b951bfb-75b4-4be4-a427-4ba20c4da7f5' class='xr-section-summary' >Data variables: <span>(10)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>deptht_bounds</span></div><div class='xr-var-dims'>(z_dim, axis_nbounds)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>0.0 6.157 ... 5.72e+03 5.924e+03</div><input id='attrs-3f7e78f0-5869-44a0-b5fc-6482a35a87f8' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-3f7e78f0-5869-44a0-b5fc-6482a35a87f8' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-40db4e73-8137-41fe-8cff-e0e2c606060e' class='xr-var-data-in' type='checkbox'><label for='data-40db4e73-8137-41fe-8cff-e0e2c606060e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[   0.       ,    6.1572266],
       [   6.1572266,   12.678711 ],
       [  12.678711 ,   19.65332  ],
       [  19.65332  ,   27.19043  ],
       [  27.19043  ,   35.426758 ],
       [  35.426758 ,   44.527344 ],
       [  44.527344 ,   54.69922  ],
       [  54.69922  ,   66.19141  ],
       [  66.19141  ,   79.305664 ],
       [  79.305664 ,   94.41016  ],
       [  94.41016  ,  111.94238  ],
       [ 111.94238  ,  132.41895  ],
       [ 132.41895  ,  156.44531  ],
       [ 156.44531  ,  184.71582  ],
       [ 184.71582  ,  218.01562  ],
       [ 218.01562  ,  257.20605  ],
       [ 257.20605  ,  303.20508  ],
       [ 303.20508  ,  356.95898  ],
       [ 356.95898  ,  419.39258  ],
       [ 419.39258  ,  491.35645  ],
...
       [1955.7686   , 2136.3613   ],
       [2136.3613   , 2321.292    ],
       [2321.292    , 2509.8564   ],
       [2509.8564   , 2701.4355   ],
       [2701.4355   , 2895.504    ],
       [2895.504    , 3091.6123   ],
       [3091.6123   , 3289.3867   ],
       [3289.3867   , 3488.5156   ],
       [3488.5156   , 3688.7441   ],
       [3688.7441   , 3889.8613   ],
       [3889.8613   , 4091.6963   ],
       [4091.6963   , 4294.1094   ],
       [4294.1094   , 4496.9893   ],
       [4496.9893   , 4700.242    ],
       [4700.242    , 4903.797    ],
       [4903.797    , 5107.5938   ],
       [5107.5938   , 5311.584    ],
       [5311.584    , 5515.7295   ],
       [5515.7295   , 5720.       ],
       [5720.       , 5924.2705   ]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>ssh</span></div><div class='xr-var-dims'>(t_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>nan nan nan ... -0.0752 0.7412</div><input id='attrs-76532b67-2dd7-4094-9e4a-bd1eb65a8fe7' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-76532b67-2dd7-4094-9e4a-bd1eb65a8fe7' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-a0c2a069-9c58-4f6b-9820-17c049af75fe' class='xr-var-data-in' type='checkbox'><label for='data-a0c2a069-9c58-4f6b-9820-17c049af75fe' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>m</dd><dt><span>online_operation :</span></dt><dd>instant</dd><dt><span>interval_operation :</span></dt><dd>300 s</dd><dt><span>interval_write :</span></dt><dd>1 d</dd><dt><span>cell_methods :</span></dt><dd>time: point (interval: 300 s)</dd></dl></div><div class='xr-var-data'><pre>array([[        nan,         nan,         nan, ...,         nan,
                nan,         nan],
       [        nan,         nan,         nan, ...,         nan,
                nan,         nan],
       [        nan,         nan,         nan, ...,         nan,
                nan,         nan],
       ...,
       [ 0.24902344, -0.046875  ,  0.20019531, ...,  0.3720703 ,
        -0.07519531,  0.74121094],
       [ 0.24902344, -0.046875  ,  0.20019531, ...,  0.3720703 ,
        -0.07519531,  0.74121094],
       [ 0.24902344, -0.046875  ,  0.20019531, ...,  0.3720703 ,
        -0.07519531,  0.74121094]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>temperature</span></div><div class='xr-var-dims'>(t_dim, z_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-34ea0ce5-bda9-4048-b72b-e76f51be671e' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-34ea0ce5-bda9-4048-b72b-e76f51be671e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-f01e44d0-2ae9-495c-9e8f-55d6f9880f2e' class='xr-var-data-in' type='checkbox'><label for='data-f01e44d0-2ae9-495c-9e8f-55d6f9880f2e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>degC</dd><dt><span>online_operation :</span></dt><dd>instant</dd><dt><span>interval_operation :</span></dt><dd>300 s</dd><dt><span>interval_write :</span></dt><dd>1 d</dd><dt><span>cell_methods :</span></dt><dd>time: point (interval: 300 s)</dd></dl></div><div class='xr-var-data'><pre>array([[[      nan,       nan,       nan, ...,       nan,       nan,
               nan],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan],
        ...,
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan]],

       [[      nan,       nan,       nan, ...,       nan,       nan,
               nan],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan],
...
        [7.4384766, 8.22168  ,       nan, ...,       nan,       nan,
         5.0009766],
        [7.439453 , 8.22168  ,       nan, ...,       nan,       nan,
         5.0009766],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan]],

       [[7.4335938, 8.217773 , 7.245117 , ..., 5.8652344, 8.924805 ,
         5.0322266],
        [7.4345703, 8.219727 , 7.245117 , ..., 5.8671875, 8.926758 ,
         5.0322266],
        [7.4345703, 8.219727 , 7.2421875, ..., 5.8691406, 8.926758 ,
         5.0322266],
        ...,
        [7.4384766, 8.22168  ,       nan, ...,       nan,       nan,
         5.0009766],
        [7.439453 , 8.22168  ,       nan, ...,       nan,       nan,
         5.0009766],
        [      nan,       nan,       nan, ...,       nan,       nan,
               nan]]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>bathymetry</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>10.0 21.81 6.075 ... 14.06 10.0</div><input id='attrs-70cec62c-b0ac-4a8f-aaa5-4330f1446e26' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-70cec62c-b0ac-4a8f-aaa5-4330f1446e26' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-3704c051-a9db-4836-9112-9298f023666a' class='xr-var-data-in' type='checkbox'><label for='data-3704c051-a9db-4836-9112-9298f023666a' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>m</dd><dt><span>standard_name :</span></dt><dd>bathymetry</dd><dt><span>description :</span></dt><dd>depth of last wet w-level on the horizontal t-grid</dd></dl></div><div class='xr-var-data'><pre>array([10.       , 21.80957  ,  6.0751953, 15.558594 , 10.65625  ,
       12.145508 , 53.125    , 47.216797 , 10.3125   , 10.       ,
       21.898438 , 10.095703 , 11.674805 , 15.611328 , 11.230469 ,
       20.368164 , 10.25293  , 14.34082  , 23.28418  , 37.7666   ,
       10.3125   , 34.78711  , 15.394531 , 10.       , 12.630859 ,
       21.493164 , 10.       , 18.167969 , 10.       , 17.354492 ,
       10.       , 24.625    , 10.       ,  9.915039 , 10.3125   ,
       10.       , 10.3125   , 10.       , 10.       , 10.0703125,
       37.003906 , 10.40918  , 12.145508 , 10.       , 30.885742 ,
       35.280273 , 17.089844 , 33.78711  , 10.       , 10.3125   ,
       10.       , 37.25879  , 10.3125   , 12.712891 ,  8.652344 ,
       14.458984 , 83.96973  , 19.424805 , 17.804688 , 14.060547 ,
       10.       ], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>e1</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>7.618e+03 7.686e+03 ... 7.285e+03</div><input id='attrs-41d2f947-11f5-4534-83c0-ab930c283d8f' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-41d2f947-11f5-4534-83c0-ab930c283d8f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-361646ae-ff24-4cf9-82e7-ce6160f64cb5' class='xr-var-data-in' type='checkbox'><label for='data-361646ae-ff24-4cf9-82e7-ce6160f64cb5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([7617.912 , 7685.6387, 6547.1533, 7663.1045, 7262.1484, 7730.582 ,
       6461.591 , 6461.591 , 7074.802 , 7617.912 , 7377.966 , 7446.9775,
       6789.205 , 7842.205 , 7377.966 , 7886.5586, 7685.6387, 7180.49  ,
       7930.74  , 7121.871 , 7074.802 , 6704.8984, 6140.08  , 7685.6387,
       7831.091 , 7952.7676, 7354.881 , 6980.205 , 7331.758 , 7819.965 ,
       6620.1465, 7764.1797, 7685.6387, 8084.0186, 7074.802 , 7145.3477,
       7074.802 , 7685.6387, 6908.8594, 7527.032 , 7595.254 , 7145.3477,
       7730.582 , 7819.965 , 6522.751 , 6956.461 , 7250.5117, 7039.3994,
       7685.6387, 7074.802 , 7481.3477, 7730.582 , 7074.802 , 6486.082 ,
       6608.004 , 5812.949 , 5247.382 , 7015.75  , 6547.1533, 7685.6387,
       7285.3906], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>e2</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>7.414e+03 7.414e+03 ... 7.414e+03</div><input id='attrs-db804762-faba-4604-96da-0832513f5201' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-db804762-faba-4604-96da-0832513f5201' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-8d91d27b-26f4-4494-b52a-0c627cd913a7' class='xr-var-data-in' type='checkbox'><label for='data-8d91d27b-26f4-4494-b52a-0c627cd913a7' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>e3_0</span></div><div class='xr-var-dims'>(z_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>0.2002 0.4365 ... 0.541 0.2002</div><input id='attrs-797c80dd-9869-40df-bd19-5ae4560de366' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-797c80dd-9869-40df-bd19-5ae4560de366' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-89b5d950-97f4-4b5a-b015-33bb3ef121ca' class='xr-var-data-in' type='checkbox'><label for='data-89b5d950-97f4-4b5a-b015-33bb3ef121ca' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[0.20019531, 0.43652344, 0.5058594 , ..., 1.        , 0.5410156 ,
        0.20019531],
       [0.20019531, 0.43652344, 0.5058594 , ..., 0.9824219 , 0.5410156 ,
        0.20019531],
       [0.20019531, 0.43652344, 0.5058594 , ..., 0.96777344, 0.5410156 ,
        0.20019531],
       ...,
       [0.20019531, 0.43652344, 0.5058594 , ..., 5.0214844 , 0.5410156 ,
        0.20019531],
       [0.20019531, 0.43652344, 0.5058594 , ..., 4.057617  , 0.5410156 ,
        0.20019531],
       [0.20019531, 0.43652344, 0.5058594 , ..., 3.203125  , 0.5410156 ,
        0.20019531]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>bottom_level</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>50.0 50.0 12.0 ... 17.0 26.0 50.0</div><input id='attrs-c8a6dba9-31e7-45fc-8500-0d715d0c8f4c' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-c8a6dba9-31e7-45fc-8500-0d715d0c8f4c' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-7c359b2f-253e-4216-ba08-29f18a21e0f5' class='xr-var-data-in' type='checkbox'><label for='data-7c359b2f-253e-4216-ba08-29f18a21e0f5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([50., 50., 12., 32., 50., 50., 50., 50., 21., 50., 29., 42., 32.,
       42., 40., 33., 50., 25., 37., 32., 21., 50., 20., 50., 44., 24.,
       50., 24., 50., 43., 50., 50., 50., 34., 21., 50., 21., 50., 50.,
       33., 50., 11., 50., 50., 33., 45., 29., 39., 50., 21., 50., 50.,
       21., 19., 25., 25., 50., 44., 17., 26., 50.], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>landmask</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>bool</div><div class='xr-var-preview xr-preview'>False False False ... False False</div><input id='attrs-4fd95157-adb0-44e7-8672-acb5ffbcb5db' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-4fd95157-adb0-44e7-8672-acb5ffbcb5db' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-2090ba80-4112-47a4-8c2c-5e047a001ca7' class='xr-var-data-in' type='checkbox'><label for='data-2090ba80-4112-47a4-8c2c-5e047a001ca7' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>interp_dist</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>10.56 4.33 15.65 ... 4.96 3.957</div><input id='attrs-3cd1dc1c-4b5e-40e4-8ef9-8c5dddf3e90d' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-3cd1dc1c-4b5e-40e4-8ef9-8c5dddf3e90d' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-e1bfffe7-de10-46af-98e6-e56983a89b45' class='xr-var-data-in' type='checkbox'><label for='data-e1bfffe7-de10-46af-98e6-e56983a89b45' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([10.55753639,  4.3298596 , 15.65224834,  6.01847521,  6.21944535,
        6.03485965, 10.09762811,  5.83889348,  6.6716266 ,  7.06250586,
        3.81132755,  2.10403027, 10.89520817,  7.65307627,  3.12483581,
       11.15992752, 27.30753169,  4.52090493,  4.06485834,  4.67908778,
        6.6716266 ,  4.96772739,  5.4813996 ,  7.053344  ,  5.35290231,
        2.05865294,  6.49778121,  3.61860367, 12.72904061,  6.59773619,
        0.24707792,  5.27676859,  5.09090741,  5.52241217,  6.6716266 ,
        1.95744877,  6.6716266 ,  5.13046117,  2.83309362,  1.88771332,
        6.06839329,  7.32299892,  6.03485965,  7.69045765,  8.78690904,
        6.13400869,  2.11138548,  6.79115084,  5.13046117,  6.6716266 ,
        4.76955022,  6.29453137,  6.6716266 ,  1.82312538,  2.14643925,
       11.94656233,  1.34373275,  3.71293547,  5.83537153,  4.96020927,
        3.9566329 ])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-e40ad159-c788-4de7-b2bf-2e9352dc5df4' class='xr-section-summary-in' type='checkbox'  ><label for='section-e40ad159-c788-4de7-b2bf-2e9352dc5df4' class='xr-section-summary' >Indexes: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-index-name'><div>time</div></div><div class='xr-index-preview'>PandasIndex</div><div></div><input id='index-7ee7b95a-ba9b-445e-b740-f252b10c58c2' class='xr-index-data-in' type='checkbox'/><label for='index-7ee7b95a-ba9b-445e-b740-f252b10c58c2' title='Show/Hide index repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-index-data'><pre>PandasIndex(DatetimeIndex([&#x27;2007-01-01 00:00:00&#x27;, &#x27;2007-01-01 01:00:00&#x27;,
               &#x27;2007-01-01 02:00:00&#x27;, &#x27;2007-01-01 03:00:00&#x27;,
               &#x27;2007-01-01 04:00:00&#x27;, &#x27;2007-01-01 05:00:00&#x27;,
               &#x27;2007-01-01 06:00:00&#x27;, &#x27;2007-01-01 07:00:00&#x27;,
               &#x27;2007-01-01 08:00:00&#x27;, &#x27;2007-01-01 09:00:00&#x27;,
               ...
               &#x27;2007-01-30 14:00:00&#x27;, &#x27;2007-01-30 15:00:00&#x27;,
               &#x27;2007-01-30 16:00:00&#x27;, &#x27;2007-01-30 17:00:00&#x27;,
               &#x27;2007-01-30 18:00:00&#x27;, &#x27;2007-01-30 19:00:00&#x27;,
               &#x27;2007-01-30 20:00:00&#x27;, &#x27;2007-01-30 21:00:00&#x27;,
               &#x27;2007-01-30 22:00:00&#x27;, &#x27;2007-01-30 23:00:00&#x27;],
              dtype=&#x27;datetime64[ns]&#x27;, name=&#x27;time&#x27;, length=720, freq=None))</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-8d73775a-8976-408d-a017-382d226bb26d' class='xr-section-summary-in' type='checkbox'  checked><label for='section-8d73775a-8976-408d-a017-382d226bb26d' class='xr-section-summary' >Attributes: <span>(8)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'><dt><span>name :</span></dt><dd>AMM7_1d_20070101_20070131_25hourm_grid_T</dd><dt><span>description :</span></dt><dd>ocean T grid variables, 25h meaned</dd><dt><span>title :</span></dt><dd>ocean T grid variables, 25h meaned</dd><dt><span>Conventions :</span></dt><dd>CF-1.6</dd><dt><span>timeStamp :</span></dt><dd>2019-Dec-26 04:35:28 GMT</dd><dt><span>uuid :</span></dt><dd>96cae459-d3a1-4f4f-b82b-9259179f95f7</dd><dt><span>history :</span></dt><dd>Tue May 19 12:07:51 2020: ncks -v votemper,sossheig -d time_counter,0,30,5 AMM7_1d_20070101_20070131_25hourm_grid_T.nc example_data.nc</dd><dt><span>NCO :</span></dt><dd>4.4.7</dd></dl></div></li></ul></div></div>




```python
stn_id=26  # pick a gauge station

plt.subplot(2,1,1)
model_timeseries.dataset.ssh.isel(id_dim=stn_id).plot()  # rename time dimension to enable automatic x-axis labelling

plt.subplot(2,1,2)
obs.dataset.ssh.isel(id_dim=stn_id).swap_dims({'t_dim':'time'}).plot()  # rename time dimension to enable automatic x-axis labelling
plt.tight_layout()
plt.show()
```


    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_35_0.png)
    


We can see that the structure for the new dataset `model_timeseries`, generated from the gridded model simulation, is that of a `tidegauge` object. NB in the example simulation data the ssh variable is output as 5-day means. So it is not particulatly useful for high frequency validation but serves as a demonstration of the workflow.

## Tidegauge analysis methods

For a good comparison, we would like to make sure that both the observed and
modelled `Tidegauge` objects contain the same missing values. `TidegaugeAnalysis`
contains a routine for ensuring this. First create our analysis object:


```python
tganalysis = coast.TidegaugeAnalysis()
```


```python
# This routine searches for missing values in each dataset and applies them
# equally to each corresponding dataset
obs_new, model_new = tganalysis.match_missing_values(obs.dataset.ssh, model_timeseries.dataset.ssh)
```

    Tidegauge object at 0x55faea1b3fc0 initialised
    Tidegauge object at 0x55faea1b3fc0 initialised


Although we input data arrays to the above routine, it returns two new Tidegauge objects. Now you have equivalent and comparable sets of time series that can be easily compared.

### Harmonic Analysis & Non tidal-Residuals

The `Tidegauge` object contains some routines which make harmonic analysis and
the calculation/comparison of non-tidal residuals easier. Harmonic analysis is
done using the `utide` package. Please see [here](https://pypi.org/project/UTide/) for more info.

First we can use the `TidegaugeAnalysis` class to do a harmonic analysis. Suppose
we have two `Tidegauge` objects called `obs` and `model_timeseries` generated from tidegauge observations and model simulations respectively.

Then subtract means from all the time series


```python
# Subtract means from all time series
obs_new = tganalysis.demean_timeseries(obs_new.dataset)
model_new = tganalysis.demean_timeseries(model_new.dataset)

# Now you have equivalent and comparable sets of time series that can be
# easily compared.
```

    Tidegauge object at 0x55faea1b3fc0 initialised
    Tidegauge object at 0x55faea1b3fc0 initialised



```python

```


```python
plt.figure()
plt.plot( model_new.dataset.time, model_new.dataset.ssh.isel(id_dim=stn_id),
         label='model - demeaned', color='orange' )
plt.plot( obs_new.dataset.time, obs_new.dataset.ssh.isel(id_dim=stn_id) ,
         label='obs - demeaned', color='blue' )
plt.title(f'model and observed timeseries : {obs_new.dataset.site_name.isel(id_dim=stn_id).coords}')
plt.legend()
plt.xticks(rotation=45)
plt.show()
```


    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_44_0.png)
    


Then we can apply the harmonic analysis (though the example data is too short for this example to be that meaningful and the model data is only saved as 5-day means! Nevertheless we proceed):

### Calculate non tidal residuals



First, do a harmonic analysis. This routine uses utide


```python
ha_mod = tganalysis.harmonic_analysis_utide(model_new.dataset.ssh, min_datapoints=1)
ha_obs = tganalysis.harmonic_analysis_utide(obs_new.dataset.ssh, min_datapoints=1)
```

    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.
    solve: matrix prep ... solution ... done.


The `harmonic_analysis_utide` routine returns a list of `utide` structure object,
one for each `id_dim` in the `Tidegauge` object. It can be passed any of the
arguments that go to `utide`. It also has an additional argument `min_datapoints`
which determines a minimum number of data points for the harmonics analysis.
If a tidegauge `id_dim` has less than this number, it will not return an analysis.

Now, create new `TidegaugeMultiple` objects containing reconstructed tides:



```python
tide_mod = tganalysis.reconstruct_tide_utide(model_new.dataset.time, ha_mod)
tide_obs = tganalysis.reconstruct_tide_utide(obs_new.dataset.time, ha_obs)

```

    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    Tidegauge object at 0x55faea1b3fc0 initialised
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    prep/calcs ... done.
    Tidegauge object at 0x55faea1b3fc0 initialised


Get new TidegaugeMultiple objects containing non tidal residuals:


```python
ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed, apply_filter=False)
ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed, apply_filter=True, window_length=10, polyorder=2)

# Take a look
ntr_obs.dataset
```

    Tidegauge object at 0x55faea1b3fc0 initialised
    Tidegauge object at 0x55faea1b3fc0 initialised





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
body[data-theme=dark],
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

.xr-index-preview {
  grid-column: 2 / 5;
  color: var(--xr-font-color2);
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
.xr-var-data,
.xr-index-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data,
.xr-index-data-in:checked ~ .xr-index-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-index-name div,
.xr-index-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data,
.xr-index-data {
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
.xr-icon-file-text2,
.xr-no-icon {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:    (t_dim: 720, id_dim: 61)
Coordinates:
    time       (t_dim) datetime64[ns] 2007-01-01 ... 2007-01-30T23:00:00
    longitude  (id_dim) float64 1.292 -3.975 -5.158 -5.051 ... 7.567 350.8 8.717
    latitude   (id_dim) float64 51.95 51.57 57.9 51.71 ... 58.0 51.53 53.87
    site_name  (id_dim) object &#x27;Harwich&#x27; &#x27;Mumbles&#x27; &#x27;Ullapool&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;
Dimensions without coordinates: t_dim, id_dim
Data variables:
    ntr        (id_dim, t_dim) float64 0.4182 0.4182 0.4182 ... -0.02699 0.2945</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-21bf1df3-8baf-479f-8a97-1b320d7124ee' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-21bf1df3-8baf-479f-8a97-1b320d7124ee' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>t_dim</span>: 720</li><li><span>id_dim</span>: 61</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-ef81b767-0f37-4095-8577-c7299a1292ab' class='xr-section-summary-in' type='checkbox'  checked><label for='section-ef81b767-0f37-4095-8577-c7299a1292ab' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-01 ... 2007-01-30T23:00:00</div><input id='attrs-32731578-00af-4456-83eb-4e29cd400155' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-32731578-00af-4456-83eb-4e29cd400155' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-6cc5cec3-7f1f-4455-9ad6-6d0515f5183e' class='xr-var-data-in' type='checkbox'><label for='data-6cc5cec3-7f1f-4455-9ad6-6d0515f5183e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-01T00:00:00.000000000&#x27;, &#x27;2007-01-01T01:00:00.000000000&#x27;,
       &#x27;2007-01-01T02:00:00.000000000&#x27;, &#x27;2007-01-01T03:00:00.000000000&#x27;,
       &#x27;2007-01-01T04:00:00.000000000&#x27;, &#x27;2007-01-01T05:00:00.000000000&#x27;,
       &#x27;2007-01-01T06:00:00.000000000&#x27;, &#x27;2007-01-01T07:00:00.000000000&#x27;,
       &#x27;2007-01-01T08:00:00.000000000&#x27;, &#x27;2007-01-01T09:00:00.000000000&#x27;,
       &#x27;2007-01-01T10:00:00.000000000&#x27;, &#x27;2007-01-01T11:00:00.000000000&#x27;,
       &#x27;2007-01-01T12:00:00.000000000&#x27;, &#x27;2007-01-01T13:00:00.000000000&#x27;,
       &#x27;2007-01-01T14:00:00.000000000&#x27;, &#x27;2007-01-01T15:00:00.000000000&#x27;,
       &#x27;2007-01-01T16:00:00.000000000&#x27;, &#x27;2007-01-01T17:00:00.000000000&#x27;,
       &#x27;2007-01-01T18:00:00.000000000&#x27;, &#x27;2007-01-01T19:00:00.000000000&#x27;,
       &#x27;2007-01-01T20:00:00.000000000&#x27;, &#x27;2007-01-01T21:00:00.000000000&#x27;,
       &#x27;2007-01-01T22:00:00.000000000&#x27;, &#x27;2007-01-01T23:00:00.000000000&#x27;,
       &#x27;2007-01-02T00:00:00.000000000&#x27;, &#x27;2007-01-02T01:00:00.000000000&#x27;,
       &#x27;2007-01-02T02:00:00.000000000&#x27;, &#x27;2007-01-02T03:00:00.000000000&#x27;,
       &#x27;2007-01-02T04:00:00.000000000&#x27;, &#x27;2007-01-02T05:00:00.000000000&#x27;,
       &#x27;2007-01-02T06:00:00.000000000&#x27;, &#x27;2007-01-02T07:00:00.000000000&#x27;,
       &#x27;2007-01-02T08:00:00.000000000&#x27;, &#x27;2007-01-02T09:00:00.000000000&#x27;,
       &#x27;2007-01-02T10:00:00.000000000&#x27;, &#x27;2007-01-02T11:00:00.000000000&#x27;,
       &#x27;2007-01-02T12:00:00.000000000&#x27;, &#x27;2007-01-02T13:00:00.000000000&#x27;,
       &#x27;2007-01-02T14:00:00.000000000&#x27;, &#x27;2007-01-02T15:00:00.000000000&#x27;,
...
       &#x27;2007-01-29T10:00:00.000000000&#x27;, &#x27;2007-01-29T11:00:00.000000000&#x27;,
       &#x27;2007-01-29T12:00:00.000000000&#x27;, &#x27;2007-01-29T13:00:00.000000000&#x27;,
       &#x27;2007-01-29T14:00:00.000000000&#x27;, &#x27;2007-01-29T15:00:00.000000000&#x27;,
       &#x27;2007-01-29T16:00:00.000000000&#x27;, &#x27;2007-01-29T17:00:00.000000000&#x27;,
       &#x27;2007-01-29T18:00:00.000000000&#x27;, &#x27;2007-01-29T19:00:00.000000000&#x27;,
       &#x27;2007-01-29T20:00:00.000000000&#x27;, &#x27;2007-01-29T21:00:00.000000000&#x27;,
       &#x27;2007-01-29T22:00:00.000000000&#x27;, &#x27;2007-01-29T23:00:00.000000000&#x27;,
       &#x27;2007-01-30T00:00:00.000000000&#x27;, &#x27;2007-01-30T01:00:00.000000000&#x27;,
       &#x27;2007-01-30T02:00:00.000000000&#x27;, &#x27;2007-01-30T03:00:00.000000000&#x27;,
       &#x27;2007-01-30T04:00:00.000000000&#x27;, &#x27;2007-01-30T05:00:00.000000000&#x27;,
       &#x27;2007-01-30T06:00:00.000000000&#x27;, &#x27;2007-01-30T07:00:00.000000000&#x27;,
       &#x27;2007-01-30T08:00:00.000000000&#x27;, &#x27;2007-01-30T09:00:00.000000000&#x27;,
       &#x27;2007-01-30T10:00:00.000000000&#x27;, &#x27;2007-01-30T11:00:00.000000000&#x27;,
       &#x27;2007-01-30T12:00:00.000000000&#x27;, &#x27;2007-01-30T13:00:00.000000000&#x27;,
       &#x27;2007-01-30T14:00:00.000000000&#x27;, &#x27;2007-01-30T15:00:00.000000000&#x27;,
       &#x27;2007-01-30T16:00:00.000000000&#x27;, &#x27;2007-01-30T17:00:00.000000000&#x27;,
       &#x27;2007-01-30T18:00:00.000000000&#x27;, &#x27;2007-01-30T19:00:00.000000000&#x27;,
       &#x27;2007-01-30T20:00:00.000000000&#x27;, &#x27;2007-01-30T21:00:00.000000000&#x27;,
       &#x27;2007-01-30T22:00:00.000000000&#x27;, &#x27;2007-01-30T23:00:00.000000000&#x27;],
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.292 -3.975 -5.158 ... 350.8 8.717</div><input id='attrs-dee55685-f6e3-443a-ae3a-560919693357' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-dee55685-f6e3-443a-ae3a-560919693357' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-3fedc85c-963d-440b-8695-6ae522a1d49f' class='xr-var-data-in' type='checkbox'><label for='data-3fedc85c-963d-440b-8695-6ae522a1d49f' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 1.29210000e+00, -3.97544000e+00, -5.15789000e+00, -5.05148000e+00,
       -2.92042000e+00, -3.13433000e+00, -5.05036000e+00, -3.08631000e+00,
       -1.43978000e+00,  1.34839000e+00, -4.62044000e+00,  1.30164000e+00,
       -6.06422000e+00, -2.44794000e+00, -3.82522000e+00, -4.18525000e+00,
        7.43440000e-01, -6.14170000e-01, -5.54283000e+00, -5.12003000e+00,
       -1.43978000e+00, -2.08013000e+00, -1.14031000e+00, -2.98744000e+00,
       -1.87486000e+00, -6.31642000e+00, -3.01800000e+00, -6.19006000e+00,
       -1.86030000e-01,  5.70300000e-02, -4.00220000e+00,  1.32267000e+00,
       -2.71497000e+00, -2.11667000e+00, -1.43978000e+00, -3.56764000e+00,
       -1.43978000e+00, -2.72848000e+00, -3.18169000e+00,  1.75083000e+00,
       -4.98333000e+00, -5.66947000e+00, -3.13433000e+00, -1.11175000e+00,
       -6.38889000e+00, -4.90583000e+00, -4.76806000e+00, -6.65683000e+00,
       -2.72848000e+00, -1.43978000e+00, -4.04517000e+00, -4.11094000e+00,
       -1.43978000e+00,  1.12150002e+01,  1.18000002e+01,  5.11700010e+00,
        1.12500000e+01,  3.52666992e+02,  7.56699991e+00,  3.50816986e+02,
        8.71700001e+00])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>51.95 51.57 57.9 ... 51.53 53.87</div><input id='attrs-4b4dcf89-d824-408a-906c-1f7e07cd9dc4' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-4b4dcf89-d824-408a-906c-1f7e07cd9dc4' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-dcb0c352-96fa-4268-8a9f-19e581ce42f8' class='xr-var-data-in' type='checkbox'><label for='data-dcb0c352-96fa-4268-8a9f-19e581ce42f8' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([51.94798   , 51.57      , 57.89525   , 51.7064    , 54.03167   ,
       51.21525   , 58.45661   , 58.44097   , 55.00744   , 51.95675   ,
       53.31394   , 52.93436   , 56.62311   , 50.6085    , 53.33167   ,
       50.36839   , 51.44564   , 54.49008   , 50.103     , 54.84256   ,
       55.00744   , 57.14406   , 60.15403   , 51.55      , 50.71433   ,
       49.91847   , 53.44969   , 55.62742   , 53.63103   , 50.78178   ,
       57.5987    , 51.11439   , 51.51089   , 49.18333   , 55.00744   ,
       54.65081   , 55.00744   , 51.50002   , 55.98983   , 52.473     ,
       52.01378   , 54.66475   , 51.21525   , 50.80256   , 58.20711   ,
       55.74964   , 54.08539   , 55.20678   , 51.50002   , 55.00744   ,
       52.71906   , 51.21097   , 55.00744   , 58.34999847, 57.68299866,
       61.93299866, 64.86699677, 55.36700058, 58.        , 51.53300095,
       53.86700058])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>site_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>object</div><div class='xr-var-preview xr-preview'>&#x27;Harwich&#x27; &#x27;Mumbles&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;</div><input id='attrs-6a04cbd0-c4d1-42f5-ab12-e69242601d76' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-6a04cbd0-c4d1-42f5-ab12-e69242601d76' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-7c15a7c2-185e-43a1-80ca-f8ff86d5aa0b' class='xr-var-data-in' type='checkbox'><label for='data-7c15a7c2-185e-43a1-80ca-f8ff86d5aa0b' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Harwich&#x27;, &#x27;Mumbles&#x27;, &#x27;Ullapool&#x27;, &#x27;Milford Haven&#x27;, &#x27;Heysham&#x27;,
       &#x27;Hinkley Point&#x27;, &#x27;Kinlochbervie&#x27;, &#x27;Wick&#x27;, &#x27;North Shields&#x27;,
       &#x27;Felixstowe&#x27;, &#x27;Holyhead&#x27;, &#x27;Cromer&#x27;, &#x27;Tobermory&#x27;, &#x27;Weymouth&#x27;,
       &#x27;Llandudno&#x27;, &#x27;Devonport&#x27;, &#x27;Sheerness&#x27;, &#x27;Whitby&#x27;, &#x27;Newlyn&#x27;,
       &#x27;Portpatrick&#x27;, &#x27;North Shields&#x27;, &#x27;Aberdeen&#x27;, &#x27;Lerwick&#x27;, &#x27;Newport&#x27;,
       &#x27;Bournemouth&#x27;, &quot;St. Mary&#x27;s&quot;, &#x27;Liverpool, Gladstone Dock&#x27;,
       &#x27;Port Ellen (Islay)&#x27;, &#x27;Immingham&#x27;, &#x27;Newhaven&#x27;, &#x27;Moray Firth&#x27;,
       &#x27;Dover&#x27;, &#x27;Avonmouth&#x27;, &#x27;St. Helier (Jersey)&#x27;, &#x27;North Shields&#x27;,
       &#x27;Workington&#x27;, &#x27;North Shields&#x27;, &#x27;Portbury&#x27;, &#x27;Leith&#x27;, &#x27;Lowestoft&#x27;,
       &#x27;Fishguard&#x27;, &#x27;Bangor&#x27;, &#x27;Hinkley Point&#x27;, &#x27;Portsmouth&#x27;, &#x27;Stornoway&#x27;,
       &#x27;Millport&#x27;, &#x27;Port Erin&#x27;, &#x27;Portrush&#x27;, &#x27;Portbury&#x27;, &#x27;North Shields&#x27;,
       &#x27;Barmouth&#x27;, &#x27;Ilfracombe&#x27;, &#x27;North Shields&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;,
       &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;], dtype=object)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-0d386319-d908-4078-9a63-2a941d28ccf7' class='xr-section-summary-in' type='checkbox'  checked><label for='section-0d386319-d908-4078-9a63-2a941d28ccf7' class='xr-section-summary' >Data variables: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>ntr</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>0.4182 0.4182 ... -0.02699 0.2945</div><input id='attrs-59071ae7-9046-4fdf-b181-c6a5d8cc0808' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-59071ae7-9046-4fdf-b181-c6a5d8cc0808' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ef929a47-8371-4b73-9ef0-78b29cbd2ed3' class='xr-var-data-in' type='checkbox'><label for='data-ef929a47-8371-4b73-9ef0-78b29cbd2ed3' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[ 0.41824902,  0.41824902,  0.41824902, ..., -0.34442645,
        -0.14399667,  0.11602685],
       [ 0.21228445,  0.21228445,  0.21228445, ...,  0.11863819,
         0.11863819,  0.11863819],
       [ 0.1459287 ,  0.1459287 ,  0.1459287 , ...,  0.1846614 ,
         0.2464215 ,  0.31395693],
       ...,
       [-0.17406373, -0.17406373, -0.17406373, ..., -0.1497518 ,
        -0.18778463, -0.23589221],
       [-0.09974818, -0.09974818, -0.09974818, ..., -0.00720227,
        -0.07338597, -0.16374877],
       [ 0.75580794,  0.75580794,  0.75580794, ..., -0.2887721 ,
        -0.0269909 ,  0.29453278]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-e4a0a2fd-421c-4146-98c6-4d5a4861f658' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-e4a0a2fd-421c-4146-98c6-4d5a4861f658' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-593289ba-b811-48f3-a625-3bd16538bd7e' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-593289ba-b811-48f3-a625-3bd16538bd7e' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



The dataset structure is preserved and has created a new variable called `ntr` - non-tidal residual.

By default, this routines will apply `scipy.signal.savgol_filter` to the non-tidal residuals
to remove some noise. This can be switched off using `apply_filter = False`.

The Doodson X0 filter is an alternative way of estimating non-tidal residuals. This will return a new Tidegauge() object containing filtered ssh data:


```python
dx0 = tganalysis.doodson_x0_filter(obs_new.dataset, "ssh")

# take a look
dx0.dataset

```

    Tidegauge object at 0x55faea1b3fc0 initialised





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
body[data-theme=dark],
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

.xr-index-preview {
  grid-column: 2 / 5;
  color: var(--xr-font-color2);
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
.xr-var-data,
.xr-index-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data,
.xr-index-data-in:checked ~ .xr-index-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-index-name div,
.xr-index-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data,
.xr-index-data {
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
.xr-icon-file-text2,
.xr-no-icon {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:    (t_dim: 720, id_dim: 61)
Coordinates:
    latitude   (id_dim) float64 51.95 51.57 57.9 51.71 ... 58.0 51.53 53.87
    site_name  (id_dim) object &#x27;Harwich&#x27; &#x27;Mumbles&#x27; &#x27;Ullapool&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;
    longitude  (id_dim) float64 1.292 -3.975 -5.158 -5.051 ... 7.567 350.8 8.717
Dimensions without coordinates: t_dim, id_dim
Data variables:
    time       (t_dim) datetime64[ns] 2007-01-01 ... 2007-01-30T23:00:00
    ssh        (id_dim, t_dim) float64 nan nan nan nan nan ... nan nan nan nan</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-7b3c9d4f-3c19-49e0-a71c-e51aec7b0e8b' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-7b3c9d4f-3c19-49e0-a71c-e51aec7b0e8b' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>t_dim</span>: 720</li><li><span>id_dim</span>: 61</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-af409414-9e22-4971-86f7-6fd23fe702ff' class='xr-section-summary-in' type='checkbox'  checked><label for='section-af409414-9e22-4971-86f7-6fd23fe702ff' class='xr-section-summary' >Coordinates: <span>(3)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>51.95 51.57 57.9 ... 51.53 53.87</div><input id='attrs-7eaa04c4-3e61-4edf-9515-efcbdbaac018' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-7eaa04c4-3e61-4edf-9515-efcbdbaac018' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-7c03b147-6c20-431a-af8e-b48828fef99e' class='xr-var-data-in' type='checkbox'><label for='data-7c03b147-6c20-431a-af8e-b48828fef99e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([51.94798   , 51.57      , 57.89525   , 51.7064    , 54.03167   ,
       51.21525   , 58.45661   , 58.44097   , 55.00744   , 51.95675   ,
       53.31394   , 52.93436   , 56.62311   , 50.6085    , 53.33167   ,
       50.36839   , 51.44564   , 54.49008   , 50.103     , 54.84256   ,
       55.00744   , 57.14406   , 60.15403   , 51.55      , 50.71433   ,
       49.91847   , 53.44969   , 55.62742   , 53.63103   , 50.78178   ,
       57.5987    , 51.11439   , 51.51089   , 49.18333   , 55.00744   ,
       54.65081   , 55.00744   , 51.50002   , 55.98983   , 52.473     ,
       52.01378   , 54.66475   , 51.21525   , 50.80256   , 58.20711   ,
       55.74964   , 54.08539   , 55.20678   , 51.50002   , 55.00744   ,
       52.71906   , 51.21097   , 55.00744   , 58.34999847, 57.68299866,
       61.93299866, 64.86699677, 55.36700058, 58.        , 51.53300095,
       53.86700058])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>site_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>object</div><div class='xr-var-preview xr-preview'>&#x27;Harwich&#x27; &#x27;Mumbles&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;</div><input id='attrs-15e30399-baad-4e10-86a1-fb3490665961' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-15e30399-baad-4e10-86a1-fb3490665961' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-0d738770-3179-49d9-9599-c2a9ff56b162' class='xr-var-data-in' type='checkbox'><label for='data-0d738770-3179-49d9-9599-c2a9ff56b162' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Harwich&#x27;, &#x27;Mumbles&#x27;, &#x27;Ullapool&#x27;, &#x27;Milford Haven&#x27;, &#x27;Heysham&#x27;,
       &#x27;Hinkley Point&#x27;, &#x27;Kinlochbervie&#x27;, &#x27;Wick&#x27;, &#x27;North Shields&#x27;,
       &#x27;Felixstowe&#x27;, &#x27;Holyhead&#x27;, &#x27;Cromer&#x27;, &#x27;Tobermory&#x27;, &#x27;Weymouth&#x27;,
       &#x27;Llandudno&#x27;, &#x27;Devonport&#x27;, &#x27;Sheerness&#x27;, &#x27;Whitby&#x27;, &#x27;Newlyn&#x27;,
       &#x27;Portpatrick&#x27;, &#x27;North Shields&#x27;, &#x27;Aberdeen&#x27;, &#x27;Lerwick&#x27;, &#x27;Newport&#x27;,
       &#x27;Bournemouth&#x27;, &quot;St. Mary&#x27;s&quot;, &#x27;Liverpool, Gladstone Dock&#x27;,
       &#x27;Port Ellen (Islay)&#x27;, &#x27;Immingham&#x27;, &#x27;Newhaven&#x27;, &#x27;Moray Firth&#x27;,
       &#x27;Dover&#x27;, &#x27;Avonmouth&#x27;, &#x27;St. Helier (Jersey)&#x27;, &#x27;North Shields&#x27;,
       &#x27;Workington&#x27;, &#x27;North Shields&#x27;, &#x27;Portbury&#x27;, &#x27;Leith&#x27;, &#x27;Lowestoft&#x27;,
       &#x27;Fishguard&#x27;, &#x27;Bangor&#x27;, &#x27;Hinkley Point&#x27;, &#x27;Portsmouth&#x27;, &#x27;Stornoway&#x27;,
       &#x27;Millport&#x27;, &#x27;Port Erin&#x27;, &#x27;Portrush&#x27;, &#x27;Portbury&#x27;, &#x27;North Shields&#x27;,
       &#x27;Barmouth&#x27;, &#x27;Ilfracombe&#x27;, &#x27;North Shields&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;,
       &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;], dtype=object)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.292 -3.975 -5.158 ... 350.8 8.717</div><input id='attrs-0de50ef0-fef8-43e2-87ee-b7aeb92e00fa' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-0de50ef0-fef8-43e2-87ee-b7aeb92e00fa' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-f797c0b5-f1b1-4590-bbdd-d7e0dd0f38bf' class='xr-var-data-in' type='checkbox'><label for='data-f797c0b5-f1b1-4590-bbdd-d7e0dd0f38bf' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 1.29210000e+00, -3.97544000e+00, -5.15789000e+00, -5.05148000e+00,
       -2.92042000e+00, -3.13433000e+00, -5.05036000e+00, -3.08631000e+00,
       -1.43978000e+00,  1.34839000e+00, -4.62044000e+00,  1.30164000e+00,
       -6.06422000e+00, -2.44794000e+00, -3.82522000e+00, -4.18525000e+00,
        7.43440000e-01, -6.14170000e-01, -5.54283000e+00, -5.12003000e+00,
       -1.43978000e+00, -2.08013000e+00, -1.14031000e+00, -2.98744000e+00,
       -1.87486000e+00, -6.31642000e+00, -3.01800000e+00, -6.19006000e+00,
       -1.86030000e-01,  5.70300000e-02, -4.00220000e+00,  1.32267000e+00,
       -2.71497000e+00, -2.11667000e+00, -1.43978000e+00, -3.56764000e+00,
       -1.43978000e+00, -2.72848000e+00, -3.18169000e+00,  1.75083000e+00,
       -4.98333000e+00, -5.66947000e+00, -3.13433000e+00, -1.11175000e+00,
       -6.38889000e+00, -4.90583000e+00, -4.76806000e+00, -6.65683000e+00,
       -2.72848000e+00, -1.43978000e+00, -4.04517000e+00, -4.11094000e+00,
       -1.43978000e+00,  1.12150002e+01,  1.18000002e+01,  5.11700010e+00,
        1.12500000e+01,  3.52666992e+02,  7.56699991e+00,  3.50816986e+02,
        8.71700001e+00])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-fdf0c3d1-7423-4403-b030-a09cb026e085' class='xr-section-summary-in' type='checkbox'  checked><label for='section-fdf0c3d1-7423-4403-b030-a09cb026e085' class='xr-section-summary' >Data variables: <span>(2)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-01 ... 2007-01-30T23:00:00</div><input id='attrs-7320b440-a3f2-48dd-9d27-107bcd1ec93c' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-7320b440-a3f2-48dd-9d27-107bcd1ec93c' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-fd872c58-b9d1-4876-a92c-e4fc621f7cf1' class='xr-var-data-in' type='checkbox'><label for='data-fd872c58-b9d1-4876-a92c-e4fc621f7cf1' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-01T00:00:00.000000000&#x27;, &#x27;2007-01-01T01:00:00.000000000&#x27;,
       &#x27;2007-01-01T02:00:00.000000000&#x27;, &#x27;2007-01-01T03:00:00.000000000&#x27;,
       &#x27;2007-01-01T04:00:00.000000000&#x27;, &#x27;2007-01-01T05:00:00.000000000&#x27;,
       &#x27;2007-01-01T06:00:00.000000000&#x27;, &#x27;2007-01-01T07:00:00.000000000&#x27;,
       &#x27;2007-01-01T08:00:00.000000000&#x27;, &#x27;2007-01-01T09:00:00.000000000&#x27;,
       &#x27;2007-01-01T10:00:00.000000000&#x27;, &#x27;2007-01-01T11:00:00.000000000&#x27;,
       &#x27;2007-01-01T12:00:00.000000000&#x27;, &#x27;2007-01-01T13:00:00.000000000&#x27;,
       &#x27;2007-01-01T14:00:00.000000000&#x27;, &#x27;2007-01-01T15:00:00.000000000&#x27;,
       &#x27;2007-01-01T16:00:00.000000000&#x27;, &#x27;2007-01-01T17:00:00.000000000&#x27;,
       &#x27;2007-01-01T18:00:00.000000000&#x27;, &#x27;2007-01-01T19:00:00.000000000&#x27;,
       &#x27;2007-01-01T20:00:00.000000000&#x27;, &#x27;2007-01-01T21:00:00.000000000&#x27;,
       &#x27;2007-01-01T22:00:00.000000000&#x27;, &#x27;2007-01-01T23:00:00.000000000&#x27;,
       &#x27;2007-01-02T00:00:00.000000000&#x27;, &#x27;2007-01-02T01:00:00.000000000&#x27;,
       &#x27;2007-01-02T02:00:00.000000000&#x27;, &#x27;2007-01-02T03:00:00.000000000&#x27;,
       &#x27;2007-01-02T04:00:00.000000000&#x27;, &#x27;2007-01-02T05:00:00.000000000&#x27;,
       &#x27;2007-01-02T06:00:00.000000000&#x27;, &#x27;2007-01-02T07:00:00.000000000&#x27;,
       &#x27;2007-01-02T08:00:00.000000000&#x27;, &#x27;2007-01-02T09:00:00.000000000&#x27;,
       &#x27;2007-01-02T10:00:00.000000000&#x27;, &#x27;2007-01-02T11:00:00.000000000&#x27;,
       &#x27;2007-01-02T12:00:00.000000000&#x27;, &#x27;2007-01-02T13:00:00.000000000&#x27;,
       &#x27;2007-01-02T14:00:00.000000000&#x27;, &#x27;2007-01-02T15:00:00.000000000&#x27;,
...
       &#x27;2007-01-29T10:00:00.000000000&#x27;, &#x27;2007-01-29T11:00:00.000000000&#x27;,
       &#x27;2007-01-29T12:00:00.000000000&#x27;, &#x27;2007-01-29T13:00:00.000000000&#x27;,
       &#x27;2007-01-29T14:00:00.000000000&#x27;, &#x27;2007-01-29T15:00:00.000000000&#x27;,
       &#x27;2007-01-29T16:00:00.000000000&#x27;, &#x27;2007-01-29T17:00:00.000000000&#x27;,
       &#x27;2007-01-29T18:00:00.000000000&#x27;, &#x27;2007-01-29T19:00:00.000000000&#x27;,
       &#x27;2007-01-29T20:00:00.000000000&#x27;, &#x27;2007-01-29T21:00:00.000000000&#x27;,
       &#x27;2007-01-29T22:00:00.000000000&#x27;, &#x27;2007-01-29T23:00:00.000000000&#x27;,
       &#x27;2007-01-30T00:00:00.000000000&#x27;, &#x27;2007-01-30T01:00:00.000000000&#x27;,
       &#x27;2007-01-30T02:00:00.000000000&#x27;, &#x27;2007-01-30T03:00:00.000000000&#x27;,
       &#x27;2007-01-30T04:00:00.000000000&#x27;, &#x27;2007-01-30T05:00:00.000000000&#x27;,
       &#x27;2007-01-30T06:00:00.000000000&#x27;, &#x27;2007-01-30T07:00:00.000000000&#x27;,
       &#x27;2007-01-30T08:00:00.000000000&#x27;, &#x27;2007-01-30T09:00:00.000000000&#x27;,
       &#x27;2007-01-30T10:00:00.000000000&#x27;, &#x27;2007-01-30T11:00:00.000000000&#x27;,
       &#x27;2007-01-30T12:00:00.000000000&#x27;, &#x27;2007-01-30T13:00:00.000000000&#x27;,
       &#x27;2007-01-30T14:00:00.000000000&#x27;, &#x27;2007-01-30T15:00:00.000000000&#x27;,
       &#x27;2007-01-30T16:00:00.000000000&#x27;, &#x27;2007-01-30T17:00:00.000000000&#x27;,
       &#x27;2007-01-30T18:00:00.000000000&#x27;, &#x27;2007-01-30T19:00:00.000000000&#x27;,
       &#x27;2007-01-30T20:00:00.000000000&#x27;, &#x27;2007-01-30T21:00:00.000000000&#x27;,
       &#x27;2007-01-30T22:00:00.000000000&#x27;, &#x27;2007-01-30T23:00:00.000000000&#x27;],
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>ssh</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-db70aea6-e273-4552-b027-5ff292d5246a' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-db70aea6-e273-4552-b027-5ff292d5246a' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ecfc1bcf-267f-4fb9-9c68-ab4e850d8770' class='xr-var-data-in' type='checkbox'><label for='data-ecfc1bcf-267f-4fb9-9c68-ab4e850d8770' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan],
       ...,
       [nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-015b5091-a208-4756-a314-65a02dca584c' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-015b5091-a208-4756-a314-65a02dca584c' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-3c6dd468-5557-41f3-be85-680927534c85' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-3c6dd468-5557-41f3-be85-680927534c85' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>




```python

```

We can compare these analyses e.g. the observed timeseries against the harmonic reconstruction. Noting we can in principle extend the harmoninc reconstruction beyond the observation time window.


```python
plt.figure()
plt.plot( tide_obs.dataset.time, tide_obs.dataset.reconstructed.isel(id_dim=stn_id), label='reconstructed from harmonics', color='orange' )
plt.plot( obs_new.dataset.time, obs_new.dataset.ssh.isel(id_dim=stn_id) , label='observed', color='blue' )
plt.legend()
plt.xticks(rotation=45)
plt.show()
```


    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_57_0.png)
    


We can also look closer at the difference between the observed timeseries and the harmonic reconstruction, that is the non-tidal residual. And we can compare the observed and modelled non-harmonic residual and contrast the different methods of removing the tides. Here we contrast using a harmonic analysis (and creating a "non-tidal residual") with the DoodsonX0 filter. Note that the timeseries is far too short for a sensible analysis and that this is really a demonstration of concept.


```python
plt.figure()
plt.subplot(2,1,1)
plt.plot( dx0.dataset.time, dx0.isel(id_dim=stn_id).dataset.ssh, label='obs: doodsonX0 filtered', color='orange' )
plt.plot( ntr_obs.dataset.time, ntr_obs.isel(id_dim=stn_id).dataset.ntr, label='obs: non-tidal residual', color='blue' )
plt.title('analysis comparison: non-tidal residual vs doodsonX0')
plt.legend()
plt.xticks(rotation=45)

plt.subplot(2,1,2)
plt.plot( ntr_mod.dataset.time, ntr_mod.isel(id_dim=stn_id).dataset.ntr, label='model: non-tidal residual', color='g' )
plt.plot( ntr_obs.dataset.time, ntr_obs.isel(id_dim=stn_id).dataset.ntr, label='obs: non-tidal residual', color='blue' )
plt.title('model vs observation: non-tidal residual')
plt.legend()
plt.xticks(rotation=45)

plt.tight_layout()

```


    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_59_0.png)
    


### Threshold Statistics for non-tidal residuals

This is a simple extreme value analysis of whatever data you use. It will count the number of peaks and the total time spent over each threshold provided. It will also count the numbers of daily and monthly maxima over each threshold. To this, a Tidegauge object and an array of thresholds (in metres) should be passed. The method return `peak_count_*`, `time_over_threshold_*`, `dailymax_count_*`, `monthlymax_count_*`:



```python
thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(-2, 2, 0.1))
thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(-2, 2, 0.1))
```


```python
# Have a look
thresh_obs
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
body[data-theme=dark],
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

.xr-index-preview {
  grid-column: 2 / 5;
  color: var(--xr-font-color2);
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
.xr-var-data,
.xr-index-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data,
.xr-index-data-in:checked ~ .xr-index-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-index-name div,
.xr-index-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data,
.xr-index-data {
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
.xr-icon-file-text2,
.xr-no-icon {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:                  (t_dim: 720, id_dim: 61, threshold: 40)
Coordinates:
    latitude                 (id_dim) float64 51.95 51.57 57.9 ... 51.53 53.87
    site_name                (id_dim) object &#x27;Harwich&#x27; &#x27;Mumbles&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;
    longitude                (id_dim) float64 1.292 -3.975 ... 350.8 8.717
  * threshold                (threshold) float64 -2.0 -1.9 -1.8 ... 1.7 1.8 1.9
Dimensions without coordinates: t_dim, id_dim
Data variables:
    time                     (t_dim) datetime64[ns] 2007-01-01 ... 2007-01-30...
    peak_count_ntr           (id_dim, threshold) float64 40.0 40.0 ... 2.0 1.0
    time_over_threshold_ntr  (id_dim, threshold) float64 720.0 720.0 ... 5.0 4.0
    dailymax_count_ntr       (id_dim, threshold) float64 30.0 30.0 ... 2.0 1.0
    monthlymax_count_ntr     (id_dim, threshold) float64 1.0 1.0 1.0 ... 1.0 1.0</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-e24a4f5a-8980-413a-ad9d-fab485aa5c30' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-e24a4f5a-8980-413a-ad9d-fab485aa5c30' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>t_dim</span>: 720</li><li><span>id_dim</span>: 61</li><li><span class='xr-has-index'>threshold</span>: 40</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-788f9257-b787-4841-a77c-e0a143207fd2' class='xr-section-summary-in' type='checkbox'  checked><label for='section-788f9257-b787-4841-a77c-e0a143207fd2' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>51.95 51.57 57.9 ... 51.53 53.87</div><input id='attrs-dbcda537-a5fc-4559-9e82-edc8480cdb2b' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-dbcda537-a5fc-4559-9e82-edc8480cdb2b' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-655adeb8-4190-422c-9cbb-021273b3a0ff' class='xr-var-data-in' type='checkbox'><label for='data-655adeb8-4190-422c-9cbb-021273b3a0ff' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([51.94798   , 51.57      , 57.89525   , 51.7064    , 54.03167   ,
       51.21525   , 58.45661   , 58.44097   , 55.00744   , 51.95675   ,
       53.31394   , 52.93436   , 56.62311   , 50.6085    , 53.33167   ,
       50.36839   , 51.44564   , 54.49008   , 50.103     , 54.84256   ,
       55.00744   , 57.14406   , 60.15403   , 51.55      , 50.71433   ,
       49.91847   , 53.44969   , 55.62742   , 53.63103   , 50.78178   ,
       57.5987    , 51.11439   , 51.51089   , 49.18333   , 55.00744   ,
       54.65081   , 55.00744   , 51.50002   , 55.98983   , 52.473     ,
       52.01378   , 54.66475   , 51.21525   , 50.80256   , 58.20711   ,
       55.74964   , 54.08539   , 55.20678   , 51.50002   , 55.00744   ,
       52.71906   , 51.21097   , 55.00744   , 58.34999847, 57.68299866,
       61.93299866, 64.86699677, 55.36700058, 58.        , 51.53300095,
       53.86700058])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>site_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>object</div><div class='xr-var-preview xr-preview'>&#x27;Harwich&#x27; &#x27;Mumbles&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;</div><input id='attrs-385df0d5-34f4-4aa9-a291-8b897bb3260d' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-385df0d5-34f4-4aa9-a291-8b897bb3260d' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-13209330-da90-43da-91d1-8c1ffe5d03cd' class='xr-var-data-in' type='checkbox'><label for='data-13209330-da90-43da-91d1-8c1ffe5d03cd' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Harwich&#x27;, &#x27;Mumbles&#x27;, &#x27;Ullapool&#x27;, &#x27;Milford Haven&#x27;, &#x27;Heysham&#x27;,
       &#x27;Hinkley Point&#x27;, &#x27;Kinlochbervie&#x27;, &#x27;Wick&#x27;, &#x27;North Shields&#x27;,
       &#x27;Felixstowe&#x27;, &#x27;Holyhead&#x27;, &#x27;Cromer&#x27;, &#x27;Tobermory&#x27;, &#x27;Weymouth&#x27;,
       &#x27;Llandudno&#x27;, &#x27;Devonport&#x27;, &#x27;Sheerness&#x27;, &#x27;Whitby&#x27;, &#x27;Newlyn&#x27;,
       &#x27;Portpatrick&#x27;, &#x27;North Shields&#x27;, &#x27;Aberdeen&#x27;, &#x27;Lerwick&#x27;, &#x27;Newport&#x27;,
       &#x27;Bournemouth&#x27;, &quot;St. Mary&#x27;s&quot;, &#x27;Liverpool, Gladstone Dock&#x27;,
       &#x27;Port Ellen (Islay)&#x27;, &#x27;Immingham&#x27;, &#x27;Newhaven&#x27;, &#x27;Moray Firth&#x27;,
       &#x27;Dover&#x27;, &#x27;Avonmouth&#x27;, &#x27;St. Helier (Jersey)&#x27;, &#x27;North Shields&#x27;,
       &#x27;Workington&#x27;, &#x27;North Shields&#x27;, &#x27;Portbury&#x27;, &#x27;Leith&#x27;, &#x27;Lowestoft&#x27;,
       &#x27;Fishguard&#x27;, &#x27;Bangor&#x27;, &#x27;Hinkley Point&#x27;, &#x27;Portsmouth&#x27;, &#x27;Stornoway&#x27;,
       &#x27;Millport&#x27;, &#x27;Port Erin&#x27;, &#x27;Portrush&#x27;, &#x27;Portbury&#x27;, &#x27;North Shields&#x27;,
       &#x27;Barmouth&#x27;, &#x27;Ilfracombe&#x27;, &#x27;North Shields&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;,
       &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;], dtype=object)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.292 -3.975 -5.158 ... 350.8 8.717</div><input id='attrs-bd5f29bc-b77b-404e-a93e-148c01cc7148' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-bd5f29bc-b77b-404e-a93e-148c01cc7148' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ef38c9d8-6454-4cad-b363-1d9092ed6e70' class='xr-var-data-in' type='checkbox'><label for='data-ef38c9d8-6454-4cad-b363-1d9092ed6e70' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 1.29210000e+00, -3.97544000e+00, -5.15789000e+00, -5.05148000e+00,
       -2.92042000e+00, -3.13433000e+00, -5.05036000e+00, -3.08631000e+00,
       -1.43978000e+00,  1.34839000e+00, -4.62044000e+00,  1.30164000e+00,
       -6.06422000e+00, -2.44794000e+00, -3.82522000e+00, -4.18525000e+00,
        7.43440000e-01, -6.14170000e-01, -5.54283000e+00, -5.12003000e+00,
       -1.43978000e+00, -2.08013000e+00, -1.14031000e+00, -2.98744000e+00,
       -1.87486000e+00, -6.31642000e+00, -3.01800000e+00, -6.19006000e+00,
       -1.86030000e-01,  5.70300000e-02, -4.00220000e+00,  1.32267000e+00,
       -2.71497000e+00, -2.11667000e+00, -1.43978000e+00, -3.56764000e+00,
       -1.43978000e+00, -2.72848000e+00, -3.18169000e+00,  1.75083000e+00,
       -4.98333000e+00, -5.66947000e+00, -3.13433000e+00, -1.11175000e+00,
       -6.38889000e+00, -4.90583000e+00, -4.76806000e+00, -6.65683000e+00,
       -2.72848000e+00, -1.43978000e+00, -4.04517000e+00, -4.11094000e+00,
       -1.43978000e+00,  1.12150002e+01,  1.18000002e+01,  5.11700010e+00,
        1.12500000e+01,  3.52666992e+02,  7.56699991e+00,  3.50816986e+02,
        8.71700001e+00])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span class='xr-has-index'>threshold</span></div><div class='xr-var-dims'>(threshold)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>-2.0 -1.9 -1.8 -1.7 ... 1.7 1.8 1.9</div><input id='attrs-839656d0-fb1f-4ab6-8012-458362cdfe4c' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-839656d0-fb1f-4ab6-8012-458362cdfe4c' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-98f2cc2d-0c95-4c88-ae0e-d42cd5d45e26' class='xr-var-data-in' type='checkbox'><label for='data-98f2cc2d-0c95-4c88-ae0e-d42cd5d45e26' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([-2.000000e+00, -1.900000e+00, -1.800000e+00, -1.700000e+00,
       -1.600000e+00, -1.500000e+00, -1.400000e+00, -1.300000e+00,
       -1.200000e+00, -1.100000e+00, -1.000000e+00, -9.000000e-01,
       -8.000000e-01, -7.000000e-01, -6.000000e-01, -5.000000e-01,
       -4.000000e-01, -3.000000e-01, -2.000000e-01, -1.000000e-01,
        1.776357e-15,  1.000000e-01,  2.000000e-01,  3.000000e-01,
        4.000000e-01,  5.000000e-01,  6.000000e-01,  7.000000e-01,
        8.000000e-01,  9.000000e-01,  1.000000e+00,  1.100000e+00,
        1.200000e+00,  1.300000e+00,  1.400000e+00,  1.500000e+00,
        1.600000e+00,  1.700000e+00,  1.800000e+00,  1.900000e+00])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-12320475-8be1-477d-b275-02e175e2e526' class='xr-section-summary-in' type='checkbox'  checked><label for='section-12320475-8be1-477d-b275-02e175e2e526' class='xr-section-summary' >Data variables: <span>(5)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-01 ... 2007-01-30T23:00:00</div><input id='attrs-976302fe-f20c-4f5f-a8ee-e4ff4a4f4be0' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-976302fe-f20c-4f5f-a8ee-e4ff4a4f4be0' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-6c1f27bd-7c85-4aca-99d7-1c53fdce8b6e' class='xr-var-data-in' type='checkbox'><label for='data-6c1f27bd-7c85-4aca-99d7-1c53fdce8b6e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-01T00:00:00.000000000&#x27;, &#x27;2007-01-01T01:00:00.000000000&#x27;,
       &#x27;2007-01-01T02:00:00.000000000&#x27;, &#x27;2007-01-01T03:00:00.000000000&#x27;,
       &#x27;2007-01-01T04:00:00.000000000&#x27;, &#x27;2007-01-01T05:00:00.000000000&#x27;,
       &#x27;2007-01-01T06:00:00.000000000&#x27;, &#x27;2007-01-01T07:00:00.000000000&#x27;,
       &#x27;2007-01-01T08:00:00.000000000&#x27;, &#x27;2007-01-01T09:00:00.000000000&#x27;,
       &#x27;2007-01-01T10:00:00.000000000&#x27;, &#x27;2007-01-01T11:00:00.000000000&#x27;,
       &#x27;2007-01-01T12:00:00.000000000&#x27;, &#x27;2007-01-01T13:00:00.000000000&#x27;,
       &#x27;2007-01-01T14:00:00.000000000&#x27;, &#x27;2007-01-01T15:00:00.000000000&#x27;,
       &#x27;2007-01-01T16:00:00.000000000&#x27;, &#x27;2007-01-01T17:00:00.000000000&#x27;,
       &#x27;2007-01-01T18:00:00.000000000&#x27;, &#x27;2007-01-01T19:00:00.000000000&#x27;,
       &#x27;2007-01-01T20:00:00.000000000&#x27;, &#x27;2007-01-01T21:00:00.000000000&#x27;,
       &#x27;2007-01-01T22:00:00.000000000&#x27;, &#x27;2007-01-01T23:00:00.000000000&#x27;,
       &#x27;2007-01-02T00:00:00.000000000&#x27;, &#x27;2007-01-02T01:00:00.000000000&#x27;,
       &#x27;2007-01-02T02:00:00.000000000&#x27;, &#x27;2007-01-02T03:00:00.000000000&#x27;,
       &#x27;2007-01-02T04:00:00.000000000&#x27;, &#x27;2007-01-02T05:00:00.000000000&#x27;,
       &#x27;2007-01-02T06:00:00.000000000&#x27;, &#x27;2007-01-02T07:00:00.000000000&#x27;,
       &#x27;2007-01-02T08:00:00.000000000&#x27;, &#x27;2007-01-02T09:00:00.000000000&#x27;,
       &#x27;2007-01-02T10:00:00.000000000&#x27;, &#x27;2007-01-02T11:00:00.000000000&#x27;,
       &#x27;2007-01-02T12:00:00.000000000&#x27;, &#x27;2007-01-02T13:00:00.000000000&#x27;,
       &#x27;2007-01-02T14:00:00.000000000&#x27;, &#x27;2007-01-02T15:00:00.000000000&#x27;,
...
       &#x27;2007-01-29T10:00:00.000000000&#x27;, &#x27;2007-01-29T11:00:00.000000000&#x27;,
       &#x27;2007-01-29T12:00:00.000000000&#x27;, &#x27;2007-01-29T13:00:00.000000000&#x27;,
       &#x27;2007-01-29T14:00:00.000000000&#x27;, &#x27;2007-01-29T15:00:00.000000000&#x27;,
       &#x27;2007-01-29T16:00:00.000000000&#x27;, &#x27;2007-01-29T17:00:00.000000000&#x27;,
       &#x27;2007-01-29T18:00:00.000000000&#x27;, &#x27;2007-01-29T19:00:00.000000000&#x27;,
       &#x27;2007-01-29T20:00:00.000000000&#x27;, &#x27;2007-01-29T21:00:00.000000000&#x27;,
       &#x27;2007-01-29T22:00:00.000000000&#x27;, &#x27;2007-01-29T23:00:00.000000000&#x27;,
       &#x27;2007-01-30T00:00:00.000000000&#x27;, &#x27;2007-01-30T01:00:00.000000000&#x27;,
       &#x27;2007-01-30T02:00:00.000000000&#x27;, &#x27;2007-01-30T03:00:00.000000000&#x27;,
       &#x27;2007-01-30T04:00:00.000000000&#x27;, &#x27;2007-01-30T05:00:00.000000000&#x27;,
       &#x27;2007-01-30T06:00:00.000000000&#x27;, &#x27;2007-01-30T07:00:00.000000000&#x27;,
       &#x27;2007-01-30T08:00:00.000000000&#x27;, &#x27;2007-01-30T09:00:00.000000000&#x27;,
       &#x27;2007-01-30T10:00:00.000000000&#x27;, &#x27;2007-01-30T11:00:00.000000000&#x27;,
       &#x27;2007-01-30T12:00:00.000000000&#x27;, &#x27;2007-01-30T13:00:00.000000000&#x27;,
       &#x27;2007-01-30T14:00:00.000000000&#x27;, &#x27;2007-01-30T15:00:00.000000000&#x27;,
       &#x27;2007-01-30T16:00:00.000000000&#x27;, &#x27;2007-01-30T17:00:00.000000000&#x27;,
       &#x27;2007-01-30T18:00:00.000000000&#x27;, &#x27;2007-01-30T19:00:00.000000000&#x27;,
       &#x27;2007-01-30T20:00:00.000000000&#x27;, &#x27;2007-01-30T21:00:00.000000000&#x27;,
       &#x27;2007-01-30T22:00:00.000000000&#x27;, &#x27;2007-01-30T23:00:00.000000000&#x27;],
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>peak_count_ntr</span></div><div class='xr-var-dims'>(id_dim, threshold)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>40.0 40.0 40.0 40.0 ... 2.0 2.0 1.0</div><input id='attrs-d9bf96d6-d649-42d0-aea7-61fa236b116e' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-d9bf96d6-d649-42d0-aea7-61fa236b116e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-574d3f75-f60d-44ca-abad-9637ab4f9a3c' class='xr-var-data-in' type='checkbox'><label for='data-574d3f75-f60d-44ca-abad-9637ab4f9a3c' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[40., 40., 40., ...,  0.,  0.,  0.],
       [22., 22., 22., ...,  0.,  0.,  0.],
       [35., 35., 35., ...,  0.,  0.,  0.],
       ...,
       [39., 39., 39., ...,  0.,  0.,  0.],
       [42., 42., 42., ...,  0.,  0.,  0.],
       [38., 38., 38., ...,  2.,  2.,  1.]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>time_over_threshold_ntr</span></div><div class='xr-var-dims'>(id_dim, threshold)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>720.0 720.0 720.0 ... 8.0 5.0 4.0</div><input id='attrs-e7a83ffd-d2db-46f1-8abb-e9a6cb785ecc' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e7a83ffd-d2db-46f1-8abb-e9a6cb785ecc' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-2064ce9d-4ff8-4526-a230-a86ab87e5173' class='xr-var-data-in' type='checkbox'><label for='data-2064ce9d-4ff8-4526-a230-a86ab87e5173' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[720., 720., 720., ...,   0.,   0.,   0.],
       [720., 720., 720., ...,   0.,   0.,   0.],
       [720., 720., 720., ...,   0.,   0.,   0.],
       ...,
       [720., 720., 720., ...,   0.,   0.,   0.],
       [720., 720., 720., ...,   0.,   0.,   0.],
       [720., 720., 720., ...,   8.,   5.,   4.]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>dailymax_count_ntr</span></div><div class='xr-var-dims'>(id_dim, threshold)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>30.0 30.0 30.0 30.0 ... 3.0 2.0 1.0</div><input id='attrs-296b3075-7714-46ae-8608-c3fc646e99a0' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-296b3075-7714-46ae-8608-c3fc646e99a0' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-d5185efc-b835-487d-a8a3-053fcd0f5727' class='xr-var-data-in' type='checkbox'><label for='data-d5185efc-b835-487d-a8a3-053fcd0f5727' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[30., 30., 30., ...,  0.,  0.,  0.],
       [30., 30., 30., ...,  0.,  0.,  0.],
       [30., 30., 30., ...,  0.,  0.,  0.],
       ...,
       [30., 30., 30., ...,  0.,  0.,  0.],
       [30., 30., 30., ...,  0.,  0.,  0.],
       [30., 30., 30., ...,  3.,  2.,  1.]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>monthlymax_count_ntr</span></div><div class='xr-var-dims'>(id_dim, threshold)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.0 1.0 1.0 1.0 ... 1.0 1.0 1.0 1.0</div><input id='attrs-67b79354-eacc-4f2d-b4f4-c192d38dc108' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-67b79354-eacc-4f2d-b4f4-c192d38dc108' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-474c3fc8-4fd1-4fc5-9bc2-6dc113475b34' class='xr-var-data-in' type='checkbox'><label for='data-474c3fc8-4fd1-4fc5-9bc2-6dc113475b34' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[1., 1., 1., ..., 0., 0., 0.],
       [1., 1., 1., ..., 0., 0., 0.],
       [1., 1., 1., ..., 0., 0., 0.],
       ...,
       [1., 1., 1., ..., 0., 0., 0.],
       [1., 1., 1., ..., 0., 0., 0.],
       [1., 1., 1., ..., 1., 1., 1.]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-49a1ca24-383b-4a0f-9361-98d4eccffa5c' class='xr-section-summary-in' type='checkbox'  ><label for='section-49a1ca24-383b-4a0f-9361-98d4eccffa5c' class='xr-section-summary' >Indexes: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-index-name'><div>threshold</div></div><div class='xr-index-preview'>PandasIndex</div><div></div><input id='index-111ad2ae-bc84-4b7e-9d83-7778e8fe0e5b' class='xr-index-data-in' type='checkbox'/><label for='index-111ad2ae-bc84-4b7e-9d83-7778e8fe0e5b' title='Show/Hide index repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-index-data'><pre>PandasIndex(Float64Index([                  -2.0,                   -1.9,
                 -1.7999999999999998,    -1.6999999999999997,
                 -1.5999999999999996,    -1.4999999999999996,
                 -1.3999999999999995,    -1.2999999999999994,
                 -1.1999999999999993,    -1.0999999999999992,
                 -0.9999999999999991,     -0.899999999999999,
                 -0.7999999999999989,    -0.6999999999999988,
                 -0.5999999999999988,   -0.49999999999999867,
                 -0.3999999999999986,    -0.2999999999999985,
                 -0.1999999999999984,   -0.09999999999999831,
              1.7763568394002505e-15,    0.10000000000000187,
                 0.20000000000000195,    0.30000000000000204,
                 0.40000000000000213,     0.5000000000000022,
                  0.6000000000000023,     0.7000000000000024,
                  0.8000000000000025,     0.9000000000000026,
                  1.0000000000000027,     1.1000000000000028,
                  1.2000000000000028,      1.300000000000003,
                   1.400000000000003,      1.500000000000003,
                  1.6000000000000032,     1.7000000000000033,
                  1.8000000000000034,     1.9000000000000035],
             dtype=&#x27;float64&#x27;, name=&#x27;threshold&#x27;))</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-cbae4365-f115-4196-a7c2-04f2b87a2e38' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-cbae4365-f115-4196-a7c2-04f2b87a2e38' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>




```python
plt.plot( thresh_obs.threshold, thresh_obs.peak_count_ntr.mean(dim='id_dim') )
#plt.ylim([0,15])
plt.title(f"Observed peaks over threshold")
plt.xlabel('Analysis threshold (m)')
plt.ylabel('event count')
```




    Text(0, 0.5, 'event count')




    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_63_1.png)
    


Note that the non-tidal residual is a noisy timeseries (computed as a difference between two timeseries) so peaks do not necessarily correspond to peaks in total water level. For this reason `time_over_threshold_*` can be useful. Below we see that about 28% (y-axis) of the observations of non-tidal residual exceed 20cm (x-axis). Again, threshold statistics are more useful with a longer record.


```python
normalised_event_count = 100 * thresh_obs.time_over_threshold_ntr.isel(id_dim=stn_id) / thresh_obs.time_over_threshold_ntr.isel(id_dim=stn_id).max()

plt.plot( thresh_obs.threshold, normalised_event_count )
plt.ylim([20,40])
plt.xlim([0.0,0.4])
plt.title(f"time over threshold")
plt.xlabel('Analysis threshold (m)')
plt.ylabel('normalised event count (%)')
plt.plot(thresh_obs.threshold[22], normalised_event_count[22], 'r+', markersize=20)
```




    [<matplotlib.lines.Line2D at 0x7fa3fe7de820>]




    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_65_1.png)
    



## Other TidegaugeAnalysis methods 

### Calculate errors

The difference() routine will calculate differences, absolute_differences and squared differenced for all variables. Corresponding new variables are created with names `diff_*`, `abs_diff_*` and `square_diff_*`


```python
ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)

# Take a look
ntr_diff.dataset
```

    Tidegauge object at 0x55faea1b3fc0 initialised
    Tidegauge object at 0x55faea1b3fc0 initialised





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
body[data-theme=dark],
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

.xr-index-preview {
  grid-column: 2 / 5;
  color: var(--xr-font-color2);
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
.xr-var-data,
.xr-index-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data,
.xr-index-data-in:checked ~ .xr-index-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-index-name div,
.xr-index-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data,
.xr-index-data {
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
.xr-icon-file-text2,
.xr-no-icon {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:          (t_dim: 720, id_dim: 61)
Coordinates:
  * time             (t_dim) datetime64[ns] 2007-01-01 ... 2007-01-30T23:00:00
    site_name        (id_dim) object &#x27;Harwich&#x27; &#x27;Mumbles&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;
    longitude        (id_dim) float64 1.292 -3.975 -5.158 ... 7.567 350.8 8.717
    latitude         (id_dim) float64 51.95 51.57 57.9 ... 58.0 51.53 53.87
Dimensions without coordinates: t_dim, id_dim
Data variables:
    diff_ntr         (id_dim, t_dim) float64 nan nan nan ... 0.05885 0.3435
    abs_diff_ntr     (id_dim, t_dim) float64 nan nan nan ... 0.05885 0.3435
    square_diff_ntr  (id_dim, t_dim) float64 nan nan nan ... 0.003464 0.118</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-c7f23bb6-f785-4f7e-9063-c74f294a4711' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-c7f23bb6-f785-4f7e-9063-c74f294a4711' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span class='xr-has-index'>t_dim</span>: 720</li><li><span>id_dim</span>: 61</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-9f824ba7-c8d2-4d56-92a7-41863945d2d7' class='xr-section-summary-in' type='checkbox'  checked><label for='section-9f824ba7-c8d2-4d56-92a7-41863945d2d7' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span class='xr-has-index'>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-01 ... 2007-01-30T23:00:00</div><input id='attrs-e0ce9ee4-7978-4b2a-ad04-3f3c2dadc0ea' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e0ce9ee4-7978-4b2a-ad04-3f3c2dadc0ea' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-e30f73c7-4a61-4b3d-805d-f5791bb50789' class='xr-var-data-in' type='checkbox'><label for='data-e30f73c7-4a61-4b3d-805d-f5791bb50789' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-01T00:00:00.000000000&#x27;, &#x27;2007-01-01T01:00:00.000000000&#x27;,
       &#x27;2007-01-01T02:00:00.000000000&#x27;, ..., &#x27;2007-01-30T21:00:00.000000000&#x27;,
       &#x27;2007-01-30T22:00:00.000000000&#x27;, &#x27;2007-01-30T23:00:00.000000000&#x27;],
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>site_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>object</div><div class='xr-var-preview xr-preview'>&#x27;Harwich&#x27; &#x27;Mumbles&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;</div><input id='attrs-8d4f9fd3-26c9-43b5-b16c-89ef21fef96c' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-8d4f9fd3-26c9-43b5-b16c-89ef21fef96c' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-1dff96e3-783a-4e14-9317-458558a49ea2' class='xr-var-data-in' type='checkbox'><label for='data-1dff96e3-783a-4e14-9317-458558a49ea2' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Harwich&#x27;, &#x27;Mumbles&#x27;, &#x27;Ullapool&#x27;, &#x27;Milford Haven&#x27;, &#x27;Heysham&#x27;,
       &#x27;Hinkley Point&#x27;, &#x27;Kinlochbervie&#x27;, &#x27;Wick&#x27;, &#x27;North Shields&#x27;,
       &#x27;Felixstowe&#x27;, &#x27;Holyhead&#x27;, &#x27;Cromer&#x27;, &#x27;Tobermory&#x27;, &#x27;Weymouth&#x27;,
       &#x27;Llandudno&#x27;, &#x27;Devonport&#x27;, &#x27;Sheerness&#x27;, &#x27;Whitby&#x27;, &#x27;Newlyn&#x27;,
       &#x27;Portpatrick&#x27;, &#x27;North Shields&#x27;, &#x27;Aberdeen&#x27;, &#x27;Lerwick&#x27;, &#x27;Newport&#x27;,
       &#x27;Bournemouth&#x27;, &quot;St. Mary&#x27;s&quot;, &#x27;Liverpool, Gladstone Dock&#x27;,
       &#x27;Port Ellen (Islay)&#x27;, &#x27;Immingham&#x27;, &#x27;Newhaven&#x27;, &#x27;Moray Firth&#x27;,
       &#x27;Dover&#x27;, &#x27;Avonmouth&#x27;, &#x27;St. Helier (Jersey)&#x27;, &#x27;North Shields&#x27;,
       &#x27;Workington&#x27;, &#x27;North Shields&#x27;, &#x27;Portbury&#x27;, &#x27;Leith&#x27;, &#x27;Lowestoft&#x27;,
       &#x27;Fishguard&#x27;, &#x27;Bangor&#x27;, &#x27;Hinkley Point&#x27;, &#x27;Portsmouth&#x27;, &#x27;Stornoway&#x27;,
       &#x27;Millport&#x27;, &#x27;Port Erin&#x27;, &#x27;Portrush&#x27;, &#x27;Portbury&#x27;, &#x27;North Shields&#x27;,
       &#x27;Barmouth&#x27;, &#x27;Ilfracombe&#x27;, &#x27;North Shields&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;,
       &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;], dtype=object)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.292 -3.975 -5.158 ... 350.8 8.717</div><input id='attrs-e2eab099-1b27-451c-9e9f-c802520de36a' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e2eab099-1b27-451c-9e9f-c802520de36a' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-c8941474-bfd4-4c68-9c05-9eca708c75b6' class='xr-var-data-in' type='checkbox'><label for='data-c8941474-bfd4-4c68-9c05-9eca708c75b6' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 1.29210000e+00, -3.97544000e+00, -5.15789000e+00, -5.05148000e+00,
       -2.92042000e+00, -3.13433000e+00, -5.05036000e+00, -3.08631000e+00,
       -1.43978000e+00,  1.34839000e+00, -4.62044000e+00,  1.30164000e+00,
       -6.06422000e+00, -2.44794000e+00, -3.82522000e+00, -4.18525000e+00,
        7.43440000e-01, -6.14170000e-01, -5.54283000e+00, -5.12003000e+00,
       -1.43978000e+00, -2.08013000e+00, -1.14031000e+00, -2.98744000e+00,
       -1.87486000e+00, -6.31642000e+00, -3.01800000e+00, -6.19006000e+00,
       -1.86030000e-01,  5.70300000e-02, -4.00220000e+00,  1.32267000e+00,
       -2.71497000e+00, -2.11667000e+00, -1.43978000e+00, -3.56764000e+00,
       -1.43978000e+00, -2.72848000e+00, -3.18169000e+00,  1.75083000e+00,
       -4.98333000e+00, -5.66947000e+00, -3.13433000e+00, -1.11175000e+00,
       -6.38889000e+00, -4.90583000e+00, -4.76806000e+00, -6.65683000e+00,
       -2.72848000e+00, -1.43978000e+00, -4.04517000e+00, -4.11094000e+00,
       -1.43978000e+00,  1.12150002e+01,  1.18000002e+01,  5.11700010e+00,
        1.12500000e+01,  3.52666992e+02,  7.56699991e+00,  3.50816986e+02,
        8.71700001e+00])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>51.95 51.57 57.9 ... 51.53 53.87</div><input id='attrs-5603aae8-c630-4a99-9ffc-4f509a6a47c7' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-5603aae8-c630-4a99-9ffc-4f509a6a47c7' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-064de7e5-513a-48d6-84a1-252e860f98ef' class='xr-var-data-in' type='checkbox'><label for='data-064de7e5-513a-48d6-84a1-252e860f98ef' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([51.94798   , 51.57      , 57.89525   , 51.7064    , 54.03167   ,
       51.21525   , 58.45661   , 58.44097   , 55.00744   , 51.95675   ,
       53.31394   , 52.93436   , 56.62311   , 50.6085    , 53.33167   ,
       50.36839   , 51.44564   , 54.49008   , 50.103     , 54.84256   ,
       55.00744   , 57.14406   , 60.15403   , 51.55      , 50.71433   ,
       49.91847   , 53.44969   , 55.62742   , 53.63103   , 50.78178   ,
       57.5987    , 51.11439   , 51.51089   , 49.18333   , 55.00744   ,
       54.65081   , 55.00744   , 51.50002   , 55.98983   , 52.473     ,
       52.01378   , 54.66475   , 51.21525   , 50.80256   , 58.20711   ,
       55.74964   , 54.08539   , 55.20678   , 51.50002   , 55.00744   ,
       52.71906   , 51.21097   , 55.00744   , 58.34999847, 57.68299866,
       61.93299866, 64.86699677, 55.36700058, 58.        , 51.53300095,
       53.86700058])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-99195c21-0be9-4932-b189-579d80289dd8' class='xr-section-summary-in' type='checkbox'  checked><label for='section-99195c21-0be9-4932-b189-579d80289dd8' class='xr-section-summary' >Data variables: <span>(3)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>diff_ntr</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan ... 0.05885 0.3435</div><input id='attrs-1db36a30-1286-41b5-b19a-e99c14ab1ab4' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-1db36a30-1286-41b5-b19a-e99c14ab1ab4' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-2b5b6677-bc99-462f-b930-d00471fb348a' class='xr-var-data-in' type='checkbox'><label for='data-2b5b6677-bc99-462f-b930-d00471fb348a' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[        nan,         nan,         nan, ..., -0.32699312,
        -0.12564265,  0.13424107],
       [        nan,         nan,         nan, ...,         nan,
                nan,         nan],
       [        nan,         nan,         nan, ...,  0.27731735,
         0.3287257 ,  0.39544093],
       ...,
       [        nan,         nan,         nan, ..., -0.13998686,
        -0.18434602, -0.23884966],
       [        nan,         nan,         nan, ...,  0.09161719,
         0.03131287, -0.05355329],
       [        nan,         nan,         nan, ..., -0.16968976,
         0.05885439,  0.34348952]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>abs_diff_ntr</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan ... 0.05885 0.3435</div><input id='attrs-e72798ab-e55c-40a8-9915-5c337e485968' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e72798ab-e55c-40a8-9915-5c337e485968' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-323cd0b5-588d-426a-a560-d49a0225fa82' class='xr-var-data-in' type='checkbox'><label for='data-323cd0b5-588d-426a-a560-d49a0225fa82' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[       nan,        nan,        nan, ..., 0.32699312, 0.12564265,
        0.13424107],
       [       nan,        nan,        nan, ...,        nan,        nan,
               nan],
       [       nan,        nan,        nan, ..., 0.27731735, 0.3287257 ,
        0.39544093],
       ...,
       [       nan,        nan,        nan, ..., 0.13998686, 0.18434602,
        0.23884966],
       [       nan,        nan,        nan, ..., 0.09161719, 0.03131287,
        0.05355329],
       [       nan,        nan,        nan, ..., 0.16968976, 0.05885439,
        0.34348952]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>square_diff_ntr</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan ... 0.003464 0.118</div><input id='attrs-75ce9f2a-9ae6-422f-a10e-9d2d73e7428a' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-75ce9f2a-9ae6-422f-a10e-9d2d73e7428a' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-75324f0e-c176-4583-823f-27a8cf99edfc' class='xr-var-data-in' type='checkbox'><label for='data-75324f0e-c176-4583-823f-27a8cf99edfc' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[       nan,        nan,        nan, ..., 0.1069245 , 0.01578608,
        0.01802066],
       [       nan,        nan,        nan, ...,        nan,        nan,
               nan],
       [       nan,        nan,        nan, ..., 0.07690491, 0.10806059,
        0.15637353],
       ...,
       [       nan,        nan,        nan, ..., 0.01959632, 0.03398346,
        0.05704916],
       [       nan,        nan,        nan, ..., 0.00839371, 0.0009805 ,
        0.00286796],
       [       nan,        nan,        nan, ..., 0.02879461, 0.00346384,
        0.11798505]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-4077258a-75fc-41dc-958e-1827af64de20' class='xr-section-summary-in' type='checkbox'  ><label for='section-4077258a-75fc-41dc-958e-1827af64de20' class='xr-section-summary' >Indexes: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-index-name'><div>time</div></div><div class='xr-index-preview'>PandasIndex</div><div></div><input id='index-a297746b-91d7-48b3-a97e-ef13bb5acbf2' class='xr-index-data-in' type='checkbox'/><label for='index-a297746b-91d7-48b3-a97e-ef13bb5acbf2' title='Show/Hide index repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-index-data'><pre>PandasIndex(DatetimeIndex([&#x27;2007-01-01 00:00:00&#x27;, &#x27;2007-01-01 01:00:00&#x27;,
               &#x27;2007-01-01 02:00:00&#x27;, &#x27;2007-01-01 03:00:00&#x27;,
               &#x27;2007-01-01 04:00:00&#x27;, &#x27;2007-01-01 05:00:00&#x27;,
               &#x27;2007-01-01 06:00:00&#x27;, &#x27;2007-01-01 07:00:00&#x27;,
               &#x27;2007-01-01 08:00:00&#x27;, &#x27;2007-01-01 09:00:00&#x27;,
               ...
               &#x27;2007-01-30 14:00:00&#x27;, &#x27;2007-01-30 15:00:00&#x27;,
               &#x27;2007-01-30 16:00:00&#x27;, &#x27;2007-01-30 17:00:00&#x27;,
               &#x27;2007-01-30 18:00:00&#x27;, &#x27;2007-01-30 19:00:00&#x27;,
               &#x27;2007-01-30 20:00:00&#x27;, &#x27;2007-01-30 21:00:00&#x27;,
               &#x27;2007-01-30 22:00:00&#x27;, &#x27;2007-01-30 23:00:00&#x27;],
              dtype=&#x27;datetime64[ns]&#x27;, name=&#x27;time&#x27;, length=720, freq=None))</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-091db20b-4bef-4e8a-bab0-7bfc5b8734cb' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-091db20b-4bef-4e8a-bab0-7bfc5b8734cb' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



We can then easily get mean errors, MAE and MSE



```python
mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
```


```python

```
