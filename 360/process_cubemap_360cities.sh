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

# Function to show usage
show_usage() {
    echo "Usage: $0 <directory> <output_prefix>"
    echo "Example: $0 /path/to/cubemap/images"
    exit 1
}

# Check if directory argument is provided
if [ $# -ne 2 ]; then
    show_usage
fi

# Get and validate directory path
input_dir="$1"
prefix="$2"

# Check if directory exists
if [ ! -d "$input_dir" ]; then
    echo "Error: Directory '$input_dir' does not exist"
    exit 1
fi

# Convert to absolute path and remove trailing slash
input_dir=$(cd "$input_dir" && pwd)

# Array of cubemap sides
sides=("back" "down" "front" "left" "right" "up")

# Calculate grid size based on number of images
calculate_grid_size() {
    local dir="$1"
    local total_images=$(find "$dir" -maxdepth 1 -name "*.jpg" | wc -l)
    local images_per_face=$((total_images / 6))
    
    # Calculate grid size (square root of images per face)
    local grid_size=$(echo "sqrt($images_per_face)" | bc)
    
    # Verify the calculation
    if [ $((grid_size * grid_size * 6)) -ne $total_images ]; then
        echo "Error: Invalid number of images in $dir"
        echo "Found $total_images images ($(($total_images / 6)) per face)"
        echo "Number of images must be a perfect square times 6"
        echo "Valid examples:"
        echo "3x3 (54 images)"
        echo "4x4 (96 images)"
        echo "5x5 (150 images)"
        exit 1
    fi
    
    echo $grid_size
}

# Function to process a single side of the cubemap
process_side() {
    local dir="$1"
    local side="$2"
    local grid_size="$3"
    local last_index=$((grid_size - 1))
    
    echo "Processing ${side} side (${grid_size}x${grid_size} grid)..."

    # Get dimensions of edge pieces using exiftool
    local last_col_width=$(exiftool -s -s -s -ImageWidth "${dir}/${side}-0-${last_index}.jpg")
    local last_row_height=$(exiftool -s -s -s -ImageHeight "${dir}/${side}-${last_index}-0.jpg")
    
    # Calculate final dimensions for cropping
    local total_width=$((512 * (grid_size - 1) + last_col_width))
    local total_height=$((512 * (grid_size - 1) + last_row_height))

    echo "Grid dimensions: ${total_width}x${total_height}"

    # Process regular tiles
    for ((row=0; row<grid_size-1; row++)); do
        for ((col=0; col<grid_size-1; col++)); do
            magick "${dir}/${side}-${row}-${col}.jpg" "${dir}/${side}-${row}-${col}.tif"
        done
    done

    # Process last column (except corner)
    for ((row=0; row<grid_size-1; row++)); do
        magick "${dir}/${side}-${row}-${last_index}.jpg" -background none -gravity west -extent 512x512 "${dir}/${side}-${row}-${last_index}.tif"
    done

    # Process last row (except corner)
    for ((col=0; col<grid_size-1; col++)); do
        magick "${dir}/${side}-${last_index}-${col}.jpg" -background none -gravity north -extent 512x512 "${dir}/${side}-${last_index}-${col}.tif"
    done

    # Process corner piece
    magick "${dir}/${side}-${last_index}-${last_index}.jpg" -background none -gravity northwest -extent 512x512 "${dir}/${side}-${last_index}-${last_index}.tif"

    # Create the montage with all pieces
    montage \
        $(for ((row=0; row<grid_size; row++)); do
            for ((col=0; col<grid_size; col++)); do
                echo "${dir}/${side}-${row}-${col}.tif"
            done
        done) \
        -tile "${grid_size}x${grid_size}" -geometry 512x512+0+0 "${dir}/${side}_margin.tif"

    # Crop to final size
    magick "${dir}/${side}_margin.tif" -crop "${total_width}x${total_height}+0+0" "${dir}/${prefix}_$(echo ${side} | awk '{print toupper(substr($0,1,1))substr($0,2)}').tif"

    # Cleanup temporary files
    rm "${dir}/${side}-"*-*.tif "${dir}/${side}_margin.tif"

    echo "Completed processing ${side} side"
}

# Main execution
echo "Starting cubemap processing for directory: $input_dir"

# Calculate grid size
grid_size=$(calculate_grid_size "$input_dir")
echo "Detected grid size: ${grid_size}x${grid_size}"

# Process each side
for side in "${sides[@]}"; do
    if [[ -f "${input_dir}/${side}-0-0.jpg" ]]; then
        process_side "$input_dir" "$side" "$grid_size"
    else
        echo "Warning: Files for ${side} side not found in ${input_dir}, skipping..."
    fi
done

echo "Cubemap processing complete!"