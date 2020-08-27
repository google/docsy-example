#!/bin/bash
# only for readability
directory=$1
#echo $directory
#UU=$(echo "$argument" |cut -d'.' -f2)

updatemydb(){
echo $1|cut -d'.' -f1
}

#find $directory -type f -name *.html   | while read filename ; do grep XXX $filename | wc -l ; done
#find $directory -type f -name *.html | xargs updatemydb 
#find $directory -type f -name *.html -exec updatemydb {} \;
#find $directory -type f -name *.html -exec echo {} \;
find $directory -type f -name *.html
for filename in $(find $directory -type f -name *.html -print)
do
echo $filename
done
