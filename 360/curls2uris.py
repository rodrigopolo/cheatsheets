#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Copyright (c) 2024 Rodrigo Polo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
"""
# Usage: ./curls2uris.py curls.txt downloadfolder
import os
import sys
from pathlib import Path

def add_leading_zeros(value, length):
    """Add leading zeros to a value until it reaches the specified length."""
    val_string = str(value)
    return val_string.zfill(length)

def main():
    # Get command line arguments
    script_name = Path(sys.argv[0]).name
    
    # Check if both arguments are provided
    if len(sys.argv) < 3:
        print(f"Usage: python {script_name} <output_filename> <directory>")
        print(f"Example: python {script_name} curls.txt ./my_directory")
        sys.exit(1)
    
    # Get output filename and directory from command line arguments
    input_file = sys.argv[1]
    output_file = 'uris.txt'
    directory = sys.argv[2]
    directory = directory if directory.endswith('/') else directory + '/'
    
    # Check if directory exists, if not create it
    try:
        os.makedirs(directory, exist_ok=True)
        print(f"Created directory: {directory}")
    except Exception as err:
        print(f"Error creating directory: {err}")
        sys.exit(1)
    
    try:
        # Read the file
        with open(input_file, 'r', encoding='utf-8') as f:
            data = f.read()
        
        # Remove backslash followed by newline
        data = data.replace('\\\n', '')
        
        # Process lines
        processed_lines = []
        for line in data.split('\n'):
            if "bytestart" not in line:
                continue
                
            # Extract URL using string operations since we're converting from JS regex
            try:
                url_start = line.index("curl '") + 6
                url_end = line.index("'", url_start)
                url = line[url_start:url_end]
                
                # Extract bytestart and byteend
                bytestart = url.split('bytestart=')[1].split('&')[0]
                byteend = url.split('byteend=')[1].split('&')[0]
                
                # Add leading zeros
                bytestart = add_leading_zeros(bytestart, 10)
                byteend = add_leading_zeros(byteend, 10)
                
                # Format the new line
                processed_lines.append(f"{url}\n  out={bytestart}-{byteend}.jpg")
            except (ValueError, IndexError):
                continue  # Skip malformed lines
        
        # Join processed lines
        output_content = '\n'.join(processed_lines)
        
        # Write to file
        output_path = os.path.join(os.getcwd(), directory, output_file)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(output_content)
            
        print(f"URIs saved to {directory}{output_file}")
        
    except Exception as err:
        print(f"Error processing file: {err}")
        sys.exit(1)

if __name__ == "__main__":
    main()