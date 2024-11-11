#!/usr/bin/env bash
# Usage: ./joinmosaic.sh ./input_dir ./output_dir

# Get the script name
script_name=$(basename "$0")

# Check if directory argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $script_name <directory> <panoname>"
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
sides=("Left" "Right" "Up" "Down" "Front" "Back")

# Check tile size and set variables
if [ ${#files[@]} -eq 504 ]; then
    imtile=8
    ctile=84
    ctlimit=63
elif [ ${#files[@]} -eq 120 ]; then
    imtile=4
    ctile=20
    ctlimit=15
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
    
    montage $group_files -tile "${imtile}x${imtile}" -geometry "${tilesize}x${tilesize}+0+0" "${panoname}/${side}.tif"
}

# Process each side
for side in "${sides[@]}"; do
    process_side "$side"
done
