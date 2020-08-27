        RANGE=5

argument=$1
UU=$(echo "$argument" |cut -d'.' -f2)

scrape_dir(){
local dirfilename=$1
if [ -d $dirfilename ]
then
    for element in "$dirfilename"/*
    do
        scrape_dir "$element"
    done

else
    # test on file type, not in the extension
    filetype="$(file -b  $dirfilename|cut -d',' -f1)"
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
        echo empty;;
    "directory" )
        # qui non dovrebbe enrtare mai
        echo $directory ;;

    *)
        echo "$dirfilename non gestito"
    esac

fi


}

scrape_dir $argument
