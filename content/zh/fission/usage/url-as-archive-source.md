---
title: "Use URL as archive source when creating functions/packages"
weight: 7
---

Previously, the CLI tends to download the file and upload it to internal storagsvc to persist when a 
user provides URL as archive source while creating the package. This approach increases the total 
package creation time if the file size is large.

With 1.7.0+, the CLI embeds the given URL in package archive directly. This approach brings couple benefits:

* Shorten package creation time.
* Increase the portability of fission spec file.

```bash
$ fission pkg create --spec --name dummy-package2 --env nodejs \
    --code https://raw.githubusercontent.com/fission/fission/master/examples/nodejs/hello.js
```

which results in

```yaml
apiVersion: fission.io/v1
kind: Package
metadata:
  creationTimestamp: null
  name: dummy-package2
  namespace: default
spec:
  deployment:
    checksum: {}
    type: url
    url: https://raw.githubusercontent.com/fission/fission/master/examples/nodejs/hello.js
    ....
```

You will notice the CLI still tends to download the file in order to generate the SHA256 checksum to
prevent the file changed.

```
Downloading file to generate SHA256 checksum. To skip this step, please use --srcchecksum / --deploychecksum / --insecure
```

You can either use `--srcchecksum` or `--deploychecksum` or `--insecure` to bypass the download steps.
