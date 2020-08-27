#!/bin/bash

# solo per test: analizzo la stringa in input per capire se ha solo un gruppo di cifre

second_position=$(awk -F'.' '{print $2}' <<<$1)

re='^[0-9]+$'
if ! [[ $second_position =~ $re ]] ; then
   echo "Not a number" >&2
   echo "hugo --kind chapter new"
else
    echo "hugo new"
fi
