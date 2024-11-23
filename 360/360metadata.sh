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

for f in $@; do

    # Execute exiftool command
    exiftool \
        -overwrite_original \
        -ProjectionType="equirectangular" \
        -XMP-GPano:InitialViewHeadingDegrees=0 \
        "$f"

    # Check if exiftool command was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to modify EXIF data."
        exit 1
    fi

done

