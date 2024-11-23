#!/usr/bin/env bash

# Copyright (c) 2024 Rodrigo Polo
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

# Modifying the internal field separator
IFS=$'\t\n'

for file in "$@"; do
    dir=$(dirname "$file")
    filename=$(basename "$file")
    
    # First check if filename matches the expected IMG_YYYYMMDD_HHMMSS pattern
    if [[ ! "$filename" =~ ^IMG_[0-9]{8}_[0-9]{6} ]]; then
        echo "Skipping $filename - doesn't match expected date format"
        continue
    fi
    
    filename_no_ext="${filename%.*}"
    extension="${file##*.}"
    date=$(echo "$filename" | sed -e 's/IMG_\([0-9]\{8\}\)_\([0-9]\{6\}\).*/\1/')
    time=$(echo "$filename" | sed -e 's/IMG_[0-9]\{8\}_0*\([0-9]\{6\}\).*/\1/')
    
    # Additional validation - check if date is valid
    if ! date -j -f "%Y%m%d" "$date" >/dev/null 2>&1; then
        echo "Skipping $filename - invalid date"
        continue
    fi
    
    # If we get here, the date format is valid, proceed with renaming
    formatted_date=$(date -j -f "%Y%m%d" "$date" "+%Y-%m-%d")
    formatted_time="${time:0:2}.${time:2:2}.${time:4:2}"
    rest_of_filename=$(echo "$filename" | sed "s/_${date}//g" | sed "s/_${time}//g" | sed "s/00_//g")
    new_filename="${formatted_date} ${formatted_time} - ${rest_of_filename}"
    mv "$file" "${dir}/${new_filename}"
done
