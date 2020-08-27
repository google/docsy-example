#!/bin/bash
# usage make-logo.sh logo.png
# create an output logo.html ready to use in learn -theme of Hugo site generator.
# place this file in Hugo-site/layout/partials

NOME="logo.html"

cat >$NOME <<EOF
<a id="logo" href="{{ .Site.BaseURL }}">
<img src="data:image/png;base64,
EOF
base64 $1 >>$NOME
cat >>$NOME <<EOF
" alt="logo idempiere">  </a>
EOF


