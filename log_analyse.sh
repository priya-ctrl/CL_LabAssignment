#!/bin/bash

# Check argument count
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one log file."
    exit 1
fi

LOGFILE="$1"

# Check if file exists and is readable
if [ ! -f "$LOGFILE" ] || [ ! -r "$LOGFILE" ]; then
    echo "Error: File does not exist or is not readable."
    exit 1
fi

# Counts
total=$(wc -l < "$LOGFILE")
info=$(grep -c " INFO " "$LOGFILE")
warning=$(grep -c " WARNING " "$LOGFILE")
error=$(grep -c " ERROR " "$LOGFILE")

# Most recent ERROR
last_error=$(grep " ERROR " "$LOGFILE" | tail -n 1)

# Report file
date=$(date +%Y-%m-%d)
report="logsummary_${date}.txt"

# Display output
echo "Total log entries: $total"
echo "INFO messages: $info"
echo "WARNING messages: $warning"
echo "ERROR messages: $error"
echo "Most recent ERROR:"
echo "$last_error"

# Write report
{
    echo "Log Summary Report - $date"
    echo "---------------------------"
    echo "Total log entries: $total"
    echo "INFO messages: $info"
    echo "WARNING messages: $warning"
    echo "ERROR messages: $error"
    echo "Most recent ERROR:"
    echo "$last_error"
} > "$report"

echo "Report generated: $report"
