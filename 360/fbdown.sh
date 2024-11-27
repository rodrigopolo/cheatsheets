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

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <urls.txt> <imageprefix>"
    echo "Ex: ./fbdown.sh urls.txt myimage"
    exit 1
fi

# Check if the first argument (input file) exists
if [ ! -f "$1" ]; then
    echo "Error: Input file $1 does not exist."
    exit 1
fi

# Create the download script into the downloadfolder
./curls2uris.py $1 downloadfolder

# Download the images
aria2c -j 16 --continue=true --auto-file-renaming=false -d ./downloadfolder/ -i ./downloadfolder/uris.txt

# Create the cube faces
./joinmosaic.sh ./downloadfolder ./$2

# Assemble the cube to equirectangular
./c2e.sh $2 $2.tif fb

# Convert it to JPG
tif2jpg.sh $2.tif
