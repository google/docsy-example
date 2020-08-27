#!/bin/bash
# usage: upDB.sh directory/to/update/html
argument="$1"
# ATTENZIONE!!!!!   usare solo internamente, rischio di sql injection

scrape_dir(){
local dirfilename="$1"
if [ -d "$dirfilename" ]
then
    for element in "$dirfilename"/*
    do
        scrape_dir "$element"
    done

else
    # se non è una directory dovrei testare se è un file? boh, forse anche si
    extension=$(echo $filename|awk -F'.' '{print $(NF)}')
    if [ "$extension"=html ]
    then
        # ovviamente do per scontato che nessuno si metta ad aggiungere file di propria sponte
        filename=$(basename "$dirfilename")
        UU=$(echo "$filename" |cut -d'.' -f1)
        UU="'$UU'"

        #alias rxvt='urxvt -fg '"'"'#111111'"'"' -bg '"'"'#111111'"'"
         #                     ^^^^^       ^^^^^     ^^^^^       ^^^^
         #                     12345       12345     12345       1234



        content=$(cat "$dirfilename"|sed s/"'"/"''"/g)
        #echo $content
        #echo "$CMD"

        CMD="UPDATE ad_ctxhelpmsg_trl SET msgtext ='""$content""' WHERE ad_ctxhelpmsg_trl_uu=""$UU"
        echo $CMD
        psql -d postgresql://127.0.0.1:5433/idempiereTest -U adempiere -w -c "$CMD"

    fi

fi
}
scrape_dir "$argument"
