#!/bin/bash

if [ ! -f input.txt ]; then
    echo "Error: input.txt not found"
    exit 1
fi

# Convert text to one word per line
words=$(tr -c 'A-Za-z' '\n' < input.txt | tr 'A-Z' 'a-z')

# Longest word
longest=$(echo "$words" | sort -u | awk '{ print length, $0 }' | sort -nr | head -1 | cut -d' ' -f2)

# Shortest word
shortest=$(echo "$words" | sort -u | awk '{ print length, $0 }' | sort -n | head -1 | cut -d' ' -f2)

# Average word length
avg=$(echo "$words" | awk '{ total+=length; count++ } END { if (count>0) print total/count; else print 0 }')

# Unique word count
unique=$(echo "$words" | sort | uniq | wc -l)

echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $avg"
echo "Total unique words: $unique"
