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

Get GPS decimal location
```
exiftool -m -c "%+.10f" -p '$GPSlatitude,$GPSlongitude' file.jpg
```

Get one tag and save it to a JSON file, saving errors to another file
```
exiftool -json  -ImageDescription *.jpg >> images.json 2>> stderr.txt
```

Get one tag, and one tag only without headers
```
exiftool -ImageDescription x.jpg
exiftool -s -s -s  -FileName -ImageDescription x.jpg
```

Generate MD5 from JPG files
```
find . -type f -iname "*.jpg" -exec md5sum '{}' \; > md5s.txt
```

Get dates from videos
```
exiftool \
-r \
-T \
-directory \
-filename \
-MediaCreateDate \
-ext MOV \
-ext MP4 \
. \
> dates.txt

General
-CreateDate \

MOV
-CreationDate \

MP4
-MediaCreateDate \
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