#!/bin/bash

# Check argument
if [ "$#" -ne 1 ]; then
    echo "Error: Provide one directory path"
    exit 1
fi

DIR="$1"

# Validate directory
if [ ! -d "$DIR" ]; then
    echo "Error: Directory not found"
    exit 1
fi

# Create backup directory
mkdir -p "$DIR/backup"

echo "Script PID: $$"

# Move files in background
for file in "$DIR"/*
do
    if [ -f "$file" ]; then
        mv "$file" "$DIR/backup/" &
        echo "Moved $(basename "$file") in background. PID: $!"
    fi
done

# Wait for all background jobs
wait

echo "All background move operations completed."
