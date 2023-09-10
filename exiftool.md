Create a tab delimited file with focal lengths

Determine the tag name for some information
```sh
exiftool -s -G image.jpg
```

Get the focal length in a directory
```sh
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
```sh
awk 'BEGIN {FS="\t"}; {print $3, $4}' focals.txt | \
sort | \
uniq -c | \
awk '{print $1, $2}' | \
sort -nr
```

Different sort
```sh
cat focals.txt | \
grep -i canon | \
awk 'BEGIN {FS="\t"}; {print $4}' | \
sort | \
uniq -c | \
awk '{print $1, $2}' | \
sort -nr
```

Create a tab delimited file with Camera Models
```sh
exiftool \
-r \
-T \
-directory \
-filename \
-Model  \
-ext CR2 \
-ext CR3 \
-ext JPG \
-ext JPEG \
-ext JPG \
/path/to/images/ \
> models.txt
```

Sort totals
```sh
awk 'BEGIN {FS="\t"}; {print $3}' models.txt | sort | uniq -c | sort -nr
```

Remove metadata
```sh
exiftool -all= file.pdf
```

Get GPS decimal location
```sh
exiftool -m -c "%+.10f" -p '$GPSlatitude,$GPSlongitude' file.jpg
```

Get one tag and save it to a JSON file, saving errors to another file
```sh
exiftool -json  -ImageDescription *.jpg >> images.json 2>> stderr.txt
```

Get one tag, and one tag only without headers
```sh
exiftool -ImageDescription x.jpg
exiftool -s -s -s  -FileName -ImageDescription x.jpg
```

Get lens models and focal lengths
```sh
exiftool \
-r \
-T \
-filename \
-make \
-LensModel  \
-focallength  \
-ext CR2 \
-ext CR3 \
-ext JPG \
-ext JPEG \
/path/to/files
```

Rename based on CreateDate
```sh
exiftool \
'-filename<CreateDate' \
-d '%Y-%m-%d %H.%M.%S%%-c.%%le' \
-r \
-ext jpg \
/path/to/files
```

Rename based on CreateDate and PreservedFileName
```sh
exiftool \
'-filename<${createdate} ${PreservedFileName;}.%e'  \
-d '%Y-%m-%d %H.%M.%S%%-c.%%le' \
-r \
-ext jpg \
/path/to/files
```

Generate MD5 from JPG files
```sh
find . -type f -iname "*.jpg" -exec md5sum '{}' \; > md5s.txt
```

Get dates from videos
```sh
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

Copy metadata from one file to another
```sh
exiftool \
-TagsFromFile \
source.jpg \
"-all:all>all:all" \
target.jpg
```

Set [360° metadata](https://www.trekview.org/blog/2022/using-gpano-gspherical-metadata-adjust-roll-pitch-heading/)
```sh
exiftool \
-ProjectionType="equirectangular" \
-XMP-GPano:InitialViewHeadingDegrees=0 \
target.jpg
```

Change date
```sh
exiftool \
"-AllDates=2000:12:31 09:30:25" \
target.jpg
```

Excel date format
```
yyyy-mm-dd hh:mm:ss;@
```

Other tags
```sh
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

Rename every file with the EXIF maker 'Apple' using date
```sh
exiftool -if '$make =~ /apple/i' -p '$filename' '-FileName<DateTimeOriginal' -d "%Y-%m-%d %H.%M.%S% - %%f.%%e" .
```

List files with maker 'apple'
```sh
exiftool -if '$make =~ /apple/i' -p '$filename' .
```

Get file description
```sh
exiftool -Description file.jpg
exiftool -Caption-Abstract file.jpg
```

Result
```
Description                     : A file description
Caption-Abstract                : A file description
```

Get file keywords
```sh
exiftool -Keywords file.jpg
exiftool -Subject file.jpg
```

Result
```
Keywords                        : 360
Subject                         : 360
```

Get regions
```sh
exiftool \
-RegionAppliedToDimensionsW \
-RegionAppliedToDimensionsH \
-RegionAppliedToDimensionsUnit \
-RegionName \
-RegionType \
-RegionAreaX \
-RegionAreaY \
-RegionAreaW \
-RegionAreaH \
-RegionAreaUnit \
"2023-09-10 02.25.05 - IMG_20171231_183315_00_019.jpg" 
```

Result
```
Region Applied To Dimensions W   : 6080
Region Applied To Dimensions H   : 3040
Region Applied To Dimensions Unit: pixel
Region Name                      : Name 1, Name 2
Region Type                      : Face, Face
Region Area X                    : 0.452796, 0.496217
Region Area Y                    : 0.500658, 0.483717
Region Area W                    : 0.0292763, 0.04375
Region Area H                    : 0.0710526, 0.104934
Region Area Unit                 : normalized, normalized
```




https://exiftool.org/faq.html
https://ninedegreesbelow.com/photography/exiftool-commands.html