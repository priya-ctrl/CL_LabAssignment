#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: Provide one input file"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: File not found"
    exit 1
fi

# Convert text into lowercase words (one per line)
tr -c 'A-Za-z' '\n' < "$1" | tr 'A-Z' 'a-z' > words.txt

# Only vowels
grep -E '^[aeiou]+$' words.txt > vowels.txt

# Only consonants
grep -E '^[bcdfghjklmnpqrstvwxyz]+$' words.txt > consonants.txt

# Mixed words starting with a consonant
grep -E '^[bcdfghjklmnpqrstvwxyz][a-z]*$' words.txt | \
grep -E '[aeiou]' > mixed.txt

# Cleanup
rm words.txt

echo "Output generated:"
echo "vowels.txt"
echo "consonants.txt"
echo "mixed.txt"
