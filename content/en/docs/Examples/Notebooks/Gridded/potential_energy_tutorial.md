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


    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_11_0.png)
    





    (<Figure size 1000x1000 with 2 Axes>,
     <AxesSubplot: title={'center': '01 Aug 2015: Potential Energy Anomaly (J / m^3)'}, xlabel='longitude', ylabel='latitude'>)




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
    PEA        (t_dim, y_dim, x_dim) float64 nan nan nan nan ... nan nan nan nan</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-3b92a202-855e-4c50-ab5b-89ef43437904' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-3b92a202-855e-4c50-ab5b-89ef43437904' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>t_dim</span>: 7</li><li><span>y_dim</span>: 375</li><li><span>x_dim</span>: 297</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-8fb7393f-19a8-4b2b-a60d-c8e311e92ec9' class='xr-section-summary-in' type='checkbox'  checked><label for='section-8fb7393f-19a8-4b2b-a60d-c8e311e92ec9' class='xr-section-summary' >Coordinates: <span>(3)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2015-08-01T12:00:00 ... 2015-08-...</div><input id='attrs-f65839c3-7fc1-489a-8cc9-93896bb8e15e' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-f65839c3-7fc1-489a-8cc9-93896bb8e15e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-9da40fab-b079-430d-850c-ae37cebc9837' class='xr-var-data-in' type='checkbox'><label for='data-9da40fab-b079-430d-850c-ae37cebc9837' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2015-08-01T12:00:00.000000000&#x27;, &#x27;2015-08-02T12:00:00.000000000&#x27;,
       &#x27;2015-08-03T12:00:00.000000000&#x27;, &#x27;2015-08-04T12:00:00.000000000&#x27;,
       &#x27;2015-08-05T12:00:00.000000000&#x27;, &#x27;2015-08-06T12:00:00.000000000&#x27;,
       &#x27;2015-08-07T12:00:00.000000000&#x27;], dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>40.07 40.07 40.07 ... 65.0 65.0</div><input id='attrs-bd4f6142-1e13-4945-8f01-e512a16d3a77' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-bd4f6142-1e13-4945-8f01-e512a16d3a77' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-62e44a1f-1997-4463-8033-09e85309e949' class='xr-var-data-in' type='checkbox'><label for='data-62e44a1f-1997-4463-8033-09e85309e949' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[40.066406, 40.066406, 40.066406, ..., 40.066406, 40.066406,
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
        65.00098 ]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>-19.89 -19.78 -19.67 ... 12.89 13.0</div><input id='attrs-697590a9-888a-4f12-909f-875db94d72aa' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-697590a9-888a-4f12-909f-875db94d72aa' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ca557e96-8b37-4c05-bd7f-5dc18d44ab8e' class='xr-var-data-in' type='checkbox'><label for='data-ca557e96-8b37-4c05-bd7f-5dc18d44ab8e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
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
         13.      ]], dtype=float32)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-8a2cdd73-2eef-49b9-a0d8-a55ba1163a85' class='xr-section-summary-in' type='checkbox'  checked><label for='section-8a2cdd73-2eef-49b9-a0d8-a55ba1163a85' class='xr-section-summary' >Data variables: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>PEA</span></div><div class='xr-var-dims'>(t_dim, y_dim, x_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>nan nan nan nan ... nan nan nan nan</div><input id='attrs-036deccf-f18e-4220-960e-3df006fec29f' class='xr-var-attrs-in' type='checkbox' ><label for='attrs-036deccf-f18e-4220-960e-3df006fec29f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-998c6b1a-82c1-4947-8c92-b179cc9d2309' class='xr-var-data-in' type='checkbox'><label for='data-998c6b1a-82c1-4947-8c92-b179cc9d2309' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'><dt><span>units :</span></dt><dd>J / m^3</dd><dt><span>standard_name :</span></dt><dd>Potential Energy Anomaly</dd></dl></div><div class='xr-var-data'><pre>array([[[         nan,          nan,          nan, ...,          nan,
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
                  nan,          nan]]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-a2e85b03-47e5-4e23-9e53-3d4cdb8ccad5' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-a2e85b03-47e5-4e23-9e53-3d4cdb8ccad5' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-4445333f-2b9f-453b-9d09-85fdfd266545' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-4445333f-2b9f-453b-9d09-85fdfd266545' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



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

Convert this list of masks into a dataset


```python
mask_list = mm.make_mask_dataset(lon, lat, regional_masks, region_names)
```


```python
mask_list
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
Dimensions:       (y_dim: 375, x_dim: 297, dim_mask: 9)
Coordinates:
    longitude     (y_dim, x_dim) float32 -19.89 -19.78 -19.67 ... 12.89 13.0
    latitude      (y_dim, x_dim) float32 40.07 40.07 40.07 ... 65.0 65.0 65.0
    region_names  (dim_mask) &lt;U18 &#x27;whole domain&#x27; &#x27;north sea&#x27; ... &#x27;kattegat&#x27;
Dimensions without coordinates: y_dim, x_dim, dim_mask
Data variables:
    mask          (dim_mask, y_dim, x_dim) float64 1.0 1.0 1.0 ... 0.0 0.0 0.0</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-549d0dda-fa12-49ef-b857-89feac93abd4' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-549d0dda-fa12-49ef-b857-89feac93abd4' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>y_dim</span>: 375</li><li><span>x_dim</span>: 297</li><li><span>dim_mask</span>: 9</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-9367a0ca-b75e-4562-8d84-9fe7efc9c1ee' class='xr-section-summary-in' type='checkbox'  checked><label for='section-9367a0ca-b75e-4562-8d84-9fe7efc9c1ee' class='xr-section-summary' >Coordinates: <span>(3)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>longitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>-19.89 -19.78 -19.67 ... 12.89 13.0</div><input id='attrs-f24b937e-a9eb-4fab-bfba-9e6e7ea5aae2' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-f24b937e-a9eb-4fab-bfba-9e6e7ea5aae2' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-6247d1c1-0b42-450b-9fb3-9157f4efa8f2' class='xr-var-data-in' type='checkbox'><label for='data-6247d1c1-0b42-450b-9fb3-9157f4efa8f2' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[-19.888672, -19.777344, -19.666992, ...,  12.777344,  12.888672,
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
         13.      ]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>latitude</span></div><div class='xr-var-dims'>(y_dim, x_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>40.07 40.07 40.07 ... 65.0 65.0</div><input id='attrs-804677cb-b57a-474c-9c2d-67b7ea174154' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-804677cb-b57a-474c-9c2d-67b7ea174154' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-22fd4011-071b-4ad0-85d9-99488c3cafd0' class='xr-var-data-in' type='checkbox'><label for='data-22fd4011-071b-4ad0-85d9-99488c3cafd0' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[40.066406, 40.066406, 40.066406, ..., 40.066406, 40.066406,
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
        65.00098 ]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>region_names</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>&lt;U18</div><div class='xr-var-preview xr-preview'>&#x27;whole domain&#x27; ... &#x27;kattegat&#x27;</div><input id='attrs-8e9220dd-fddb-4e4d-823f-efb134d7ac79' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-8e9220dd-fddb-4e4d-823f-efb134d7ac79' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-6a6a2107-8a3d-4c4e-917e-97959add97ca' class='xr-var-data-in' type='checkbox'><label for='data-6a6a2107-8a3d-4c4e-917e-97959add97ca' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;whole domain&#x27;, &#x27;north sea&#x27;, &#x27;outer shelf&#x27;, &#x27;norwegian trench&#x27;,
       &#x27;english_channel&#x27;, &#x27;southern north sea&#x27;, &#x27;off shelf&#x27;, &#x27;irish sea&#x27;,
       &#x27;kattegat&#x27;], dtype=&#x27;&lt;U18&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-2adf22b7-197b-4514-8255-caf9db560021' class='xr-section-summary-in' type='checkbox'  checked><label for='section-2adf22b7-197b-4514-8255-caf9db560021' class='xr-section-summary' >Data variables: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>mask</span></div><div class='xr-var-dims'>(dim_mask, y_dim, x_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.0 1.0 1.0 1.0 ... 0.0 0.0 0.0 0.0</div><input id='attrs-f2250976-997c-4980-927f-59335beaca76' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-f2250976-997c-4980-927f-59335beaca76' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-c4f01c5c-d84b-496d-8e61-d22cf6ba1413' class='xr-var-data-in' type='checkbox'><label for='data-c4f01c5c-d84b-496d-8e61-d22cf6ba1413' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[[1., 1., 1., ..., 1., 1., 1.],
        [1., 1., 1., ..., 1., 1., 1.],
        [1., 1., 1., ..., 1., 1., 1.],
        ...,
        [1., 1., 1., ..., 1., 1., 1.],
        [1., 1., 1., ..., 1., 1., 1.],
        [1., 1., 1., ..., 1., 1., 1.]],

       [[0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        ...,
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.]],

       [[0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        ...,
...
        ...,
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.]],

       [[0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        ...,
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.]],

       [[0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        ...,
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.],
        [0., 0., 0., ..., 0., 0., 0.]]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-3ef4b5f9-1ae5-4457-aa5d-7f96538ce476' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-3ef4b5f9-1ae5-4457-aa5d-7f96538ce476' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-fcbabf0b-363b-4db3-be67-e24f2a567d76' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-fcbabf0b-363b-4db3-be67-e24f2a567d76' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



Inspect the mask with a `quick_plot()` method. 


```python
mm.quick_plot(mask_list)

```


    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_19_0.png)
    


NB overlapping regions are not given special treatment, the layers are blindly superimposed on each other. E.g. as demonstrated with "Norwegian Trench" and "off shelf", or "whole domain" and any other region.


```python

plt.subplot(2,2,1)
mm.quick_plot(mask_list.sel(dim_mask=[0,3]))

plt.subplot(2,2,2)
mm.quick_plot(mask_list.sel(dim_mask=[1,2,4,5,6,7,8]))



plt.tight_layout()
```


    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_21_0.png)
    



```python
# Show overlap
mask_list.mask.sum(dim='dim_mask').plot( levels=(1,2,3,4))

# Save if required
#plt.savefig('tmp.png')
```




    <matplotlib.collections.QuadMesh at 0x7fda7c8b5040>




    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_22_1.png)
    


# Regional analysis

Average stratification object over regions using the mask


```python
mask_means = (strat.dataset*mask_list.mask).mean(dim='x_dim').mean(dim='y_dim')
```


```python
mask_means
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
Dimensions:       (t_dim: 7, dim_mask: 9)
Coordinates:
    time          (t_dim) datetime64[ns] 2015-08-01T12:00:00 ... 2015-08-07T1...
    region_names  (dim_mask) &lt;U18 &#x27;whole domain&#x27; &#x27;north sea&#x27; ... &#x27;kattegat&#x27;
Dimensions without coordinates: t_dim, dim_mask
Data variables:
    PEA           (t_dim, dim_mask) float64 130.9 4.603 7.291 ... 0.2 1.515</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-48910417-f285-4938-8e22-08fcd906f50f' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-48910417-f285-4938-8e22-08fcd906f50f' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>t_dim</span>: 7</li><li><span>dim_mask</span>: 9</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-0cb73576-037a-4e95-ad54-ae29ba2a0fe2' class='xr-section-summary-in' type='checkbox'  checked><label for='section-0cb73576-037a-4e95-ad54-ae29ba2a0fe2' class='xr-section-summary' >Coordinates: <span>(2)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>time</span></div><div class='xr-var-dims'>(t_dim)</div><div class='xr-var-dtype'>datetime64[ns]</div><div class='xr-var-preview xr-preview'>2015-08-01T12:00:00 ... 2015-08-...</div><input id='attrs-03f3b73c-e09d-4d66-ba4c-b2cfe62e2e2f' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-03f3b73c-e09d-4d66-ba4c-b2cfe62e2e2f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-d58022cd-8acc-423d-999b-85de4eb87174' class='xr-var-data-in' type='checkbox'><label for='data-d58022cd-8acc-423d-999b-85de4eb87174' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;2015-08-01T12:00:00.000000000&#x27;, &#x27;2015-08-02T12:00:00.000000000&#x27;,
       &#x27;2015-08-03T12:00:00.000000000&#x27;, &#x27;2015-08-04T12:00:00.000000000&#x27;,
       &#x27;2015-08-05T12:00:00.000000000&#x27;, &#x27;2015-08-06T12:00:00.000000000&#x27;,
       &#x27;2015-08-07T12:00:00.000000000&#x27;], dtype=&#x27;datetime64[ns]&#x27;)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>region_names</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>&lt;U18</div><div class='xr-var-preview xr-preview'>&#x27;whole domain&#x27; ... &#x27;kattegat&#x27;</div><input id='attrs-fdcfdc26-6190-4d5a-86cf-a1b00eca3bce' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-fdcfdc26-6190-4d5a-86cf-a1b00eca3bce' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-98649b32-42d9-43c1-bcf7-40ae8770da91' class='xr-var-data-in' type='checkbox'><label for='data-98649b32-42d9-43c1-bcf7-40ae8770da91' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;whole domain&#x27;, &#x27;north sea&#x27;, &#x27;outer shelf&#x27;, &#x27;norwegian trench&#x27;,
       &#x27;english_channel&#x27;, &#x27;southern north sea&#x27;, &#x27;off shelf&#x27;, &#x27;irish sea&#x27;,
       &#x27;kattegat&#x27;], dtype=&#x27;&lt;U18&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-d4aa864d-1908-4ae4-900e-539f9ef7615e' class='xr-section-summary-in' type='checkbox'  checked><label for='section-d4aa864d-1908-4ae4-900e-539f9ef7615e' class='xr-section-summary' >Data variables: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>PEA</span></div><div class='xr-var-dims'>(t_dim, dim_mask)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>130.9 4.603 7.291 ... 0.2 1.515</div><input id='attrs-8c0c1efe-0d46-41c6-800a-dda44399e33e' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-8c0c1efe-0d46-41c6-800a-dda44399e33e' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-7fc5cf65-9f71-4acd-b68f-daabad758f51' class='xr-var-data-in' type='checkbox'><label for='data-7fc5cf65-9f71-4acd-b68f-daabad758f51' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[1.30916778e+02, 4.60319390e+00, 7.29133802e+00, 4.87328452e+00,
        1.86755557e-02, 9.19478955e-03, 9.38408275e+01, 2.44648604e-01,
        1.32291293e+00],
       [1.31934762e+02, 4.59488977e+00, 7.29398806e+00, 4.90655235e+00,
        1.34047455e-02, 1.09749620e-02, 9.47021952e+01, 2.34636159e-01,
        1.32593099e+00],
       [1.32240350e+02, 4.61894369e+00, 7.23246229e+00, 4.97020616e+00,
        8.24792882e-03, 1.33438569e-02, 9.47440462e+01, 2.19935778e-01,
        1.34479243e+00],
       [1.31918865e+02, 4.58682141e+00, 6.99703691e+00, 5.03201431e+00,
        3.11593631e-03, 9.17380711e-03, 9.45179690e+01, 1.86388858e-01,
        1.38896404e+00],
       [1.32366413e+02, 4.58319286e+00, 6.95973607e+00, 5.06030538e+00,
        4.62015801e-03, 9.67444216e-03, 9.48000642e+01, 1.78150915e-01,
        1.43133638e+00],
       [1.33096851e+02, 4.63414011e+00, 7.01034901e+00, 5.09818466e+00,
        4.11897468e-03, 1.53162245e-02, 9.51967685e+01, 1.84249610e-01,
        1.47217418e+00],
       [1.33326898e+02, 4.69542596e+00, 7.09799514e+00, 5.12931482e+00,
        1.02993260e-02, 1.97539883e-02, 9.51643326e+01, 1.99957701e-01,
        1.51491690e+00]])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-6a973792-a296-4f11-85c2-d2bff12af86b' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-6a973792-a296-4f11-85c2-d2bff12af86b' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-09812944-26cf-44fe-a69a-8f32fea258a2' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-09812944-26cf-44fe-a69a-8f32fea258a2' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>




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




    <matplotlib.legend.Legend at 0x7fda7c982df0>




    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_26_1.png)
    

