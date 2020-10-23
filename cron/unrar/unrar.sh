#!/usr/bin/env bash

DIR="$1"

function extractRar() {
    _DIRNAME="$1"
    _RAR="$2"
    _FILES="$3"

    while read -r FILE; do
        if [ ! -f "$_DIRNAME/$FILE" ]; then
            echo "Extracting"
            unrar x $_RAR $_DIRNAME
        fi
    done <<< "$_FILES";
}

echo "Starting UNRAR"

while IFS=  read -r -d $'\0'; do
    echo "=> $(basename $REPLY)"

    DIRNAME=$(dirname $REPLY)
    FILES=$(unrar lb $REPLY | grep -v '.txt' | grep -v '.nfo')

    extractRar $DIRNAME $REPLY $FILES
done < <(find $DIR -name '*.rar' -print0)

echo "UNRAR Done"
