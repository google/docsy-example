---
title: "Config_parser"
linkTitle: "Config_parser"
date: 2022-06-24
description: >
  Docstrings for the Config_parser class
---
### Objects

[ConfigParser()](#configparser)<br />
[ConfigParser._parse_gridded()](#configparser_parse_gridded)<br />
[ConfigParser._parse_indexed()](#configparser_parse_indexed)<br />
[ConfigParser._get_code_processing_object()](#configparser_get_code_processing_object)<br />
[ConfigParser._get_datafile_object()](#configparser_get_datafile_object)<br />

Config parser.
#### ConfigParser()
```python
class ConfigParser():
```

```
Class for parsing gridded and indexed configuration files.
```

##### ConfigParser._parse_gridded()
```python
@staticmethod
def ConfigParser._parse_gridded(json_content):
```
> <br />
> Static method to parse Gridded config files.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  json_content (dict): Config file json.<br />
> <br />
##### ConfigParser._parse_indexed()
```python
@staticmethod
def ConfigParser._parse_indexed(json_content):
```
> <br />
> Static method to parse Indexed config files.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  json_content (dict): Config file json.<br />
> <br />
##### ConfigParser._get_code_processing_object()
```python
@staticmethod
def ConfigParser._get_code_processing_object(json_content):
```
> <br />
> Static method to convert static_variables configs into objects.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  json_content (dict): Config file json.<br />
> <br />
##### ConfigParser._get_datafile_object()
```python
@staticmethod
def ConfigParser._get_datafile_object(json_content, data_file_type):
```
> <br />
> Static method to convert dataset and domain configs into objects.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  json_content (dict): Config file json.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  data_file_type (str): key of datafile type (dataset or domain).<br />
> <br />