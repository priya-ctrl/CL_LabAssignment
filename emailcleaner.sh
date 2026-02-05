#!/bin/bash

if [ ! -f emails.txt ]; then
    echo "Error: emails.txt not found"
    exit 1
fi

# Extract valid email addresses
grep -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt > valid_temp.txt

# Remove duplicates from valid emails
sort valid_temp.txt | uniq > valid.txt

# Extract invalid email addresses
grep -v -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt > invalid.txt

# Cleanup
rm valid_temp.txt

echo "Valid emails saved to valid.txt"
echo "Invalid emails saved to invalid.txt"
