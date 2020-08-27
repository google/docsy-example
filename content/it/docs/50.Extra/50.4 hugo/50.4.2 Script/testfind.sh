# in input la directory base del che voglio sistemare
# quindi $directory conterrà content/,static/, archetypes....
HUGOdirectory=$1

dosomething(){
echo "$1"
#./chlinks.sh "$1"
}

mvpng(){
# per esempio:
#content/8.Contabilità e Controllo di Gestione/11.Contabilità e Controllo di Gestione/12.Cespite/12.01 Setup Ammortamento Cespite/Cespite1.md
    filenameMD=$1
    echo processo $filenameMD
    pattern="img src"
    FILE=/tmp/temp.log
    # piccolo trucco sporco per evitare i casini con gli spazi
    #grep  "$pattern" "$1"  >$FILE
    grep  "png" "$1" > $FILE
    grep  "jpg" "$1" >> $FILE
    grep  "jpeg" "$1" >> $FILE
    grep  "gif" "$1" >> $FILE
    grep  "tiff" "$1" >> $FILE
    
    echo trovate $(wc -l $FILE|cut -d " " -f1 ) occorrenze
    while read LINE
        do 
            echo linea $LINE
        done < $FILE
    
    echo finito
}

cd $HUGOdirectory

find content  -type f -name *.md| while read myfile; do mvpng "$myfile"; done




















#export -f dosomething
#find $directory -type f -name *.md  -exec bash -c 'dosomething "$0"' {} \;
