#!/bin/bash
# ssh -fNT -L 5433:127.0.0.1:5432 root@173.249.22.65 -p 4222
pwd=`pwd`
psql -d postgresql://127.0.0.1:5433/idempiere -U adempiere -w -f  $pwd/sql2.sql

while IFS=',' read -r lvl path name help
do      
        cd "${1}${path}"

        if [ -f "$name.md" ]; then
            rm "$name.md"
        fi
        
            echo '---\ntitle: '"$name"'\n---\n'$help'' >> "$name.md"
        
done < $pwd/listahelp.csv
