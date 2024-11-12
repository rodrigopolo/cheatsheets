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

#  Usage:
#    cubemap2er.sh \
#    Left.tif      \
#    Right.tif     \
#    Up.tif        \
#    Down.tif      \
#    Front.tif     \
#    Back.tif      \
#    Fina.tif      \
#    pi (Optional)

# Check if exactly 7 arguments are provided
if [ "$#" -lt 7 ] || [ "$#" -gt 8 ]; then
   echo "Error: 7 arguments are required."
   echo "Usage: $0 <Left.tif> <Right.tif> <Up.tif> <Down.tif> <Front.tif> <Back.tif> <OutputFile> [π size optional]"
   exit 1
fi

# Array to hold the paths of the input files
input_files=("$1" "$2" "$3" "$4" "$5" "$6")

# Check if each input file exists
for file in "${input_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Error: The file '$file' does not exist."
        exit 1
    fi
done

# Change to the directory of the first input file
cd "$(dirname "$1")" || { echo "Failed to change directory"; exit 1; }

# Extract width from the input file
tile_width=$(exiftool -s -s -s -ImageWidth "$6")

# Calculate dimensions
er_width=$((tile_width * 4))
er_height=$((tile_width * 2))

pi=$(echo "scale=10; 4*a(1)" | bc -l)
pi_width=$(echo "scale=0; ($tile_width * $pi + 1)/1" | bc)
pi_height=$(echo "scale=0; (($pi_width + 1) / 2)" | bc)

# Use the pi calculations if the 8th argument is provided and equals "pi"
if [ "$8" = "pi" ]; then
    width=$pi_width
    height=$pi_height
else
    width=$er_width
    height=$er_height
fi

# Output the pto file with the correct dimensions
echo "p f2 w${width} h${height} v360  k0 E0 R0 n\"TIFF_m c:LZW r:CROP\"
m i0

i w${tile_width} h${tile_width} f0 v90 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y180 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n\"${6}\"
i w${tile_width} h${tile_width} f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p0 y0 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n\"${5}\"
i w${tile_width} h${tile_width} f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p-90 y180 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n\"${4}\"
i w${tile_width} h${tile_width} f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p0 y-90 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n\"${1}\"
i w${tile_width} h${tile_width} f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p0 y90 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n\"${2}\"
i w${tile_width} h${tile_width} f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p90 y180 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n\"${3}\"

v Ra0
v Rb0
v Rc0
v Rd0
v Re0
v Vb0
v Vc0
v Vd0
v Eev1
v r1
v p1
v y1
v Eev2
v r2
v p2
v y2
v Eev3
v r3
v p3
v y3
v Eev4
v r4
v p4
v y4
v Eev5
v r5
v p5
v y5
v" > "$7.pto"

# Prepare sides for stitching
nona -o pano -m TIFF_m -z LZW "$7.pto"

# Blend the images
verdandi \
pano0000.tif \
pano0001.tif \
pano0002.tif \
pano0003.tif \
pano0004.tif \
pano0005.tif \
-o "$7"

# Delete temp files
rm \
pano0000.tif \
pano0001.tif \
pano0002.tif \
pano0003.tif \
pano0004.tif \
pano0005.tif \
"$7.pto"
