#!/usr/bin/env bash

# Check if the script has received an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_pano_equirectangular.tif>"
    exit 1
fi

# The input tif file path
input_file="$1"

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

# Define the output names for consistency with your script
output_png="pano_equirectangular.png"
cubemap_png="pano_cubemap.png"

# Convert tif to png
magick "$input_file" -flatten -alpha off "$output_png"

# Convert equirectangular to cubemap
convert360 -i "$output_png" -o "$cubemap_png" -s $new_size $new_size -it equirectangular -ot cubemap

# Crop the cubemap into individual faces
magick "$cubemap_png" -crop $new_size"x"$new_size +repage output_%d.tif

# Rename the output files
mv output_1.tif Left.tif
mv output_0.tif Right.tif
mv output_2.tif Up.tif
mv output_3.tif Down.tif
mv output_4.tif Front.tif
mv output_5.tif Back.tif

# Clean up temporary files if needed
rm "$output_png" "$cubemap_png"

echo "Processing completed. Output files generated in the same directory as the input."
