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

    Tidegauge object at 0x563dc355e980 initialised


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
    qc_flags   (id_dim, t_dim) int64 1 1 1 1 1 1 1 1 1 1 ... 1 1 1 1 1 1 1 1 1 1</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-27789295-4480-48ae-9396-4c1ec67d1182' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-27789295-4480-48ae-9396-4c1ec67d1182' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>id_dim</span>: 1</li><li><span>t_dim</span>: 193</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-b095ff17-b759-4621-b3fd-6a30575b037b' class='xr-section-summary-in' type='checkbox'  checked><label for='section-b095ff17-b759-4621-b3fd-6a30575b037b' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-10 ... 2007-01-12</div><input id='attrs-4086b3c6-1996-419a-8206-9e08acf992bc' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-4086b3c6-1996-419a-8206-9e08acf992bc' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-02b7b875-7926-4b7c-9b61-bdfb2cf715bd' class='xr-var-data-in' type='checkbox'><label for='data-02b7b875-7926-4b7c-9b61-bdfb2cf715bd' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-10T00:00:00.000000000&#x27;, &#x27;2007-01-10T00:15:00.000000000&#x27;,
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
       &#x27;2007-01-12T00:00:00.000000000&#x27;], dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.751</div><input id='attrs-bf6e76e4-e968-458f-b246-8766775a55e9' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-bf6e76e4-e968-458f-b246-8766775a55e9' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-5fb7f167-a34e-43e8-bbb5-41e918541ff9' class='xr-var-data-in' type='checkbox'><label for='data-5fb7f167-a34e-43e8-bbb5-41e918541ff9' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([1.75083])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>52.47</div><input id='attrs-0867cc19-bef5-4853-9d0f-b68af7f00a27' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-0867cc19-bef5-4853-9d0f-b68af7f00a27' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-cea0f74e-b551-4085-aa51-f0f65d22e3fd' class='xr-var-data-in' type='checkbox'><label for='data-cea0f74e-b551-4085-aa51-f0f65d22e3fd' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([52.473])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>id_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>&lt;U9</div><div class='xr-var-preview xr-preview'>&#x27;Lowestoft&#x27;</div><input id='attrs-8496be85-d62a-47cc-8c40-d1933708d1b2' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-8496be85-d62a-47cc-8c40-d1933708d1b2' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-9779c66f-abdf-4d42-a65a-403423387a48' class='xr-var-data-in' type='checkbox'><label for='data-9779c66f-abdf-4d42-a65a-403423387a48' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Lowestoft&#x27;], dtype=&#x27;&lt;U9&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-f06d3c92-c961-4742-8b30-d7cc2154dcab' class='xr-section-summary-in' type='checkbox'  checked><label for='section-f06d3c92-c961-4742-8b30-d7cc2154dcab' class='xr-section-summary' >Data variables: <span>(2)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>ssh</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>2.818 2.823 2.871 ... 3.257 3.371</div><input id='attrs-cb7bac32-7d8b-418e-a0ec-4d84c654e214' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-cb7bac32-7d8b-418e-a0ec-4d84c654e214' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-339db666-7d8e-4837-907d-4d4e90973ece' class='xr-var-data-in' type='checkbox'><label for='data-339db666-7d8e-4837-907d-4d4e90973ece' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[ 2.818,  2.823,  2.871,  2.931,  2.961,  2.979,  2.953,  2.913,
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
         3.371]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>qc_flags</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>int64</div><div class='xr-var-preview xr-preview'>1 1 1 1 1 1 1 1 ... 1 1 1 1 1 1 1 1</div><input id='attrs-ff5194fb-7fd6-4a31-bc55-68dbccbe960e' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-ff5194fb-7fd6-4a31-bc55-68dbccbe960e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-151e146d-2c46-42fb-96f8-2a7f3a215211' class='xr-var-data-in' type='checkbox'><label for='data-151e146d-2c46-42fb-96f8-2a7f3a215211' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-b64879a3-d2a0-40ed-88af-b491bb9f6759' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-b64879a3-d2a0-40ed-88af-b491bb9f6759' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-b9e5f3b8-021a-42d5-b991-9424ab29c565' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-b9e5f3b8-021a-42d5-b991-9424ab29c565' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



An example data variable could be ssh, or ntr (non-tidal residual). This object can also be used for other instrument types, not just tide gauges. For example moorings.

Every id index for this object should use the same time coordinates. Therefore, timeseries need to be aligned before being placed into the object. If there is any padding needed, then NaNs should be used. NaNs should also be used for quality control/data rejection.


For the rest of our examples, we will use data from multiple tide gauges
on the same time dimension. It will be read in from a simple netCDF file:


```python
tt = xr.open_dataset(fn_tg)
obs = coast.Tidegauge(dataset=tt)
```

    Tidegauge object at 0x563dc355e980 initialised



```python
# Create the object and then inset the netcdf dataset
tt = xr.open_dataset(fn_tg)
obs = coast.Tidegauge(dataset=tt)
obs.dataset = obs.dataset.set_coords("time")
```

    Tidegauge object at 0x563dc355e980 initialised


## Quick plotting to visualise Tidegauge data

Tidegauge has ready made quick plotting routines for viewing time series and tide gauge location. To look at the tide gauge location:


```python
fig, ax = obs.plot_on_map()
```

    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/cartopy/io/__init__.py:241: DownloadWarning: Downloading: https://naturalearth.s3.amazonaws.com/50m_physical/ne_50m_coastline.zip
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
     <matplotlib.collections.PathCollection at 0x7f47379dfb80>)




    
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

    Tidegauge object at 0x563dc355e980 initialised
    Tidegauge object at 0x563dc355e980 initialised
    Tidegauge object at 0x563dc355e980 initialised



    
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

    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/dataset.py:278: UserWarning: The specified chunks separate the stored chunks along dimension "time_counter" starting at index 2. This could degrade performance. Instead, consider rechunking after loading.
      warnings.warn(


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
    Tidegauge object at 0x563dc355e980 initialised


However, the new `tidegauge_from_model` will the same number of time entries as the `obs` data, rather than the model data (so this will include lots of empty values). So, for a more useful demonstration we trim the observed gauge data so it better matches the model data.


```python
# Cut down data to be only in 2007 to match model data.
start_date = datetime.datetime(2007, 1, 1)
end_date = datetime.datetime(2007, 1, 31)
obs = obs.time_slice(start_date, end_date)
```

    Tidegauge object at 0x563dc355e980 initialised


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
    Tidegauge object at 0x563dc355e980 initialised





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
    NCO:          4.4.7</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-0dfda0ba-e2c4-43ec-ad5e-8bd340c00d6d' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-0dfda0ba-e2c4-43ec-ad5e-8bd340c00d6d' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>z_dim</span>: 51</li><li><span>axis_nbounds</span>: 2</li><li><span class='xr-has-index'>t_dim</span>: 720</li><li><span>id_dim</span>: 61</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-8cc158e5-3c7d-4b27-8297-8e509394e22f' class='xr-section-summary-in' type='checkbox'  checked><label for='section-8cc158e5-3c7d-4b27-8297-8e509394e22f' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>1.444 -4.0 -5.333 ... -9.111 8.777</div><input id='attrs-7916d861-2fcf-4e96-9282-1197f843b348' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-7916d861-2fcf-4e96-9282-1197f843b348' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-bd4ff534-eb3d-47fe-95e6-901292127d9c' class='xr-var-data-in' type='checkbox'><label for='data-bd4ff534-eb3d-47fe-95e6-901292127d9c' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 1.4443359 , -4.        , -5.333008  , -5.111328  , -3.        ,
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
        8.777344  ], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>51.93 51.53 58.0 ... 51.53 53.87</div><input id='attrs-b0b5cc1e-78ad-4df6-99ae-9f2509bd2df4' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-b0b5cc1e-78ad-4df6-99ae-9f2509bd2df4' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-bdef67ef-9f59-404a-9ba9-09f4702d6c73' class='xr-var-data-in' type='checkbox'><label for='data-bdef67ef-9f59-404a-9ba9-09f4702d6c73' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([51.933594, 51.53418 , 58.000977, 51.666992, 54.000977, 51.26758 ,
       58.467773, 58.467773, 55.067383, 51.933594, 53.333984, 52.933594,
       56.66797 , 50.600586, 53.333984, 50.333984, 51.53418 , 54.467773,
       50.067383, 54.80078 , 55.067383, 57.13379 , 60.20117 , 51.53418 ,
       50.666992, 49.933594, 53.467773, 55.600586, 53.600586, 50.7334  ,
       57.600586, 51.067383, 51.53418 , 49.13379 , 55.067383, 54.666992,
       55.067383, 51.53418 , 56.000977, 52.467773, 52.067383, 54.666992,
       51.26758 , 50.7334  , 58.13379 , 55.734375, 54.067383, 55.26758 ,
       51.53418 , 55.067383, 52.734375, 51.26758 , 55.067383, 58.333984,
       57.66797 , 61.93457 , 64.868164, 55.40039 , 58.000977, 51.53418 ,
       53.867188], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>depth</span></div><div class='xr-var-dims'>(z_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>0.1001 0.2183 ... 27.32 10.11</div><input id='attrs-cc806052-f037-41ce-870b-79e77ecfd565' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-cc806052-f037-41ce-870b-79e77ecfd565' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-0d43e2c5-b21f-43d8-9d07-cbfff76fa1c9' class='xr-var-data-in' type='checkbox'><label for='data-0d43e2c5-b21f-43d8-9d07-cbfff76fa1c9' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>m</dd><dt><span>standard_name :</span></dt><dd>Depth at time zero on the t-grid</dd></dl></div><div class='xr-var-data'><pre>array([[1.00097656e-01, 2.18261719e-01, 2.52929688e-01, ...,
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
        1.79002441e+02, 2.73212891e+01, 1.01098633e+01]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span class='xr-has-index'>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-01 ... 2007-01-30T23:00:00</div><input id='attrs-8314464d-91cd-4e50-8343-e4ac0c25916f' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-8314464d-91cd-4e50-8343-e4ac0c25916f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ea67450c-82f3-44a7-bcdd-912eef42876d' class='xr-var-data-in' type='checkbox'><label for='data-ea67450c-82f3-44a7-bcdd-912eef42876d' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>axis :</span></dt><dd>T</dd><dt><span>standard_name :</span></dt><dd>time</dd><dt><span>long_name :</span></dt><dd>Time axis</dd><dt><span>time_origin :</span></dt><dd>1900-01-01 00:00:00</dd><dt><span>bounds :</span></dt><dd>time_counter_bounds</dd></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-01T00:00:00.000000000&#x27;, &#x27;2007-01-01T01:00:00.000000000&#x27;,
       &#x27;2007-01-01T02:00:00.000000000&#x27;, ..., &#x27;2007-01-30T21:00:00.000000000&#x27;,
       &#x27;2007-01-30T22:00:00.000000000&#x27;, &#x27;2007-01-30T23:00:00.000000000&#x27;],
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-13bec1ca-8385-46d6-8393-73e9d0224a4b' class='xr-section-summary-in' type='checkbox'  checked><label for='section-13bec1ca-8385-46d6-8393-73e9d0224a4b' class='xr-section-summary' >Data variables: <span>(10)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>deptht_bounds</span></div><div class='xr-var-dims'>(z_dim, axis_nbounds)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>0.0 6.157 ... 5.72e+03 5.924e+03</div><input id='attrs-55c7ddd5-e2cd-4b72-b01a-27b6cc597a7f' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-55c7ddd5-e2cd-4b72-b01a-27b6cc597a7f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-b28c31e6-5617-48be-9f07-4dbbda074ab7' class='xr-var-data-in' type='checkbox'><label for='data-b28c31e6-5617-48be-9f07-4dbbda074ab7' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[   0.       ,    6.1572266],
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
       [5720.       , 5924.2705   ]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>ssh</span></div><div class='xr-var-dims'>(t_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>nan nan nan ... -0.0752 0.7412</div><input id='attrs-ffdc438e-03cd-4428-98b0-ca51c255e682' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-ffdc438e-03cd-4428-98b0-ca51c255e682' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-3fe97081-a1a5-47b8-af7e-bbbe10e9e581' class='xr-var-data-in' type='checkbox'><label for='data-3fe97081-a1a5-47b8-af7e-bbbe10e9e581' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>m</dd><dt><span>online_operation :</span></dt><dd>instant</dd><dt><span>interval_operation :</span></dt><dd>300 s</dd><dt><span>interval_write :</span></dt><dd>1 d</dd><dt><span>cell_methods :</span></dt><dd>time: point (interval: 300 s)</dd></dl></div><div class='xr-var-data'><pre>array([[        nan,         nan,         nan, ...,         nan,
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
        -0.07519531,  0.74121094]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>temperature</span></div><div class='xr-var-dims'>(t_dim, z_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-6a81c511-b877-4967-ad7f-39d0cdcd03ea' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-6a81c511-b877-4967-ad7f-39d0cdcd03ea' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-f7c2d18c-bbc3-4b7e-bb7e-c623f7ce0420' class='xr-var-data-in' type='checkbox'><label for='data-f7c2d18c-bbc3-4b7e-bb7e-c623f7ce0420' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>degC</dd><dt><span>online_operation :</span></dt><dd>instant</dd><dt><span>interval_operation :</span></dt><dd>300 s</dd><dt><span>interval_write :</span></dt><dd>1 d</dd><dt><span>cell_methods :</span></dt><dd>time: point (interval: 300 s)</dd></dl></div><div class='xr-var-data'><pre>array([[[      nan,       nan,       nan, ...,       nan,       nan,
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
               nan]]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>bathymetry</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>10.0 21.81 6.075 ... 14.06 10.0</div><input id='attrs-5b886228-3ed6-4769-9c91-d0bc122d1021' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-5b886228-3ed6-4769-9c91-d0bc122d1021' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-2c0a4df5-335e-4dab-a639-b0235ac8aaba' class='xr-var-data-in' type='checkbox'><label for='data-2c0a4df5-335e-4dab-a639-b0235ac8aaba' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>m</dd><dt><span>standard_name :</span></dt><dd>bathymetry</dd><dt><span>description :</span></dt><dd>depth of last wet w-level on the horizontal t-grid</dd></dl></div><div class='xr-var-data'><pre>array([10.       , 21.80957  ,  6.0751953, 15.558594 , 10.65625  ,
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
       10.       ], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>e1</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>7.618e+03 7.686e+03 ... 7.285e+03</div><input id='attrs-6e75e0b6-9182-4f8c-94f8-785997deb4c2' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-6e75e0b6-9182-4f8c-94f8-785997deb4c2' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ee798ab5-0a03-4ec8-ba7c-eb8b617ba572' class='xr-var-data-in' type='checkbox'><label for='data-ee798ab5-0a03-4ec8-ba7c-eb8b617ba572' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([7617.912 , 7685.6387, 6547.1533, 7663.1045, 7262.1484, 7730.582 ,
       6461.591 , 6461.591 , 7074.802 , 7617.912 , 7377.966 , 7446.9775,
       6789.205 , 7842.205 , 7377.966 , 7886.5586, 7685.6387, 7180.49  ,
       7930.74  , 7121.871 , 7074.802 , 6704.8984, 6140.08  , 7685.6387,
       7831.091 , 7952.7676, 7354.881 , 6980.205 , 7331.758 , 7819.965 ,
       6620.1465, 7764.1797, 7685.6387, 8084.0186, 7074.802 , 7145.3477,
       7074.802 , 7685.6387, 6908.8594, 7527.032 , 7595.254 , 7145.3477,
       7730.582 , 7819.965 , 6522.751 , 6956.461 , 7250.5117, 7039.3994,
       7685.6387, 7074.802 , 7481.3477, 7730.582 , 7074.802 , 6486.082 ,
       6608.004 , 5812.949 , 5247.382 , 7015.75  , 6547.1533, 7685.6387,
       7285.3906], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>e2</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>7.414e+03 7.414e+03 ... 7.414e+03</div><input id='attrs-75a13e65-8cad-4999-a412-74057c835c12' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-75a13e65-8cad-4999-a412-74057c835c12' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-e7cabe89-9857-4d9a-9b03-5de60e8934cb' class='xr-var-data-in' type='checkbox'><label for='data-e7cabe89-9857-4d9a-9b03-5de60e8934cb' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633, 7413.633, 7413.633, 7413.633, 7413.633, 7413.633,
       7413.633], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>e3_0</span></div><div class='xr-var-dims'>(z_dim, id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>0.2002 0.4365 ... 0.541 0.2002</div><input id='attrs-c861ce82-d32e-4834-a956-a52ef16bd021' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-c861ce82-d32e-4834-a956-a52ef16bd021' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-d281b804-5893-4d83-9745-3cd9ca0363be' class='xr-var-data-in' type='checkbox'><label for='data-d281b804-5893-4d83-9745-3cd9ca0363be' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[0.20019531, 0.43652344, 0.5058594 , ..., 1.        , 0.5410156 ,
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
        0.20019531]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>bottom_level</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>50.0 50.0 12.0 ... 17.0 26.0 50.0</div><input id='attrs-d71f1572-ccfd-4caa-90d6-79a6a4b72194' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-d71f1572-ccfd-4caa-90d6-79a6a4b72194' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-c3076a6c-13fa-4238-9114-bc77d4d03ac4' class='xr-var-data-in' type='checkbox'><label for='data-c3076a6c-13fa-4238-9114-bc77d4d03ac4' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([50., 50., 12., 32., 50., 50., 50., 50., 21., 50., 29., 42., 32.,
       42., 40., 33., 50., 25., 37., 32., 21., 50., 20., 50., 44., 24.,
       50., 24., 50., 43., 50., 50., 50., 34., 21., 50., 21., 50., 50.,
       33., 50., 11., 50., 50., 33., 45., 29., 39., 50., 21., 50., 50.,
       21., 19., 25., 25., 50., 44., 17., 26., 50.], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>landmask</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>bool</div><div class='xr-var-preview xr-preview'>False False False ... False False</div><input id='attrs-2a19e045-90f9-48fa-8592-466c72f0932f' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-2a19e045-90f9-48fa-8592-466c72f0932f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-86007150-cbec-45d6-b87d-4052f43655a7' class='xr-var-data-in' type='checkbox'><label for='data-86007150-cbec-45d6-b87d-4052f43655a7' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False, False, False,
       False, False, False, False, False, False, False])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>interp_dist</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>10.56 4.33 15.65 ... 4.96 3.957</div><input id='attrs-0d4f1af2-3bcb-4487-a2ae-076d2c9018a5' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-0d4f1af2-3bcb-4487-a2ae-076d2c9018a5' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-42b8f469-b747-489e-aea3-6c83b77ddaf2' class='xr-var-data-in' type='checkbox'><label for='data-42b8f469-b747-489e-aea3-6c83b77ddaf2' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([10.55753639,  4.3298596 , 15.65224834,  6.01847521,  6.21944535,
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
        3.9566329 ])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-5cb42f70-9487-4c34-89b7-2b065788cc5d' class='xr-section-summary-in' type='checkbox'  ><label for='section-5cb42f70-9487-4c34-89b7-2b065788cc5d' class='xr-section-summary' >Indexes: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-index-name'><div>time</div></div><div class='xr-index-preview'>PandasIndex</div><div></div><input id='index-9f21c26a-05a1-471b-98e7-60e18949672a' class='xr-index-data-in' type='checkbox'/><label for='index-9f21c26a-05a1-471b-98e7-60e18949672a' title='Show/Hide index repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-index-data'><pre>PandasIndex(DatetimeIndex([&#x27;2007-01-01 00:00:00&#x27;, &#x27;2007-01-01 01:00:00&#x27;,
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
              dtype=&#x27;datetime64[ns]&#x27;, name=&#x27;time&#x27;, length=720, freq=None))</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-054e33ee-d3e4-4032-8f1a-fed29b0087de' class='xr-section-summary-in' type='checkbox'  checked><label for='section-054e33ee-d3e4-4032-8f1a-fed29b0087de' class='xr-section-summary' >Attributes: <span>(8)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'><dt><span>name :</span></dt><dd>AMM7_1d_20070101_20070131_25hourm_grid_T</dd><dt><span>description :</span></dt><dd>ocean T grid variables, 25h meaned</dd><dt><span>title :</span></dt><dd>ocean T grid variables, 25h meaned</dd><dt><span>Conventions :</span></dt><dd>CF-1.6</dd><dt><span>timeStamp :</span></dt><dd>2019-Dec-26 04:35:28 GMT</dd><dt><span>uuid :</span></dt><dd>96cae459-d3a1-4f4f-b82b-9259179f95f7</dd><dt><span>history :</span></dt><dd>Tue May 19 12:07:51 2020: ncks -v votemper,sossheig -d time_counter,0,30,5 AMM7_1d_20070101_20070131_25hourm_grid_T.nc example_data.nc</dd><dt><span>NCO :</span></dt><dd>4.4.7</dd></dl></div></li></ul></div></div>




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

    Tidegauge object at 0x563dc355e980 initialised
    Tidegauge object at 0x563dc355e980 initialised


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

    Tidegauge object at 0x563dc355e980 initialised
    Tidegauge object at 0x563dc355e980 initialised



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



    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    Cell In[23], line 1
    ----> 1 tide_mod = tganalysis.reconstruct_tide_utide(model_new.dataset.time, ha_mod)
          2 tide_obs = tganalysis.reconstruct_tide_utide(obs_new.dataset.time, ha_obs)


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/coast/diagnostics/tidegauge_analysis.py:163, in TidegaugeAnalysis.reconstruct_tide_utide(cls, data_array, utide_solution_list, constit, output_name)
        161 ds_out = xr.Dataset(data_array.coords)
        162 ds_out[output_name] = (["id_dim", "t_dim"], reconstructed)
    --> 163 ds_out = ds_out.assign_coords(time=("t_dim", time.data))
        165 return Tidegauge(dataset=ds_out)


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/common.py:621, in DataWithCoords.assign_coords(self, coords, **coords_kwargs)
        618 else:
        619     results = self._calc_assign_results(coords_combined)
    --> 621 data.coords.update(results)
        622 return data


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/coordinates.py:552, in Coordinates.update(self, other)
        542     other_coords = create_coords_with_default_indexes(
        543         getattr(other, "variables", other)
        544     )
        546 # Discard original indexed coordinates prior to merge allows to:
        547 # - fail early if the new coordinates don't preserve the integrity of existing
        548 #   multi-coordinate indexes
        549 # - drop & replace coordinates without alignment (note: we must keep indexed
        550 #   coordinates extracted from the DataArray objects passed as values to
        551 #   `other` - if any - as those are still used for aligning the old/new coordinates)
    --> 552 coords_to_align = drop_indexed_coords(set(other_coords) & set(other), self)
        554 coords, indexes = merge_coords(
        555     [coords_to_align, other_coords],
        556     priority_arg=1,
        557     indexes=coords_to_align.xindexes,
        558 )
        560 # special case for PandasMultiIndex: updating only its dimension coordinate
        561 # is still allowed but depreciated.
        562 # It is the only case where we need to actually drop coordinates here (multi-index levels)
        563 # TODO: remove when removing PandasMultiIndex's dimension coordinate.


    File /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/xarray/core/coordinates.py:918, in drop_indexed_coords(coords_to_drop, coords)
        911         raise ValueError(
        912             f"cannot drop or update coordinate(s) {idx_drop_coords_str}, which would corrupt "
        913             f"the following index built from coordinates {idx_coords_str}:\n"
        914             f"{idx}"
        915         )
        917     for k in idx_drop_coords:
    --> 918         del new_variables[k]
        919         del new_indexes[k]
        921 return Coordinates._construct_direct(coords=new_variables, indexes=new_indexes)


    KeyError: 'time'


Get new TidegaugeMultiple objects containing non tidal residuals:


```python
ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed, apply_filter=False)
ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed, apply_filter=True, window_length=10, polyorder=2)

# Take a look
ntr_obs.dataset
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[24], line 1
    ----> 1 ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed, apply_filter=False)
          2 ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed, apply_filter=True, window_length=10, polyorder=2)
          4 # Take a look


    NameError: name 'tide_mod' is not defined


The dataset structure is preserved and has created a new variable called `ntr` - non-tidal residual.

By default, this routines will apply `scipy.signal.savgol_filter` to the non-tidal residuals
to remove some noise. This can be switched off using `apply_filter = False`.

The Doodson X0 filter is an alternative way of estimating non-tidal residuals. This will return a new Tidegauge() object containing filtered ssh data:


```python
dx0 = tganalysis.doodson_x0_filter(obs_new.dataset, "ssh")

# take a look
dx0.dataset

```

    Tidegauge object at 0x563dc355e980 initialised





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
    longitude  (id_dim) float64 1.292 -3.975 -5.158 -5.051 ... 7.567 350.8 8.717
    latitude   (id_dim) float64 51.95 51.57 57.9 51.71 ... 58.0 51.53 53.87
    site_name  (id_dim) object &#x27;Harwich&#x27; &#x27;Mumbles&#x27; &#x27;Ullapool&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;
Dimensions without coordinates: t_dim, id_dim
Data variables:
    time       (t_dim) datetime64[ns] 2007-01-01 ... 2007-01-30T23:00:00
    ssh        (id_dim, t_dim) float64 nan nan nan nan nan ... nan nan nan nan</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-9d56da97-ef83-4502-ac91-a3b63d227265' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-9d56da97-ef83-4502-ac91-a3b63d227265' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>t_dim</span>: 720</li><li><span>id_dim</span>: 61</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-b8873e66-af63-4c95-baa0-9e0b5d4ebd06' class='xr-section-summary-in' type='checkbox'  checked><label for='section-b8873e66-af63-4c95-baa0-9e0b5d4ebd06' class='xr-section-summary' >Coordinates: <span>(3)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.292 -3.975 -5.158 ... 350.8 8.717</div><input id='attrs-ee89615d-c5e2-4fcf-9f14-6bf98269d00d' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-ee89615d-c5e2-4fcf-9f14-6bf98269d00d' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ee8a03cd-8943-4524-9d6b-882fb9c1d01b' class='xr-var-data-in' type='checkbox'><label for='data-ee8a03cd-8943-4524-9d6b-882fb9c1d01b' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 1.29210000e+00, -3.97544000e+00, -5.15789000e+00, -5.05148000e+00,
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
        8.71700001e+00])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>51.95 51.57 57.9 ... 51.53 53.87</div><input id='attrs-d0247430-36bf-4ed4-86e3-1612a1450aa2' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-d0247430-36bf-4ed4-86e3-1612a1450aa2' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-50078297-d5b1-4f4c-8032-ed61f29d7bab' class='xr-var-data-in' type='checkbox'><label for='data-50078297-d5b1-4f4c-8032-ed61f29d7bab' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([51.94798   , 51.57      , 57.89525   , 51.7064    , 54.03167   ,
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
       53.86700058])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>site_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>object</div><div class='xr-var-preview xr-preview'>&#x27;Harwich&#x27; &#x27;Mumbles&#x27; ... &#x27;N/A&#x27; &#x27;N/A&#x27;</div><input id='attrs-6972973c-96bc-4cf6-90ad-e9f0445a75f7' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-6972973c-96bc-4cf6-90ad-e9f0445a75f7' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-78098c37-6253-4082-bf24-95fda59981fa' class='xr-var-data-in' type='checkbox'><label for='data-78098c37-6253-4082-bf24-95fda59981fa' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Harwich&#x27;, &#x27;Mumbles&#x27;, &#x27;Ullapool&#x27;, &#x27;Milford Haven&#x27;, &#x27;Heysham&#x27;,
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
       &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;, &#x27;N/A&#x27;], dtype=object)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-526995bd-0b85-49e2-ac63-e6fda433c2f9' class='xr-section-summary-in' type='checkbox'  checked><label for='section-526995bd-0b85-49e2-ac63-e6fda433c2f9' class='xr-section-summary' >Data variables: <span>(2)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-01 ... 2007-01-30T23:00:00</div><input id='attrs-57126dc0-bf8e-48e9-934e-7142e930156c' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-57126dc0-bf8e-48e9-934e-7142e930156c' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-d544415a-e958-498f-ad38-8235b66bda5a' class='xr-var-data-in' type='checkbox'><label for='data-d544415a-e958-498f-ad38-8235b66bda5a' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-01T00:00:00.000000000&#x27;, &#x27;2007-01-01T01:00:00.000000000&#x27;,
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
      dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>ssh</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-4b0cb960-ebb0-4cf4-8078-ed28bcf68141' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-4b0cb960-ebb0-4cf4-8078-ed28bcf68141' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-b6a98786-63d6-4fdd-903f-a366b9da352b' class='xr-var-data-in' type='checkbox'><label for='data-b6a98786-63d6-4fdd-903f-a366b9da352b' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan],
       ...,
       [nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan],
       [nan, nan, nan, ..., nan, nan, nan]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-ff6eb1f1-cc6c-43af-8b72-7f5e1dd78eec' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-ff6eb1f1-cc6c-43af-8b72-7f5e1dd78eec' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-e5dcbf0c-f32e-445f-a3e6-aa7d314634b6' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-e5dcbf0c-f32e-445f-a3e6-aa7d314634b6' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>




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


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[26], line 2
          1 plt.figure()
    ----> 2 plt.plot( tide_obs.dataset.time, tide_obs.dataset.reconstructed.isel(id_dim=stn_id), label='reconstructed from harmonics', color='orange' )
          3 plt.plot( obs_new.dataset.time, obs_new.dataset.ssh.isel(id_dim=stn_id) , label='observed', color='blue' )
          4 plt.legend()


    NameError: name 'tide_obs' is not defined



    <Figure size 640x480 with 0 Axes>


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


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[27], line 4
          2 plt.subplot(2,1,1)
          3 plt.plot( dx0.dataset.time, dx0.isel(id_dim=stn_id).dataset.ssh, label='obs: doodsonX0 filtered', color='orange' )
    ----> 4 plt.plot( ntr_obs.dataset.time, ntr_obs.isel(id_dim=stn_id).dataset.ntr, label='obs: non-tidal residual', color='blue' )
          5 plt.title('analysis comparison: non-tidal residual vs doodsonX0')
          6 plt.legend()


    NameError: name 'ntr_obs' is not defined



    
![png](/COAsT/tidegauge_validation_tutorial_files/tidegauge_validation_tutorial_59_1.png)
    


### Threshold Statistics for non-tidal residuals

This is a simple extreme value analysis of whatever data you use. It will count the number of peaks and the total time spent over each threshold provided. It will also count the numbers of daily and monthly maxima over each threshold. To this, a Tidegauge object and an array of thresholds (in metres) should be passed. The method return `peak_count_*`, `time_over_threshold_*`, `dailymax_count_*`, `monthlymax_count_*`:



```python
thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(-2, 2, 0.1))
thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(-2, 2, 0.1))
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[28], line 1
    ----> 1 thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(-2, 2, 0.1))
          2 thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(-2, 2, 0.1))


    NameError: name 'ntr_mod' is not defined



```python
# Have a look
thresh_obs
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[29], line 2
          1 # Have a look
    ----> 2 thresh_obs


    NameError: name 'thresh_obs' is not defined



```python
plt.plot( thresh_obs.threshold, thresh_obs.peak_count_ntr.mean(dim='id_dim') )
#plt.ylim([0,15])
plt.title(f"Observed peaks over threshold")
plt.xlabel('Analysis threshold (m)')
plt.ylabel('event count')
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[30], line 1
    ----> 1 plt.plot( thresh_obs.threshold, thresh_obs.peak_count_ntr.mean(dim='id_dim') )
          2 #plt.ylim([0,15])
          3 plt.title(f"Observed peaks over threshold")


    NameError: name 'thresh_obs' is not defined


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


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[31], line 1
    ----> 1 normalised_event_count = 100 * thresh_obs.time_over_threshold_ntr.isel(id_dim=stn_id) / thresh_obs.time_over_threshold_ntr.isel(id_dim=stn_id).max()
          3 plt.plot( thresh_obs.threshold, normalised_event_count )
          4 plt.ylim([20,40])


    NameError: name 'thresh_obs' is not defined



## Other TidegaugeAnalysis methods 

### Calculate errors

The difference() routine will calculate differences, absolute_differences and squared differenced for all variables. Corresponding new variables are created with names `diff_*`, `abs_diff_*` and `square_diff_*`


```python
ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)

# Take a look
ntr_diff.dataset
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[32], line 1
    ----> 1 ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
          2 ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)
          4 # Take a look


    NameError: name 'ntr_obs' is not defined


We can then easily get mean errors, MAE and MSE



```python
mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[33], line 1
    ----> 1 mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)


    NameError: name 'ntr_diff' is not defined



```python

```
