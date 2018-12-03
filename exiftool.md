Create a tab delimited file with focal lengths
```
exiftool \
-r \
-T \
-directory \
-filename \
-focallength  \
-ext CR2 \
-ext CR3 \
-ext JPG \
-ext JPEG \
/path/to/images/ \
> focals.txt
```

Sort totals
```
awk 'BEGIN {FS="\t"}; {print $3, $4}' focals.txt | sort | uniq -c | awk '{print $1, $2}' | sort -nr
```

Remove metadata
```
exiftool -all= file.pdf
```

Other tags
```
exiftool \
-common \
-ScaleFactor35efl \
-FocalLengthIn35mmFormat \
-FNumber \
-DateTimeOriginal \
-FileType \
-csv \
-t \
-r /path/to/images/
```