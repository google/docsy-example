        RANGE=5

argument=$1
UU=$(echo "$argument" |cut -d'.' -f2)
#content=$(cat "$argument")

scrape_dir(){
local dirfilename=$1
if [ -d $dirfilename ]
then
#    echo "---$dirfilename è una directory"
    for element in "$dirfilename"/*
    do
#        echo "  ---processo $element"
        scrape_dir "$element"
#        echo "  --- processato"
    done

else
#    echo "---$dirfilename è un file"
    # test on file type, not in the extension
    filetype="$(file -b  $dirfilename|cut -d',' -f1)"
#    echo $filetype
    case $filetype in
    "HTML document" )
        UU=$(echo "$dirfilename" |cut -d'.' -f2)
        content=$(cat "$dirfilename")
        CMD="UPDATE ctxmsg_trl set msgtext = $content WHERE UU=$UU"
        psql -d postgresql://127.0.0.1:5433/idempiere -U adempiere -w -c $CMD
 #       echo $content
         ;;
    # I could use this metho to test directory but is less readable
    "empty" )
        n1=$RANDOM
        let "n1 %= $RANGE"
        n2=$RANDOM
        let "n2 %= $RANGE"
        n3=$RANDOM
        let "n3 %= $RANGE"
#        echo "$dirfilename vuoto riempio $n3"
        cat >"$dirfilename" <<EOF
<!DOCTYPE html>
<html>
<body>

<h$n1>first Heading</h$n1>
<h$n2>second Heading</h$n2>
<h$n3>third Heading</h$n3>
<p>My first $n1.</p>
<p>My second $n2.</p>
<p>My third $n3.</p>

</body>
</html>
HTM
<p>$n3</p>
EOF
        
;;
    "directory" )
        echo $directory 

    *)
        echo "$dirfilename non gestito"
    esac

fi


}

scrape_dir $argument
