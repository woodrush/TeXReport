#!/bin/bash

source ./scripts/config.sh

#======================================================================
SOURCEFILE=$1

usage () {
    echo -e "Usage: ./table.sh"
    echo -e "    [filename] : preferred filename."
    echo -e "    * Be sure to \x1b[1;34mescape '\$' signs\x1b[0m (like $ to "'\\'"$) when using TeX equations in the TableGen files."
}
available () {
    echo -e ""
    echo -e "\x1b[1;1mAvailable tables:\x1b[0m"
    ls $TABLESDIR | grep .*\.tex
}
error () {
    if [ "$1" != "" ]; then    
        echo -e "\x1b[31;1mError: $1\x1b[0m"
    fi
    usage
    available
    exit 1;
}
showtag () {
    echo -e -n "\x1b[33;1m"
    # echo '\input{tables/'"$FILENAME"'}'
    echo '\inputtable{'"$FILENAME"'}{CAPTION_TEX]'
    echo -e -n "\x1b[0m"
}

#======================================================================
FILENAME=`echo "$SOURCEFILE" | sed -e "s/$TABLEGENDIR\///" | sed -e 's/\..*$//'`
if [ "$FILENAME" = "" ]; then error; fi
[ -f "$SOURCEFILE" ] || error "table source file $SOURCEFILE does not exist."
OUTFILE="$TABLESDIR/$FILENAME.tex"

echo -e "Generating table from $SOURCEFILE ..."

echo -n ''                          >  $OUTFILE
# echo '\begin{table}[H]'             >> $OUTFILE
# echo '\caption{caption}'            >> $OUTFILE
# echo '\label{tables/'"$FILENAME}"   >> $OUTFILE
# echo '\centering'                   >> $OUTFILE
# echo '\small'                       >> $OUTFILE

firstflag="1"
while read line
do
    split=`echo "$line" | sed -e 's/	/ \& /g'`
    if [ "$firstflag" == "1" ]; then
        # Print the number of rows
        r=""
        for i in `echo "$line" |  sed -e 's/	/ /g'`
        do
            r="$r""r"
        done
        echo '\begin{tabular}{'"$r"'}'  >> $OUTFILE
        echo '    \hline'               >> $OUTFILE
        echo '    \hline'               >> $OUTFILE
        echo '    '"$split"'\\'         >> $OUTFILE
        echo '    \hline'               >> $OUTFILE
        firstflag="0"
    else
        echo '    '"$split"'\\'         >> $OUTFILE
    fi
done < "$SOURCEFILE"
echo '    \hline'    >> $OUTFILE
echo '\end{tabular}' >> $OUTFILE
# echo '\end{table}' >> $OUTFILE

echo -e "Completed generating table from source $SOURCEFILE. Use tag below to implement in TeX files:"
showtag