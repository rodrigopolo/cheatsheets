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

    # Prefix for pto
    prefix="${f%.*}"

    # Basename for tifs
    basename="${f##*/}"
    basename="${basename%.*}"

    # Change to the directory of the first input file
    cd "$(dirname "$input_file")" || { echo "Failed to change directory"; exit 1; }

    # Check if the file exists
    if [ ! -f "$input_file" ]; then
        echo "Error: File $input_file does not exist."
        continue
    fi

    # Extract width from the input file
    height=$(exiftool -s -s -s -ImageHeight "$input_file")
    width=$(exiftool -s -s -s -ImageWidth "$input_file")
    cubeface_size=$(echo "scale=10; base = ($height/sqrt(3))*(1/sqrt(3)*sqrt(2)+0.049419); scale=0; if(base%16==0) base else (base/16+1)*16" | bc -l)


    fheader="p f0 w${cubeface_size} h${cubeface_size} v90  k0 E0 R0 n\"TIFF_m c:LZW r:CROP\"\nm i0\n"
    ffooter="v Ra0\nv Rb0\nv Rc0\nv Rd0\nv Re0\nv Vb0\nv Vc0\nv Vd0\nv\n"

    echo -e "${fheader}i w${width} h${height} f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y-1.14499968532687e-13 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${input_file}\"\n${ffooter}" > "${prefix}_front.pto"
    echo -e "${fheader}i w${width} h${height} f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y-90.0000000000001 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${input_file}\"\n${ffooter}" > "${prefix}_right.pto"
    echo -e "${fheader}i w${width} h${height} f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y180 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${input_file}\"\n${ffooter}" > "${prefix}_back.pto"
    echo -e "${fheader}i w${width} h${height} f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y89.9999999999999 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${input_file}\"\n${ffooter}" > "${prefix}_left.pto"
    echo -e "${fheader}i w${width} h${height} f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r26.9094996026837 p-90 y-26.9094996026837 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${input_file}\"\n${ffooter}" > "${prefix}_up.pto"
    echo -e "${fheader}i w${width} h${height} f4 v360 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r-88.244968578448 p90 y-88.244968578448 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${input_file}\"\n${ffooter}" > "${prefix}_down.pto"

    nona -o ${basename}_Front -m TIFF -z LZW "${prefix}_front.pto"
    nona -o ${basename}_Right -m TIFF -z LZW "${prefix}_right.pto"
    nona -o ${basename}_Back -m TIFF -z LZW "${prefix}_back.pto"
    nona -o ${basename}_Left -m TIFF -z LZW "${prefix}_left.pto"
    nona -o ${basename}_Up -m TIFF -z LZW "${prefix}_up.pto"
    nona -o ${basename}_Down -m TIFF -z LZW "${prefix}_down.pto"

    rm "${prefix}_front.pto" \
    "${prefix}_right.pto" \
    "${prefix}_back.pto" \
    "${prefix}_left.pto" \
    "${prefix}_up.pto" \
    "${prefix}_down.pto" 

done

