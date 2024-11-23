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

# Usage: ./joinmosaic.sh ./input_dir ./output_dir

# Get the script name
script_name=$(basename "$0")

# Check if directory argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $script_name <jpg_directory> <path_and_prefix_to_tifs>"
    exit 1
fi

# Get directory and panoname from arguments
directory="$1"
panoname="$2"

# Validate directory exists
if [ ! -d "$directory" ]; then
    echo "Directory \"$directory\" does not exist"
    exit 1
fi

# Get jpg files, sort them, and store in array
# Using find to get files and tr to convert newlines to spaces
files=($(find "$directory" -maxdepth 1 -type f -name "*.jpg" -o -name "*.JPG" | sort))

# Get the total number of files before removing last 6
total_files=${#files[@]}

# Remove last 6 tiles
files=("${files[@]:0:$((total_files-6))}")

# Define tile size and sides
tilesize=512
sides=("Right" "Left" "Up" "Down" "Back" "Front")

# Check tile size and set variables
if [ ${#files[@]} -eq 504 ]; then
    imtile=8
    ctile=84
    ctlimit=63
elif [ ${#files[@]} -eq 120 ]; then
    imtile=4
    ctile=20
    ctlimit=15
elif [ ${#files[@]} -eq 24 ]; then
    imtile=2
    ctile=4
    ctlimit=4
else
    echo "Not the right amount of images."
    exit 1
fi

# Process the image tiles
# Instead of associative arrays, we'll use separate variables for each side
counter=0

# Function to process each side
process_side() {
    local side=$1
    local group_files=""
    
    for ((j=0; j<ctile; j++)); do
        if [ $j -le $ctlimit ]; then
            if [ -z "$group_files" ]; then
                group_files="${files[$counter]}"
            else
                group_files="$group_files ${files[$counter]}"
            fi
        fi
        ((counter++))
    done
    
    montage $group_files -tile "${imtile}x${imtile}" -geometry "${tilesize}x${tilesize}+0+0" "${panoname}_${side}.tif"
}

# Process each side
for side in "${sides[@]}"; do
    process_side "$side"
done
