#!/bin/bash

# Check for exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly ONE argument."
    exit 1
fi

PATH_ARG="$1"

# Check if path exists
if [ ! -e "$PATH_ARG" ]; then
    echo "Error: The specified path does not exist."
    exit 1
fi

# If it's a regular file
if [ -f "$PATH_ARG" ]; then
    echo "File analysis for: $PATH_ARG"
    wc "$PATH_ARG"

# If it's a directory
elif [ -d "$PATH_ARG" ]; then
    echo "Directory analysis for: $PATH_ARG"

    # Total number of files (not including directories)
    total_files=$(find "$PATH_ARG" -type f | wc -l)

    # Number of .txt files
    txt_files=$(find "$PATH_ARG" -type f -name "*.txt" | wc -l)

    echo "Total files: $total_files"
    echo "Total .txt files: $txt_files"

else
    echo "Error: Unsupported file type."
    exit 1
fi
