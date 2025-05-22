#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 filename_or_url"
    exit 1
fi

input="$1"
tempfile=""

if [[ "$input" =~ ^https?:// ]]; then
    tempfile=$(mktemp)
    curl -sSf "$input" -o "$tempfile" || { echo "Failed to download $input"; exit 1; }
    filename="$tempfile"
else
    filename="$input"
fi

if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    [ -n "$tempfile" ] && rm -f "$tempfile"
    exit 1
fi

while IFS= read -r line; do

    if [[ -z "$line" ]]; then
        continue
    fi
    if pacman -Si "$line" &>/dev/null; then
        echo "Package '$line' exists."
    else
        echo "Error: Package '$line' does NOT exist."
    fi
done < "$filename"

# Clean up temp file if any
[ -n "$tempfile" ] && rm -f "$tempfile"
