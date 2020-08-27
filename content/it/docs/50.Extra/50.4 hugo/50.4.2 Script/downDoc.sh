CMD="SELECT path,filename,msgtext FROM lit_ctxhelpmsg_v order by path"
FILE=listadocs
BASEDIR=$(zenity --file-selection --directory --title="SALVAMI SU NEXTCLOUD" --filename="$HOME")
#BASEDIR="$HOME/doc-idempiere"
echo $BASEDIR
#  alias tunnel18='ssh -fNT -L 5433:127.0.0.1:5432 root@5.189.165.60 -p 1822'
rm -rf "$BASEDIR" 2>&1
mkdir "$BASEDIR"

psql -d postgresql://127.0.0.1:5326/idempiereTest -U adempiere -w -c "$CMD"> $FILE
while IFS="|" read -r DOCPATH DOCFILENAME DOCMSG
    do
    if [ -n "$DOCPATH" ] && [ -n "$DOCFILENAME" ] && [ "$DOCPATH" != "path" ]
    then
        DOCFILENAME=$(echo "$DOCFILENAME"|tr -d " ")
        DOCPATH=$(echo "$DOCPATH"|tr -d " ")
#        echo $DOCMSG

        echo creo "$DOCPATH"
        mkdir -p "$BASEDIR$DOCPATH"
        echo "$DOCMSG">"$BASEDIR$DOCPATH/$DOCFILENAME"

    else
        echo "££££££££££££££££££££££££££££££££££££"
    fi
done < "$FILE"  #|grep 617130f1-a299-4abf-ac9c-7c0145d98e41

