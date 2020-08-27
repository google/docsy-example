#!/bin/bash
set -x

DIRSOURCE=$(zenity --file-selection --directory --title="COPIO DA --> Mnauale Idempiere" --filename="~/consulting-nc/hugo/Manuale iDempiere/")
DIRSITE=$(zenity --file-selection --directory --title="Cartella Hugo file" --filename="/home/milena/consulting-nc/hugo/")


DIRBASE="$DIRSITE/content"
IMAGES="$DIRSITE/static/images"
nchar=$(echo $DIRBASE | wc -c)
echo disource $DIRSOURCE
echo dirbase $DIRBASE

if [ -d "$DIRBASE" ]
then 
    echo Sito già presente.
else
    echo CREO SITO "$DIRSITE"
    hugo new site "$DIRSITE"
fi

cd "$DIRSITE"
#Prepariamo il posto dove mettere le immagini
mkdir "$IMAGES"
echo cartella corrente
pwd
cp -r "$DIRSOURCE" "$DIRBASE"

TIME=0
read 
entra () {

if [ -d "$1" ]      
then
    last_dir=$(awk -F'/' '{print $(NF)}' <<<$1)
    #echo "solo l'ultima directory"
    echo Argomento Funzione "$1"
    echo "---$last_dir"
    sleep $TIME
    # siamo in una directory, verifichiamo se è di primo livello:
    if [ -f  "$1"/_index.md ]
    then 
        echo "INDEX ce già!"
        #echo "lo cancello"
        #rm "$1"/_index.md
        sleep $TIME
       # rm "$1"/_index.md    # TODO  rimuovere riga e  commento sotto per corretto funzionamento
    else                       # FIXME
        echo CREO index
        
        hugo new _index.md #"$1"/_index.md
        #cat "{{%children style="h2" description="true" %}}">>"$1"/_index.md
        read 
    fi
    
    for element in "$1"/* 
    do
        echo "@@@@@@@@@@$element"
        entra "$element"
        read 
    done
    
    
else
    if [ -f "$1" ]
    # è un file, dobbiamo aggiungee l'intestazione corretta per poterlo visualizzare nel sito
    then
        sleep $TIME
        #echo "     $nome"
        # verifico che non sia il file _index.md
        # quindi procedo all'intestazione
        # intesto solo sui file markdown
        nome=$(basename "$1")
        # TODO implementare la creazione automagica dei chapter 
        # non è il modo più sicuro
        #   hugo new --kind chapter basics/_index.md
        if [[ $1 =~ \.md$ &&  "$nome" != "_index.md" ]]             
        then
            DIR=$(dirname "$1")
            read 
            #per intestre il file lo sposto temporaneamente...
            mv "$1" /tmp
            hugo new "$1"           # questo crea l'intestazione su un file vuoto
            cat /tmp/"$nome" >>"$1" # adesso riappendo il contenuto originale
            rm /tmp/"$nome"         # cancellando la copia temporanea
            # modifico tutti i link ai video di vimeo
            ./chlinks.sh "$1"
            # qui comincia la conversione dei link alle immagini
            # e la copia di queste nella cartella:
            # SITE/static/images......
            
            pattern="img src"
            # piccolo trucco sporco per evitare i casini con gli spazi
            FILE=/tmp/temp.log              # cioè uso un file temporaneo in cui 
            grep  "$pattern" "$1"  >$FILE   # salvare le righe delle immagini
            #echo trovate $(wc -l $FILE|cut -d " " -f1 ) occorrenze
            PATH_PNG=$(dirname $1)          # questo è solo il percorso, senza il nome del file,
                                            # mi servirà per spostare le immagini nella cartella static
                                            # mantenendo la gerarchia dei file 
            #La nuova cartella per le immagini di questo file
            newpathpng=$(echo $1 | sed s+"$DIRBASE"+"$IMAGES"+g)
                                            
            while read LINE     # adesso rileggo riga per riga il file 
                do 
                echo
                echo myline is "$LINE"
                echo dirbase $DIRBASE
                echo iiiii $(dirname $1)
                # estraggo il nome dell'immagine
                NAME_PNG=$(echo $LINE |awk -F'\"' '{ print $2}')
                echo my image is "$NAME_PNG"
                                # verifico che ci sia la cartella giusta
                if [ ! -d "$newpathpng" ]
                then
                    # se la directory non esiste già la creo adesso
                    mkdir -p    "$newpathpng"
                    
                fi
                # adesso posso spostare in sicurezza l'mmagine
                mv "$PATH_PNG/$NAME_PNG" "$newpathpng"
                # quindi sostituisco il link originale nel file con quello funzionante per hugo
                dir=$(echo "$DIRBASE" | cut -c $nchar-1000) # estraendo solo la parte del path che eccede /content/
                echo Immagine $dir/$NAME_PNG
                newline="![$NAME_PNG](/$dir/$NAME_PNG)" # questa è la riga che verrà inserita nel file
                echo Nuova Riga $newline
                sed -i "/$pattern/ c\ $newline" "$1"  # le doppie virgolette permettono le variabili!!
                read
            done < $FILE
        fi
        # rimuovo il mio file temporaneo
        rm /tmp/temp.log
        

        
    fi
fi

}


echo "$DIRBASE"
file "$DIRBASE"

entra "$DIRBASE"

