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

real_path () {
    TARGET_FILE=$1
    cd `dirname $TARGET_FILE`
    TARGET_FILE=`basename $TARGET_FILE`

    while [ -L "$TARGET_FILE" ]
    do
        TARGET_FILE=`readlink $TARGET_FILE`
        cd `dirname $TARGET_FILE`
        TARGET_FILE=`basename $TARGET_FILE`
    done
    
    PHYS_DIR=`pwd -P`
    RESULT=$PHYS_DIR/$TARGET_FILE
    echo $RESULT
}

# Check if the number of arguments is correct
if [ "$#" -lt 2 ] || [ "$#" -gt 4 ]; then
    echo "Usage: $0 <path_and_prefix_to_tifs> <output_filename> [fb cubemap optional] [pi calc optional]"
    exit 1
fi

# Path to the TIFF files
tif_path=$(real_path $1)
outfile=$(real_path $2)

# Side names
sides=("Right" "Left" "Up" "Down" "Back" "Front")

# Check if each input file exists
for file in "${sides[@]}"; do
    side="${tif_path}_${file}.tif"
    if [ ! -f "$side" ]; then
        echo "Error: The file '$side' does not exist."
        exit 1
    fi
done

# Optional pi argument
pi_arg=""

# Check if the pi argument is provided
if [ "$#" -ge 3 ]; then
    pi_arg="$3"
fi

# Optional pi argument
fb_arg=""

# Check if the fb argument is provided
if [ "$#" -eq 4 ]; then
    fb_arg="$3"
fi

# Construct the command to call cubemap2er.sh
./cubemap2er.sh \
"${tif_path}_Left.tif" \
"${tif_path}_Right.tif" \
"${tif_path}_Up.tif" \
"${tif_path}_Down.tif" \
"${tif_path}_Front.tif" \
"${tif_path}_Back.tif" \
"$outfile" \
$pi_arg \
$fb_arg \
