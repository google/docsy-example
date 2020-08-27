#!/bin/bash
# ssh -fNT -L 5433:127.0.0.1:5432 root@173.249.22.65 -p 4222
pwd=`pwd`
psql -d postgresql://127.0.0.1:5433/idempiere -U adempiere -w -f  $pwd/test.sql
cat $pwd/help.csv

while IFS=',' read -r name description
do      
        
echo -e  $description> "$name.md"
        
done < $pwd/help.csv
