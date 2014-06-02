#!/bin/bash

source ./scripts/config.sh

#======================================================================
# SOURCEFILE=$1

# usage () {
#     echo -e "Usage: ./table.sh"
#     echo -e "    [filename] : preferred filename."
#     echo -e "    * Be sure to \x1b[1;34mescape '\$' signs\x1b[0m (like $ to "'\\'"$) when using TeX equations in the TableGen files."
# }
# available () {
#     echo -e ""
#     echo -e "\x1b[1;1mAvailable tables:\x1b[0m"
#     ls $TABLESDIR | grep .*\.tex
# }
# error () {
#     if [ "$1" != "" ]; then    
#         echo -e "\x1b[31;1mError: $1\x1b[0m"
#     fi
#     usage
#     available
#     exit 1;
# }
# showtag () {
#     echo -e -n "\x1b[33;1m"
#     # echo '\input{tables/'"$FILENAME"'}'
#     echo '\inputtable{'"$FILENAME"'}{CAPTION_TEX]'
#     echo -e -n "\x1b[0m"
# }

#======================================================================
echo "" > ./scripts/grandbibtex.bib
[ ! -f "./$BIBTEXDIR/*" ] || exit 0;
for f in ./$BIBTEXDIR/*
do
  cat $f >> ./scripts/grandbibtex.bib
done
