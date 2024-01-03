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

Copy metadata
```sh
exiftool \
-tagsFromFile source.tif \
target.tif
```

Copy selected metadata
```sh
exiftool \
-tagsFromFile source.tif \
-DateTimeOriginal \
-ApertureValue \
-ShutterSpeedValue \
-FocalLength \
-ISO \
-Make \
-Model \
-LensInfo \
-LensModel \
-LensSerialNumber \
-SerialNumber \
-Artist \
-Copyright \
-ExposureTime \
-ExposureProgram \
-ISO \
-Creator \
-Rights \
target.tif
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

Find all 360 photos based in width and height relation
```sh
exiftool \
-q \
-r \
-if '$ImageWidth == 2 * $ImageHeight' \
-p '$Directory/$FileName' \
/path/to/directory
```

Find all 360 photos based in width and height relation, add its 360 metadata, and add the keyword 360
```sh
exiftool \
-q \
-r \
-if '$ImageWidth == 2 * $ImageHeight' \
-ProjectionType="equirectangular" \
-XMP-GPano:InitialViewHeadingDegrees=0 \
-Keywords+=360i \
/path/to/directory
```

Find all 360 photos based in width and height relation and expecting NOT to jave a projection type, then add its 360 metadata, and add the keyword 360
```sh
exiftool \
-q \
-r \
-if '$ImageWidth == 2 * $ImageHeight and not $ProjectionType' \
-ProjectionType="equirectangular" \
-XMP-GPano:InitialViewHeadingDegrees=0 \
-Keywords+=360i \
/path/to/directory
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
file.jpg 
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

## Media File Renaming

> Following these steps will rename your videos to a compatible filename convention for use in a media pool alongside files from any of this camera brands.

Rename all Canon video files in a path to have the date prefix with time offset
```sh
exiftool \
-ext mp4 \
-ext crm \
-ext mov \
-r \
-if '$make =~ /canon/i' \
-p '$filename' '-FileName<SubSecDateTimeOriginal' \
-d "%Y-%m-%d %H.%M.%S%z - %%f.%%e" \
/path/to/files
```

Rename all iPhone video files to have the date prefix with time offset
```sh
exiftool \
-ext mp4 \
-ext mov \
-r \
-if '$make =~ /apple/i' \
-p '$filename' '-FileName<CreationDate' \
-d "%Y-%m-%d %H.%M.%S%z - %%f.%%e" \
/path/to/files
```

Rename all GoPro video files to have the date prefix, GoPro doesn't handle time offset
```sh
exiftool \
-ext mp4 \
-r \
-p '$filename' '-FileName<CreateDate' \
-d "%Y-%m-%d %H.%M.%S - %%f.%%e" \
/path/to/files
```

Rename all Mavic Pro 2 video files to have the date prefix
```sh
exiftool \
-ext mp4 \
-ext mov \
-ext jpg \
-ext dng \
-r \
-p '$filename' '-FileName<CreateDate' \
-d "%Y-%m-%d %H.%M.%S - %%f.%%e" \
/path/to/files
```

Set a time offset
```sh
exiftool \
-ext mp4 \
-ext mov \
-ext jpg \
-ext dng \
-r \
-GlobalTimeShift "-6:0:0" \
-p '$filename' '-FileName<CreateDate' \
-d "%Y-%m-%d %H.%M.%S - %%f.%%e" \
/path/to/files
```


Rename all Insta360 X3 videos
> Insta360 videos do not handle time offset and [do not have a typical video extension](https://archive.ph/cxpMz). Therefore, the workflow to rename the files to have a name convention compatible with other cameras does not require using `exiftool` or `mediainfo`. Instead, it utilizes `sed` replacements. Ensure you have Insta360 Studio installed and that the videos have already been processed in it. This is important as Insta360 Studio provides date-time information in the filename convention. Then follow the script bellow:

```sh
# Navigate to the directory containing the video files:
cd /path/to/files

# Using ls and grep create the ren.sh script:
ls | grep -i -E "(mp4|mov)$" | \
sed -En 's/^(([a-z]{3})_([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2})([0-9]{2})_[0-9]{2}_([0-9]{3})[^.]*\.(mov|mp4))$/mv "\1" "\3-\4-\5 \6.\7.\8 - \2_\9"/ip' | \
sed -En 's/^(mv \"[a-z]{3}_[0-9]{8}_[0-9]{6}_[0-9]{2}_[0-9]{3}([^.]*)\.([^"]+)") "([^"]+)"$/\1 "\4\2.\3"/ip' \
> ren.sh

# Review the ren.sh script, and then execute it
bash ren.sh
```

## Media Database with MongoDB

Create a JSON file
```sh
exiftool \
-j \
-n \
-r \
-ext MP4 \
-ext M4V \
-ext MOV \
-ext MKV \
-ext OGG \
-ext OGV \
/path/to/files  > allmediainfo.json
```

Import it to MongoDB
```sh
mongoimport \
--db mydb \
--collection videos \
--type json \
--file allmediainfo.json \
--jsonArray
```

You can do a search based in the properties like SourceFile
```js
db.getCollection('videos').find({
   'SourceFile':/keyboard/i
})
```

You can also search based on codec
```js
db.getCollection('videos').find({
    "Encoder" : "Lavf58.45.100",
}).forEach(function(i){
    print(i.SourceFile)
})
```

And on vertical videos, with size higher than 50MiB
```js
db.getCollection('videos').find({
	$where: "this.ImageHeight > this.ImageWidth",
	FileSize: {$lte: 52428800}
}).forEach(function(i){
    print(i.SourceFile)
})
```

Sources:  
https://exiftool.org/faq.html  
https://ninedegreesbelow.com/photography/exiftool-commands.html