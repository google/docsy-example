---
    title: "Potential energy tutorial"
    linkTitle: "Potential energy tutorial"
    weight: 5

    description: >
        Potential energy tutorial example.
---
A demonstration to calculate the Potential Energy Anomaly and demonstrate regional masking with MaskMaker


### Relevant imports and filepath configuration


```python
import coast
import numpy as np
import os
import matplotlib.pyplot as plt
import matplotlib.colors as colors  # colormap fiddling
import xarray as xr
```


```python
# set some paths
root = "./"
dn_files = root + "./example_files/"
fn_nemo_grid_t_dat = dn_files + "nemo_data_T_grid_Aug2015.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
config_t = root + "./config/example_nemo_grid_t.json"
```

### Loading data


```python
# Create a Gridded object and load in the data:
nemo = coast.Gridded(fn_nemo_grid_t_dat, fn_nemo_dom, config=config_t)
```

### Calculates Potential Energy Anomaly

The density and depth averaged density can be supplied within gridded_t as `density` and
`density_bar` DataArrays, respectively. If they are not supplied they will be calculated.
`density_bar` is calcuated using depth averages of temperature and salinity.




```python
# Compute a vertical max to exclude depths below 200m
Zd_mask, kmax, Ikmax = nemo.calculate_vertical_mask(200.)

# Initiate a stratification diagnostics object
strat = coast.GriddedStratification(nemo)
```


```python

```


```python
# calculate PEA for unmasked depths
strat.calc_pea(nemo, Zd_mask)
```

## make a plot


```python
strat.quick_plot('PEA')
```




    (<Figure size 1000x1000 with 2 Axes>,
     <Axes: title={'center': '01 Aug 2015: Potential Energy Anomaly (J / m^3)'}, xlabel='longitude', ylabel='latitude'>)




    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_11_1.png)
    



```python
strat.dataset
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
Dimensions:    (t_dim: 7, y_dim: 375, x_dim: 297)
Coordinates:
    time       (t_dim) datetime64[ns] 2015-08-01T12:00:00 ... 2015-08-07T12:0...
    latitude   (y_dim, x_dim) float32 40.07 40.07 40.07 40.07 ... 65.0 65.0 65.0
    longitude  (y_dim, x_dim) float32 -19.89 -19.78 -19.67 ... 12.78 12.89 13.0
Dimensions without coordinates: t_dim, y_dim, x_dim
Data variables:
    PEA        (t_dim, y_dim, x_dim) float64 nan nan nan nan ... nan nan nan nan</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-f2553bf9-dece-4764-a98a-08628a7da9e6' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-f2553bf9-dece-4764-a98a-08628a7da9e6' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>t_dim</span>: 7</li><li><span>y_dim</span>: 375</li><li><span>x_dim</span>: 297</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-4c6a453b-b725-411e-ab80-62efbb1c7c35' class='xr-section-summary-in' type='checkbox'  checked><label for='section-4c6a453b-b725-411e-ab80-62efbb1c7c35' class='xr-section-summary' >Coordinates: <span>(3)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2015-08-01T12:00:00 ... 2015-08-...</div><input id='attrs-83c2ac63-e788-47f9-8b32-c940924a40e6' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-83c2ac63-e788-47f9-8b32-c940924a40e6' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-27179b79-3caa-48f2-8f45-d06c8c38dbe2' class='xr-var-data-in' type='checkbox'><label for='data-27179b79-3caa-48f2-8f45-d06c8c38dbe2' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2015-08-01T12:00:00.000000000&#x27;, &#x27;2015-08-02T12:00:00.000000000&#x27;,
       &#x27;2015-08-03T12:00:00.000000000&#x27;, &#x27;2015-08-04T12:00:00.000000000&#x27;,
       &#x27;2015-08-05T12:00:00.000000000&#x27;, &#x27;2015-08-06T12:00:00.000000000&#x27;,
       &#x27;2015-08-07T12:00:00.000000000&#x27;], dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>40.07 40.07 40.07 ... 65.0 65.0</div><input id='attrs-e031bf45-b4ec-49ca-98e5-8eec6409b0fd' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e031bf45-b4ec-49ca-98e5-8eec6409b0fd' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-878a3dca-c99e-4a75-aa98-773de61e42a6' class='xr-var-data-in' type='checkbox'><label for='data-878a3dca-c99e-4a75-aa98-773de61e42a6' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[40.066406, 40.066406, 40.066406, ..., 40.066406, 40.066406,
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
        65.00098 ]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>-19.89 -19.78 -19.67 ... 12.89 13.0</div><input id='attrs-7da8cf55-3e13-4f21-9e07-607a3443e0cc' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-7da8cf55-3e13-4f21-9e07-607a3443e0cc' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-15bdc097-3728-4834-88a4-34e2d60a57f3' class='xr-var-data-in' type='checkbox'><label for='data-15bdc097-3728-4834-88a4-34e2d60a57f3' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
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
         13.      ]], dtype=float32)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-00d3405f-f77c-4cad-b9e3-121ebf978cef' class='xr-section-summary-in' type='checkbox'  checked><label for='section-00d3405f-f77c-4cad-b9e3-121ebf978cef' class='xr-section-summary' >Data variables: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>PEA</span></div><div class='xr-var-dims'>(t_dim, y_dim, x_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-dc8190aa-a1ed-4bda-8a85-50d4276116f1' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-dc8190aa-a1ed-4bda-8a85-50d4276116f1' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-202c0b9c-4523-436b-b0e9-ff3d37915ae6' class='xr-var-data-in' type='checkbox'><label for='data-202c0b9c-4523-436b-b0e9-ff3d37915ae6' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>J / m^3</dd><dt><span>standard_name :</span></dt><dd>Potential Energy Anomaly</dd></dl></div><div class='xr-var-data'><pre>array([[[         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan, 262.43849344, 261.16678604, ...,          nan,
                  nan,          nan],
        [         nan, 262.22882652, 292.63335667, ...,          nan,
                  nan,          nan],
        ...,
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan]],

       [[         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan, 269.18332328, 268.17983174, ...,          nan,
                  nan,          nan],
        [         nan, 268.76494494, 226.91876185, ...,          nan,
                  nan,          nan],
...
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan]],

       [[         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan, 263.17561991, 262.13100791, ...,          nan,
                  nan,          nan],
        [         nan, 263.60651849, 268.85516316, ...,          nan,
                  nan,          nan],
        ...,
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan],
        [         nan,          nan,          nan, ...,          nan,
                  nan,          nan]]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-b9285f4a-8ae2-458f-b44d-447ab924e226' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-b9285f4a-8ae2-458f-b44d-447ab924e226' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-c48ee63b-be12-4772-91ff-d7b7354ddcf6' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-c48ee63b-be12-4772-91ff-d7b7354ddcf6' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



# Use MaskMaker to define regions and do regional analysis

MaskMaker can build a stack of boolean masks in an xarray dataset for regional analysis. For the NWS we can use some built-in regions.  


```python
mm = coast.MaskMaker()

# Define Regional Masks
regional_masks = []

# Define convenient aliases based on nemo data
lon = nemo.dataset.longitude.values
lat = nemo.dataset.latitude.values
bathy = nemo.dataset.bathymetry.values

# Add regional mask for whole domain
regional_masks.append(np.ones(lon.shape))

# Add regional mask for English Channel
regional_masks.append(mm.region_def_nws_north_sea(lon, lat, bathy))
regional_masks.append(mm.region_def_nws_outer_shelf(lon, lat, bathy))
regional_masks.append(mm.region_def_nws_norwegian_trench(lon, lat, bathy))
regional_masks.append(mm.region_def_nws_english_channel(lon, lat, bathy))
regional_masks.append(mm.region_def_south_north_sea(lon, lat, bathy))
regional_masks.append(mm.region_def_off_shelf(lon, lat, bathy))
regional_masks.append(mm.region_def_irish_sea(lon, lat, bathy))
regional_masks.append(mm.region_def_kattegat(lon, lat, bathy))

region_names = ["whole domain", "north sea", "outer shelf", "norwegian trench",
                "english_channel", "southern north sea", "off shelf",
                "irish sea", "kattegat",]
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    Cell In[8], line 15
         12 regional_masks.append(np.ones(lon.shape))
         14 # Add regional mask for English Channel
    ---> 15 regional_masks.append(mm.region_def_nws_north_sea(lon, lat, bathy))
         16 regional_masks.append(mm.region_def_nws_outer_shelf(lon, lat, bathy))
         17 regional_masks.append(mm.region_def_nws_norwegian_trench(lon, lat, bathy))


    AttributeError: 'MaskMaker' object has no attribute 'region_def_nws_north_sea'


Convert this list of masks into a dataset


```python
mask_list = mm.make_mask_dataset(lon, lat, regional_masks, region_names)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[9], line 1
    ----> 1 mask_list = mm.make_mask_dataset(lon, lat, regional_masks, region_names)


    NameError: name 'region_names' is not defined



```python
mask_list
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[10], line 1
    ----> 1 mask_list


    NameError: name 'mask_list' is not defined


Inspect the mask with a `quick_plot()` method. 


```python
mm.quick_plot(mask_list)

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[11], line 1
    ----> 1 mm.quick_plot(mask_list)


    NameError: name 'mask_list' is not defined


NB overlapping regions are not given special treatment, the layers are blindly superimposed on each other. E.g. as demonstrated with "Norwegian Trench" and "off shelf", or "whole domain" and any other region.


```python

plt.subplot(2,2,1)
mm.quick_plot(mask_list.sel(dim_mask=[0,3]))

plt.subplot(2,2,2)
mm.quick_plot(mask_list.sel(dim_mask=[1,2,4,5,6,7,8]))



plt.tight_layout()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[12], line 2
          1 plt.subplot(2,2,1)
    ----> 2 mm.quick_plot(mask_list.sel(dim_mask=[0,3]))
          4 plt.subplot(2,2,2)
          5 mm.quick_plot(mask_list.sel(dim_mask=[1,2,4,5,6,7,8]))


    NameError: name 'mask_list' is not defined



    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_21_1.png)
    



```python
# Show overlap
mask_list.mask.sum(dim='dim_mask').plot( levels=(1,2,3,4))

# Save if required
#plt.savefig('tmp.png')
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[13], line 2
          1 # Show overlap
    ----> 2 mask_list.mask.sum(dim='dim_mask').plot( levels=(1,2,3,4))
          4 # Save if required
          5 #plt.savefig('tmp.png')


    NameError: name 'mask_list' is not defined


# Regional analysis

Average stratification object over regions using the mask


```python
mask_means = (strat.dataset*mask_list.mask).mean(dim='x_dim').mean(dim='y_dim')
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[14], line 1
    ----> 1 mask_means = (strat.dataset*mask_list.mask).mean(dim='x_dim').mean(dim='y_dim')


    NameError: name 'mask_list' is not defined



```python
mask_means
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[15], line 1
    ----> 1 mask_means


    NameError: name 'mask_means' is not defined



```python
# Plot timeseries per region

for count_region in range(mask_means.dims['dim_mask']):
    
    plt.plot( 
        mask_means.PEA.isel(dim_mask=count_region),
        label=mask_means.region_names[count_region].values,
        marker=".", linestyle='none')

plt.xlabel('time'); plt.ylabel('PEA')
plt.legend()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In[16], line 3
          1 # Plot timeseries per region
    ----> 3 for count_region in range(mask_means.dims['dim_mask']):
          5     plt.plot( 
          6         mask_means.PEA.isel(dim_mask=count_region),
          7         label=mask_means.region_names[count_region].values,
          8         marker=".", linestyle='none')
         10 plt.xlabel('time'); plt.ylabel('PEA')


    NameError: name 'mask_means' is not defined

