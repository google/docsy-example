---
title: "Logging"
linkTitle: "Logging"
weight: 1
description: >
  Python logging diagnostics guidance.
---

COAsT utilises Python’s default logging library and includes a simple setup function for those unfamiliar with how to use it.

```python
import coast

coast.logging_util.setup_logging()
```
This is all you need to enable full logging output to the console.

By default, setup_logging will use the "DEBUG" logging level, if you want to adjust this, you can use the flags from the logging library.
```python
import coast
import logging

coast.logging_util.setup_logging(level=logging.INFO)
```

Alternative logging levels in increasing levels of severity. Note logs are reported at the chosen severity level and higher:

```python
..., level=logging.DEBUG)
# Detailed information, typically of interest only when diagnosing problems.
..., level=logging.INFO)
# Confirmation that things are working as expected.
..., level=logging.WARNING)
# An indication that something unexpected happened, or indicative of some problem in the near future (e.g. ‘disk space low’). The software is still working as expected.
..., level=logging.ERROR)
# Due to a more serious problem, the software has not been able to perform some function
..., level=logging.CRITICAL)
# A serious error, indicating that the program itself may be unable to continue running
```


For more info on logging levels, see the [relevant Python documentation](https://docs.python.org/3/library/logging.html).

Logging output will be printed in the console once enabled by default, but output can be directed to any Stream, for instance, to an opened file.
```python
import coast

file = open("coast.log", "w")
coast.logging_util.setup_logging(stream=file)
coast.logging_util.info("Hello World!")  # Your use of COAsT would go here, this line is included as an example
file.close()
```
