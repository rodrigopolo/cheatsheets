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

# Exit on undefined variables
set -u

# Modifying the internal field separator
IFS=$'\t\n'

# Check if the script has received an argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <pano1.tif> <pano2.tif>..."
    exit 1
fi

# Divisor calc
round_to_closest_divisor() {
    local number=$1
    local divisor=$2

    # Ensure both inputs are valid
    if [[ -z "$number" || -z "$divisor" || "$divisor" -eq 0 ]]; then
        echo "Error: Invalid input. Usage: round_to_closest_divisor <number> <divisor>"
        return 1
    fi

    # Calculate the rounded value
    local half_divisor=$(echo "$divisor / 2" | bc)
    local rounded=$(echo "scale=0; (($number + $half_divisor) / $divisor) * $divisor" | bc)

    echo "$rounded"
}

# PI
pi=$(echo "scale=10; 4*a(1)" | bc -l)

# Function to create PTO file
create_pto() {
    local prefix="$1"
    local input_file="$2"
    local width="$3"
    local height="$4"
    local cubeface_size="$5"
    local orientation="$6"
    local r="$7"
    local p="$8"
    local y="$9"

    local header="p f0 w${cubeface_size} h${cubeface_size} v90  k0 E0 R0 n\"TIFF_m c:LZW r:CROP\"\nm i0\n"
    local footer="v Ra0\nv Rb0\nv Rc0\nv Rd0\nv Re0\nv Vb0\nv Vc0\nv Vd0\nv\n"
    
    echo -e "${header}i w${width} h${height} f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r${r} p${p} y${y} TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${input_file}\"\n${footer}" > "${prefix}_${orientation}.pto"
}

for input_file in "$@"; do
    # Get the directory of the input file
    dir=$(dirname "$input_file")
    
    # Check if the file exists
    if [ ! -f "$input_file" ]; then
        echo "Error: File $input_file does not exist. Skipping..."
        continue
    fi

    # Change to the input file's directory
    if ! cd "$dir"; then
        echo "Error: Cannot change to directory $dir. Skipping..."
        continue
    fi

    # Get file information
    prefix="${input_file%.*}"
    basename="${input_file##*/}"
    basename="${basename%.*}"

    # Extract dimensions and calculate cubeface size
    height=$(exiftool -s -s -s -ImageHeight "$input_file")
    width=$(exiftool -s -s -s -ImageWidth "$input_file")
    
    if [ -z "$height" ] || [ -z "$width" ]; then
        echo "Error: Could not extract image dimensions from $input_file. Skipping..."
        continue
    fi

    cubeface_size=$(round_to_closest_divisor $(echo "scale=10; ($width / $pi)" | bc) 16)

    # Create PTO files
    create_pto "$prefix" "$input_file" "$width" "$height" "$cubeface_size" "front" "0" "0" "-1.14499968532687e-13"
    create_pto "$prefix" "$input_file" "$width" "$height" "$cubeface_size" "right" "0" "0" "-90.0000000000001"
    create_pto "$prefix" "$input_file" "$width" "$height" "$cubeface_size" "back" "0" "0" "180"
    create_pto "$prefix" "$input_file" "$width" "$height" "$cubeface_size" "left" "0" "0" "89.9999999999999"
    create_pto "$prefix" "$input_file" "$width" "$height" "$cubeface_size" "up" "26.9094996026837" "-90" "-26.9094996026837"
    create_pto "$prefix" "$input_file" "$width" "$height" "$cubeface_size" "down" "-88.244968578448" "90" "-88.244968578448"

    # Process files with nona
    for direction in front right back left up down; do
        direction_prefix=$(echo "$direction" | tr '[:lower:]' '[:upper:]' | cut -c1)$(echo "$direction" | cut -c2-)
        
        if ! nona -o "${basename}_${direction_prefix}" -m TIFF -z LZW "${prefix}_${direction}.pto"; then
            echo "Error: nona processing failed for ${direction} face. Skipping cleanup..."
            continue
        fi
    done

    # Clean up PTO files
    rm -f "${prefix}"_{front,right,back,left,up,down}.pto

    echo "Successfully processed $input_file"
done