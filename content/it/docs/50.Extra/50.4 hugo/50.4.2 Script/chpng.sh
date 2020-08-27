#!/bin/bash
# convert all png tags in hugo-format
nchar=$(echo $DIRBASE | wc -c)
echo numero caratteri $nchar
echo IMAGES $IMAGES
# qui comincia la conversione dei link alle immagini
            # e la copia di queste nella cartella:
            # SITE/static/images......
            
            pattern="img src"
            FILE=/tmp/temp.log
            # piccolo trucco sporco per evitare i casini con gli spazi
            grep  "$pattern" "$1"  >$FILE
            echo trovate $(wc -l $FILE|cut -d " " -f1 ) occorrenze
            while read LINE
                do 
                echo
                echo myline is "$LINE"
                echo dirbase $DIRBASE
                echo percorso originale $(dirname $1)
                PATH_PNG=$(dirname $1)
                # do per scontato che ci sia solo il nome
                # fixme: considerre tutto l'indirizzo
                NAME_PNG=$(echo $LINE |awk -F'\"' '{ print $2}')
                FULL_PATH_PNG="$PATH_PNG/$NAME_PNG"
                echo my image is "$NAME_PNG"
                echo full path $FULL_PATH_PNG >/tmp/fullpath.txt
                
                #La nuova cartella per le immagini di questo file
                echo dirbase $DIRBASE
                echo images  $IMAGES
                echo originale $1
                # QUESTO NON FUNZIONA!!!!!!!!!!!!!!!!!
                #echo $FULL_PATH_PNG | sed s+"$DIRBASE"+"$IMAGES"+g
                echo $FULL_PATH_PNG | sed s+"content"+"static/images"+g
                
                exit
                newfullpathpng=$(echo $FULL_PATH_PNG | sed s+"$DIRBASE"+"$IMAGES"+g)
                echo -e "nuovo percorsso immagine---->\n" $newfullpathpng
                newpathpng=$(dirname $newfullpathpng)
                echo -e "solo la directory \n----->"  $newpathpng
                exit
                # verifico che ci sia la cartella giusta
                if [ -d "$newpathpng" ]
                then
                  # se c'è non faccio niente
                    echo GIA PRESENTE
                  # altrimenti creo la cartella
                else
                    echo cp "$FULL_PATH_PNG" "$newpathpng"
                #copio qui l'immagine
                fi
                
                dir=$(echo "$FULL_PATH_PNG" | cut -c $nchar-1000)
                echo Immagine $dir/$NAME_PNG
                newline="![$NAME_PNG](/$dir/$NAME_PNG)"
                echo Nuova Riga $newline
                sed -i "/$pattern/ c\ $newline" "$1"  # le doppie virgolette permettono le variabili!!
                
            done < $FILE
