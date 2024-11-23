#!/usr/bin/env bash

# Check if directory argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <url>"
    echo "Example: $0 https://www.360cities.net/image/URL"
    exit 1
fi

# Extract the last part of the URL
url=$1
panoname="${url##*/}"

# Create download directory
mkdir $panoname

# Create download and metadata scripts
node 360cities.js \
$url \
./$panoname/uris.txt \
./$panoname/exiftool.sh

# Download the images
aria2c -j 16 --continue=true --auto-file-renaming=false -d ./$panoname -i ./$panoname/uris.txt

# Create the cube faces
./process_cubemap_360cities.sh ./$panoname $panoname

# Assemble the cuve to equirectangular
./c2e.sh ./$panoname/$panoname $panoname.tif

# Convert it to JPG
./tif2jpg.sh $panoname.tif

# Add its metadata
bash ./$panoname/exiftool.sh $panoname.jpg

# Remove temporal directory and tif file
rm -rf ./$panoname $panoname.tif