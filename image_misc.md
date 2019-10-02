
# sed replace regex new
cat todo.txt | grep -i "IMG_" | grep -i ".MP4" | sed -E -e 's/[^\/]+$//' | sort | uniq > ~/Desktop/videos.txt


cat todo.txt | grep -i ".AAE" sed -E -e 's/[^\/]+$//' | sort | uniq > ~/Desktop/basura.txt

AAE
.xmp
empty folders and files


#Find HEIC folders
find "`pwd`" -type f -iname "*.HEIC" | sed -E -e 's/[^\/]+$//' | sort | uniq > heic2.txt


# Find empty folders
find "`pwd`" -type d -exec bash -c "echo -ne '{}'; ls '{}' | wc -l" \; | awk '$NF==0' > ~/Desktop/vacios.txt
find "`pwd`" -type d -empty > ~/Desktop/vacios.txt

# Unicos
cat pelan.txt | grep -i "/Share" | sed -E -e 's/[^\/]+$//' | sort | uniq > borrar.txt

exiftool -json input.jpg > ~/Desktop/output.JSON

 | awk -F $'\t' '{print $3}'


---
find . -type d -exec bash -c "echo -ne '{} '; ls '{}' | wc -l" \; | awk '$NF==0'


cat /Volumes/A/todo.txt | grep -i "\.heic" > ~/Desktop/convertir.txt
cat convertir.txt | sort | uniq > convertir2.txt 


[^\/]\w+\.heic$
---

# Solo los que no tengan "-" luego del 3er tab
cat ~/Desktop/check.txt | egrep -v '.*\t.*\t.*\t\-'


"Make": "Apple",
"Model": "iPhone X",

"Make": "Canon",
"Model": "Canon EOS R",


DateTimeOriginal



exiftool \
-r \
-T \
-directory \
-filename \
-Make \
-Model \
-DateTimeOriginal \
-ext JPG \
-ext JPEG \
/Volumes/A/04-pdata/Importar\ Picasa/Found/share \
> ~/Desktop/check.txt