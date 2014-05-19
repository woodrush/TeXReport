#!/bin/bash

source ./scripts/config.sh

showtag () {
    echo -e -n "\x1b[33;1m"
    echo '\inputfig{'"$FILENAME"'}{CAPTION_TEX}{WIDTH_RATIO}'
    echo -e -n "\x1b[0m"
}

#======================================================================
SOURCEFILE=$1
FILENAME=`echo "$SOURCEFILE" | sed -e "s/.*\/\(.*\)$/\1/" | sed -e 's/\..*$//'`
if [ "$SOURCEFILE" = "" ]; then error; fi
[ -f "$SOURCEFILE" ] || error "file $SOURCEFILE does not exist."

if [[ "$SOURCEFILE" =~ \.bb$ ]]; then
	echo -n "";
else
	$EBB $SOURCEFILE;
	echo -e "Completed conversion of image $SOURCEFILE. Use tag below to implement in TeX files:"
	showtag
fi;
