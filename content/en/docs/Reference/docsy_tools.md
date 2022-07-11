---
title: "Docsy_tools"
linkTitle: "Docsy_tools"
date: 2022-07-11
description: >
  Docstrings for the Docsy_tools class
---
### Objects

[DocsyTools()](#docsytools)<br />
[DocsyTools.write_class_to_markdown()](#docsytoolswrite_class_to_markdown)<br />
[DocsyTools._method_to_str()](#docsytools_method_to_str)<br />
[DocsyTools._get_list_of_methods()](#docsytools_get_list_of_methods)<br />

A class to help with writting markdown.
#### DocsyTools()
```python
class DocsyTools():
```

```
DocsyTools Class
```

##### DocsyTools.write_class_to_markdown()
```python
@classmethod
def DocsyTools.write_class_to_markdown(cls, class_to_write, fn_out, method_to_omit=unknown, omit_private_methods=True, omit_parent_methods=True):
```
> <br />
> None<br />
> <br />
##### DocsyTools._method_to_str()
```python
@classmethod
def DocsyTools._method_to_str(cls, method_name):
```
> <br />
> None<br />
> <br />
##### DocsyTools._get_list_of_methods()
```python
@classmethod
def DocsyTools._get_list_of_methods(cls, class_to_search, methods_to_omit=unknown, omit_private_methods=True, omit_parent_methods=True):
```
> <br />
> Method get a list of methods inside a provided COAsT class, with some other options.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  class_to_search (Type): Class imported from COAsT (e.g. from coast import Profile)<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  methods_to_omit (List): List of method strings to omit from the output. The default is [].<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  omit_private_methods (bool): If true, omit methods beginning with "_". The default is True.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  omit_parent_methods (bool): If true, omit methods in any parent/ancestor class. The default is True.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  List[str]: List of strings denoting method names.<br />
> <br />