#!/usr/bin/env bash

# Check if the number of arguments is correct
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 <path_to_tifs> <output_filename> [pi]"
    exit 1
fi

# Path to the TIFF files
tif_path="$1"
outfile="$2"

# Optional pi argument
pi_arg=""

# Check if the pi argument is provided
if [ "$#" -eq 3 ]; then
    pi_arg="$3"
fi

# Construct the command to call cubemap2er.sh
# Assuming your TIFF files are named exactly like this in the directory
cubemap2er.sh \
"$tif_path/Left.tif" \
"$tif_path/Right.tif" \
"$tif_path/Up.tif" \
"$tif_path/Down.tif" \
"$tif_path/Front.tif" \
"$tif_path/Back.tif" \
"$tif_path/$outfile" \
$pi_arg
