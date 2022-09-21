---
    title: "Tidegauge validation tutorial"
    linkTitle: "Tidegauge validation tutorial"
    weight: 5

    description: >
        Tidegauge validation tutorial example.
---
This tutorial gives an overview of some of validation tools available when
using the Tidegauge objects in COAsT.

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
    fn_tg = dir + "tg_amm15.nc"
```

### Reading and manipulation

We can create our empty tidegauge object:


```python
tidegauge = coast.Tidegauge()
```

    Tidegauge object at 0x55766dbdefc0 initialised


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
Dimensions:    (id_dim: 1, t_dim: 193)
Coordinates:
    time       (t_dim) datetime64[ns] 2007-01-10 ... 2007-01-12
    longitude  (id_dim) float64 1.751
    latitude   (id_dim) float64 52.47
    id_name    (id_dim) &lt;U9 &#x27;Lowestoft&#x27;
Dimensions without coordinates: id_dim, t_dim
Data variables:
    ssh        (id_dim, t_dim) float64 2.818 2.823 2.871 ... 3.214 3.257 3.371
    qc_flags   (id_dim, t_dim) int64 1 1 1 1 1 1 1 1 1 1 ... 1 1 1 1 1 1 1 1 1 1</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-caea3c87-8433-4e19-8560-de9eedf7cd4d' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-caea3c87-8433-4e19-8560-de9eedf7cd4d' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>id_dim</span>: 1</li><li><span>t_dim</span>: 193</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-0ceb2ea5-9ff3-4d15-8cff-53444a63dd3d' class='xr-section-summary-in' type='checkbox'  checked><label for='section-0ceb2ea5-9ff3-4d15-8cff-53444a63dd3d' class='xr-section-summary' >Coordinates: <span>(4)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2007-01-10 ... 2007-01-12</div><input id='attrs-404a3b90-5765-406d-8be0-10bc709206c3' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-404a3b90-5765-406d-8be0-10bc709206c3' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-91bfddef-96c0-4986-ad04-60b14e412066' class='xr-var-data-in' type='checkbox'><label for='data-91bfddef-96c0-4986-ad04-60b14e412066' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2007-01-10T00:00:00.000000000&#x27;, &#x27;2007-01-10T00:15:00.000000000&#x27;,
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
       &#x27;2007-01-12T00:00:00.000000000&#x27;], dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.751</div><input id='attrs-2e3390f1-f7ae-4bc6-a3a0-e1c00215ff84' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-2e3390f1-f7ae-4bc6-a3a0-e1c00215ff84' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-e3916c8d-6990-4b79-81b0-d310677fd769' class='xr-var-data-in' type='checkbox'><label for='data-e3916c8d-6990-4b79-81b0-d310677fd769' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([1.75083])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>52.47</div><input id='attrs-f4a69cc9-175f-48ef-92e3-f3dc1a1639e7' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-f4a69cc9-175f-48ef-92e3-f3dc1a1639e7' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-9b56d9a0-4287-4aef-88b8-fc56732d19f5' class='xr-var-data-in' type='checkbox'><label for='data-9b56d9a0-4287-4aef-88b8-fc56732d19f5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([52.473])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>id_name</span></div><div class='xr-var-dims'>(id_dim)</div><div class='xr-var-dtype'>&lt;U9</div><div class='xr-var-preview xr-preview'>&#x27;Lowestoft&#x27;</div><input id='attrs-d680704c-9e4d-4638-af76-217563dc97d9' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-d680704c-9e4d-4638-af76-217563dc97d9' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-b82b64f8-8962-4b0b-986b-9850bae9911d' class='xr-var-data-in' type='checkbox'><label for='data-b82b64f8-8962-4b0b-986b-9850bae9911d' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;Lowestoft&#x27;], dtype=&#x27;&lt;U9&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-44a3285f-725f-41f1-a9dd-0f18bc0f36c0' class='xr-section-summary-in' type='checkbox'  checked><label for='section-44a3285f-725f-41f1-a9dd-0f18bc0f36c0' class='xr-section-summary' >Data variables: <span>(2)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>ssh</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>2.818 2.823 2.871 ... 3.257 3.371</div><input id='attrs-232099d7-863e-4e09-bf60-ccf5dc6a153f' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-232099d7-863e-4e09-bf60-ccf5dc6a153f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-914dfb77-4702-4c8d-b482-07bf61346e2c' class='xr-var-data-in' type='checkbox'><label for='data-914dfb77-4702-4c8d-b482-07bf61346e2c' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[ 2.818,  2.823,  2.871,  2.931,  2.961,  2.979,  2.953,  2.913,
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
         3.371]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>qc_flags</span></div><div class='xr-var-dims'>(id_dim, t_dim)</div><div class='xr-var-dtype'>int64</div><div class='xr-var-preview xr-preview'>1 1 1 1 1 1 1 1 ... 1 1 1 1 1 1 1 1</div><input id='attrs-831ddf04-a846-4e93-b617-41868fcd47cf' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-831ddf04-a846-4e93-b617-41868fcd47cf' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-4ce0a8ab-710d-4e21-99b9-7b0274c4c29e' class='xr-var-data-in' type='checkbox'><label for='data-4ce0a8ab-710d-4e21-99b9-7b0274c4c29e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-7e2860cc-762b-40b9-b464-5ebc8efa4631' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-7e2860cc-762b-40b9-b464-5ebc8efa4631' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



An example data variable could be ssh, or ntr (non-tidal residual). This object can also be used for other instrument types, not just tide gauges. For example moorings.

Every id index for this object should use the same time coordinates. Therefore, timeseries need to be aligned before being placed into the object. If there is any padding needed, then NaNs should be used. NaNs should also be used for quality control/data rejection.


For the rest of our examples, we will use data from multiple tide gauges
on the same time dimension. It will be read in from a simple netCDF file:


```python
# Create the object and then inset the netcdf dataset
obs = coast.Tidegauge(dataset=xr.open_dataset(fn_tg))
obs.dataset = obs.dataset.set_coords("time")
```


    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/file_manager.py in _acquire_with_cache_info(self, needs_lock)
        198             try:
    --> 199                 file = self._cache[self._key]
        200             except KeyError:


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/lru_cache.py in __getitem__(self, key)
         52         with self._lock:
    ---> 53             value = self._cache[key]
         54             self._cache.move_to_end(key)


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/tidegauge/example_files/tg_amm15.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    /tmp/ipykernel_3686/2031331311.py in <cell line: 2>()
          1 # Create the object and then inset the netcdf dataset
    ----> 2 obs = coast.Tidegauge(dataset=xr.open_dataset(fn_tg))
          3 obs.dataset = obs.dataset.set_coords("time")


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/api.py in open_dataset(filename_or_obj, engine, chunks, cache, decode_cf, mask_and_scale, decode_times, decode_timedelta, use_cftime, concat_characters, decode_coords, drop_variables, backend_kwargs, *args, **kwargs)
        493 
        494     overwrite_encoded_chunks = kwargs.pop("overwrite_encoded_chunks", None)
    --> 495     backend_ds = backend.open_dataset(
        496         filename_or_obj,
        497         drop_variables=drop_variables,


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in open_dataset(self, filename_or_obj, mask_and_scale, decode_times, concat_characters, decode_coords, drop_variables, use_cftime, decode_timedelta, group, mode, format, clobber, diskless, persist, lock, autoclose)
        551 
        552         filename_or_obj = _normalize_path(filename_or_obj)
    --> 553         store = NetCDF4DataStore.open(
        554             filename_or_obj,
        555             mode=mode,


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in open(cls, filename, mode, format, group, clobber, diskless, persist, lock, lock_maker, autoclose)
        380             netCDF4.Dataset, filename, mode=mode, kwargs=kwargs
        381         )
    --> 382         return cls(manager, group=group, mode=mode, lock=lock, autoclose=autoclose)
        383 
        384     def _acquire(self, needs_lock=True):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in __init__(self, manager, group, mode, lock, autoclose)
        328         self._group = group
        329         self._mode = mode
    --> 330         self.format = self.ds.data_model
        331         self._filename = self.ds.filepath()
        332         self.is_remote = is_remote_uri(self._filename)


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in ds(self)
        389     @property
        390     def ds(self):
    --> 391         return self._acquire()
        392 
        393     def open_store_variable(self, name, var):


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/netCDF4_.py in _acquire(self, needs_lock)
        383 
        384     def _acquire(self, needs_lock=True):
    --> 385         with self._manager.acquire_context(needs_lock) as root:
        386             ds = _nc4_require_group(root, self._group, self._mode)
        387         return ds


    /usr/share/miniconda/envs/coast/lib/python3.8/contextlib.py in __enter__(self)
        111         del self.args, self.kwds, self.func
        112         try:
    --> 113             return next(self.gen)
        114         except StopIteration:
        115             raise RuntimeError("generator didn't yield") from None


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/file_manager.py in acquire_context(self, needs_lock)
        185     def acquire_context(self, needs_lock=True):
        186         """Context manager for acquiring a file."""
    --> 187         file, cached = self._acquire_with_cache_info(needs_lock)
        188         try:
        189             yield file


    /usr/share/miniconda/envs/coast/lib/python3.8/site-packages/xarray/backends/file_manager.py in _acquire_with_cache_info(self, needs_lock)
        203                     kwargs = kwargs.copy()
        204                     kwargs["mode"] = self._mode
    --> 205                 file = self._opener(*self._args, **kwargs)
        206                 if self._mode == "w":
        207                     # ensure file doesn't get overridden when opened again


    src/netCDF4/_netCDF4.pyx in netCDF4._netCDF4.Dataset.__init__()


    src/netCDF4/_netCDF4.pyx in netCDF4._netCDF4._ensure_nc_success()


    FileNotFoundError: [Errno 2] No such file or directory: b'/home/runner/work/COAsT-site/COAsT-site/external/example_scripts/notebooks/runnable_notebooks/tidegauge/example_files/tg_amm15.nc'


Tidegauge has ready made quick plotting routines for viewing time series and tide gauge location. To look at the tide gauge location:


```python
fig, ax = obs.plot_on_map()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/941067764.py in <cell line: 1>()
    ----> 1 fig, ax = obs.plot_on_map()
    

    NameError: name 'obs' is not defined



```python
id=1
obs.dataset.ssh[id].rename({'t_dim':'time'}).plot()  # rename time dimension to enable automatic x-axis labelling
plt.show()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/1147217509.py in <cell line: 2>()
          1 id=1
    ----> 2 obs.dataset.ssh[id].rename({'t_dim':'time'}).plot()  # rename time dimension to enable automatic x-axis labelling
          3 plt.show()


    NameError: name 'obs' is not defined


Note that start and end dates can also be specified for the `Tidegauge.plot_timeseries()` method.

We can do some simple spatial and temporal manipulations of this data:



```python
# Cut out a geographical box
obs_cut = obs.subset_indices_lonlat_box(lonbounds = [-5, 0],
                                            latbounds = [50, 55])
fig, ax = obs_cut.plot_on_map()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/364088065.py in <cell line: 2>()
          1 # Cut out a geographical box
    ----> 2 obs_cut = obs.subset_indices_lonlat_box(lonbounds = [-5, 0],
          3                                             latbounds = [50, 55])
          4 fig, ax = obs_cut.plot_on_map()


    NameError: name 'obs' is not defined



```python
# Cut out a time window
obs_cut = obs.time_slice( date0 = datetime.datetime(2007, 1, 1), date1 = datetime.datetime(2007,1,31))
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/807598452.py in <cell line: 2>()
          1 # Cut out a time window
    ----> 2 obs_cut = obs.time_slice( date0 = datetime.datetime(2007, 1, 1), date1 = datetime.datetime(2007,1,31))
    

    NameError: name 'obs' is not defined


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


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/3267278158.py in <cell line: 6>()
          4 
          5 # Then do the interpolation
    ----> 6 tidegauge_from_model = obs.obs_operator(nemo, time_interp='nearest')
    

    NameError: name 'obs' is not defined


However, the new `tidegauge_from_model` will the same number of time entries as the `obs` data (rather than the model data). So, for a more useful demonstration we trim the observed gauge data so it better matches the model data.


```python
# Shift the timestamp so it overlaps with the tidegauge data - Not ideal but this is only a demo
#obs.dataset.coords["time"] = obs.dataset.coords["time"] + 1000000000 * 3600 * 24 * 365 * 3

# Cut down data to be only in 2007 to match model data.
start_date = datetime.datetime(2007, 1, 1)
end_date = datetime.datetime(2007, 1, 31)
obs = obs.time_slice(start_date, end_date)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/1320953407.py in <cell line: 7>()
          5 start_date = datetime.datetime(2007, 1, 1)
          6 end_date = datetime.datetime(2007, 1, 31)
    ----> 7 obs = obs.time_slice(start_date, end_date)
    

    NameError: name 'obs' is not defined


### Interpolate model data onto obs locations


```python
model_timeseries = obs.obs_operator(nemo)

# In this case, transpose the interpolated dataset
model_timeseries.dataset = model_timeseries.dataset.transpose()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/322332736.py in <cell line: 1>()
    ----> 1 model_timeseries = obs.obs_operator(nemo)
          2 
          3 # In this case, transpose the interpolated dataset
          4 model_timeseries.dataset = model_timeseries.dataset.transpose()


    NameError: name 'obs' is not defined


For a good comparison, we would like to make sure that both the observed and
modelled `Tidegauge` objects contain the same missing values. `TidegaugeAnalysis`
contains a routine for ensuring this. First create our analysis object:


```python
# This routine searches for missing values in each dataset and applies them
# equally to each corresponding dataset
tganalysis = coast.TidegaugeAnalysis()
obs_new, model_new = tganalysis.match_missing_values(obs.dataset.ssh, model_timeseries.dataset.ssh)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/1041160087.py in <cell line: 4>()
          2 # equally to each corresponding dataset
          3 tganalysis = coast.TidegaugeAnalysis()
    ----> 4 obs_new, model_new = tganalysis.match_missing_values(obs.dataset.ssh, model_timeseries.dataset.ssh)
    

    NameError: name 'obs' is not defined


Although we input data arrays to the above routine, it returns two new Tidegauge objects. Now you have equivalent and comparable sets of time series that can be easily compared.

### Harmonic Analysis & Non tidal-Residuals

The `Tidegauge` object contains some routines which make harmonic analysis and
the calculation/comparison of non-tidal residuals easier. Harmonic analysis is
done using the `utide` package. Please see [here](https://pypi.org/project/UTide/) for more info.

First we can use the `TidegaugeAnalysis` class to do a harmonic analysis. Suppose
we have two `Tidegauge` objects called `obs` and `model_timeseries` generated from tidegauge observations and model simulations respectively.

We can subtract means from all time series:

Then subtract means from all the time series


```python
# Subtract means from all time series
obs_new = tganalysis.demean_timeseries(obs_new.dataset)
model_new = tganalysis.demean_timeseries(model_new.dataset)

# Now you have equivalent and comparable sets of time series that can be
# easily compared.
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/835506438.py in <cell line: 2>()
          1 # Subtract means from all time series
    ----> 2 obs_new = tganalysis.demean_timeseries(obs_new.dataset)
          3 model_new = tganalysis.demean_timeseries(model_new.dataset)
          4 
          5 # Now you have equivalent and comparable sets of time series that can be


    NameError: name 'obs_new' is not defined


Then we can apply the harmonic analysis (though the example data is too short for this example to be that meaningful):

### Calculate non tidal residuals



First, do a harmonic analysis. This routine uses utide


```python
ha_mod = tganalysis.harmonic_analysis_utide(model_new.dataset.ssh, min_datapoints=1)
ha_obs = tganalysis.harmonic_analysis_utide(obs_new.dataset.ssh, min_datapoints=1)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/1301265525.py in <cell line: 1>()
    ----> 1 ha_mod = tganalysis.harmonic_analysis_utide(model_new.dataset.ssh, min_datapoints=1)
          2 ha_obs = tganalysis.harmonic_analysis_utide(obs_new.dataset.ssh, min_datapoints=1)


    NameError: name 'model_new' is not defined


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


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/1541850180.py in <cell line: 1>()
    ----> 1 tide_mod = tganalysis.reconstruct_tide_utide(model_new.dataset.time, ha_mod)
          2 tide_obs = tganalysis.reconstruct_tide_utide(obs_new.dataset.time, ha_obs)


    NameError: name 'model_new' is not defined


Get new TidegaugeMultiple objects containing non tidal residuals:


```python
ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed)
ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed)

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/1976018595.py in <cell line: 1>()
    ----> 1 ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed)
          2 ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed)


    NameError: name 'model_new' is not defined



By default, this routines will apply `scipy.signal.savgol_filter` to the non-tidal residuals
to remove some noise. This can be switched off using `apply_filter = False`.

The Doodson X0 filter is an alternative way of estimating non-tidal residuals:


```python
dx0 = tganalysis.doodson_x0_filter(obs.dataset, "ssh")
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/2893622625.py in <cell line: 1>()
    ----> 1 dx0 = tganalysis.doodson_x0_filter(obs.dataset, "ssh")
    

    NameError: name 'obs' is not defined


This will return a new Tidegauge() object containing filtered ssh data.


### Other TidegaugeAnalysis methods 

#### Calculate errors

The difference() routine will calculate differences, absolute_differences and squared differenced for all variables:


```python
ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/1207573481.py in <cell line: 1>()
    ----> 1 ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
          2 ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)


    NameError: name 'ntr_obs' is not defined


We can then easily get mean errors, MAE and MSE



```python
mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/275311129.py in <cell line: 1>()
    ----> 1 mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
    

    NameError: name 'ntr_diff' is not defined


#### Threshold Statistics for Non-tidal residuals

This is a simple extreme value analysis of whatever data you use. It will count the number of peaks and the total time spent over each threshold provided. It will also count the numbers of daily and monthly maxima over each threshold. To this, a Tidegauge object and an array of thresholds (in metres) should be passed:



```python
thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(0, 2, 0.2))
thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(0, 2, 0.2))
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    /tmp/ipykernel_3686/3657222019.py in <cell line: 1>()
    ----> 1 thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(0, 2, 0.2))
          2 thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(0, 2, 0.2))


    NameError: name 'ntr_mod' is not defined



```python

```
