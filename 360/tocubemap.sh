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


# Check if the script has received an argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <pano1.tif> <pano2.tif>..."
    exit 1
fi

for f in $@; do

    # The input tif file path
    input_file="$f"

    prefix="${f%.*}"

    # Define the output names for consistency with your script
    output_png="${prefix}.equirectangular.png"
    cubemap_png="${prefix}.cubemap.png"

    # Change to the directory of the first input file
    cd "$(dirname "$input_file")" || { echo "Failed to change directory"; exit 1; }

    # Check if the file exists
    if [ ! -f "$input_file" ]; then
        echo "Error: File $input_file does not exist."
        exit 1
    fi

    # Extract width from the input file
    width=$(exiftool -s -s -s -ImageWidth "$input_file")

    # Calculate new size (width divided by 4)
    new_size=$((width / 4))

    # Check if the dimensions are valid
    if [ -z "$new_size" ] || [ "$new_size" -eq 0 ]; then
        echo "Error: Could not determine image size or size is zero."
        exit 1
    fi

    # Convert tif to png
    magick "$input_file" -flatten -alpha off "$output_png"

    # Convert equirectangular to cubemap
    convert360 -i "$output_png" -o "$cubemap_png" -s $new_size $new_size -it equirectangular -ot cubemap

    # Crop the cubemap into individual faces
    magick "$cubemap_png" -crop $new_size"x"$new_size +repage "${prefix}_%d.tif"

    # Rename the output files
    mv "${prefix}_1.tif" "${prefix}_Left.tif"
    mv "${prefix}_0.tif" "${prefix}_Right.tif"
    mv "${prefix}_2.tif" "${prefix}_Up.tif"
    mv "${prefix}_3.tif" "${prefix}_Down.tif"
    mv "${prefix}_4.tif" "${prefix}_Front.tif"
    mv "${prefix}_5.tif" "${prefix}_Back.tif"

    # Clean up temporary files if needed
    rm "$output_png" "$cubemap_png"

done

