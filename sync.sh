#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Error: Provide two directories"
    exit 1
fi

dirA="$1"
dirB="$2"

if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
    echo "Error: Both arguments must be directories"
    exit 1
fi

echo "Files only in $dirA:"
ls "$dirA" | while read file
do
    if [ ! -f "$dirB/$file" ]; then
        echo "$file"
    fi
done

echo
echo "Files only in $dirB:"
ls "$dirB" | while read file
do
    if [ ! -f "$dirA/$file" ]; then
        echo "$file"
    fi
done

echo
echo "Files with same name but different content:"
ls "$dirA" | while read file
do
    if [ -f "$dirB/$file" ]; then
        cmp -s "$dirA/$file" "$dirB/$file"
        if [ "$?" -ne 0 ]; then
            echo "$file"
        fi
    fi
done
