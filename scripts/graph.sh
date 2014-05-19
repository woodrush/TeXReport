#!/bin/bash

source ./scripts/config.sh

#======================================================================
SOURCEFILE=$1

usage () {
    echo -e "Usage: ./graph.sh [filename]"
    echo -e "    [filename] : preferred filename."
    # echo -e "    * Be sure to \x1b[1;34mescape '\$' signs\x1b[0m (like $ to \\$) when using TeX equations."
}
available () {
    echo -e ""
    echo -e "\x1b[1;1mAvailable graphs:\x1b[0m"
    ls $GRAPHSDIR | grep .*\.tex
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
    # echo '\begin{figure}[H]'
    # echo '    \centering'
    # echo '    \resizebox{0.6\hsize}{!}{\input{graphs/'"$FILENAME"'}}'
    # echo '    \caption{caption}'
    # echo '    \label{graphs/'"$FILENAME"'}'
    # echo '\end{figure}'
    echo '\inputgraph{['"$FILENAME"']}{CAPTION_TEX}{WIDTH_RATIO}'
    echo -e -n "\x1b[0m"
}

#======================================================================
FILENAME=`echo "$SOURCEFILE" | sed -e "s/$GRAPHGENDIR\///" | sed -e 's/\.m$//'`
if [ "$FILENAME" = "" ]; then error; fi
[ -f "$SOURCEFILE" ] || error "file $SOURCEFILE does not exist."
echo "Generating graph from $SOURCEFILE ..."
cd $GRAPHGENDIR
$OCTAVE -qf ../$SOURCEFILE

cd ../
[ -f "$GRAPHGENDIR/graph.tex" ] || error "$GRAPHGENDIR/graph.tex has not been generated for some reason."
# sed -i -e 's/\strut{}\(.*\)}/strut{}\\huge{\1}}/g' "./$GRAPHGENDIR/graph.tex"
sed -i -e 's/\includegraphics{graph}/\includegraphics{.\/'"$GRAPHSDIR"'\/'"$FILENAME"'\.eps}/g' "./$GRAPHGENDIR/graph.tex"
mv "$GRAPHGENDIR/graph.tex" "$GRAPHSDIR/$FILENAME.tex"
mv "$GRAPHGENDIR/graph.eps" "$GRAPHSDIR/$FILENAME.eps"
[ ! -f "$GRAPHGENDIR/graph.tex-e" ] || rm -rf "$GRAPHGENDIR/graph.tex-e"

echo -e "Completed generating graph from target $SOURCEFILE. Use tag below to implement in TeX files:"
showtag