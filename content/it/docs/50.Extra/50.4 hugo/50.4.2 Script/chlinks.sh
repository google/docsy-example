#!/bin/bash
# convert all vimeo links in hugo-format
myFile="$1"
pattern="vimeo.com"
# cerco i link a vimeo e li converto in hugo-format
CMD=$(grep  "$pattern" "$myFile"|awk -F'(' '{print $2}' |tr -d ")")



targets=($CMD)
echo ${targets[@]}
for i in "${targets[@]}"
do
    titolo=$(basename "$i")
    echo "$i"
    id=$(wget $i 2>&1|grep Location|cut -c 12-21)
    rm $(basename "$i")
    newline="{{< vimeo $id >}}"
    sed -i "/$titolo/ c\ $newline" "$myFile"  # le doppie virgolette permettono le variabili!!
    
done
