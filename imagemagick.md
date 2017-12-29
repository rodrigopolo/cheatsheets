### ImageMagick Cheats

Resize and save to 75 quality all JPGs
```
mogrify -resize 1296x864 -quality 75 *.jpg
```

Create thumbnails with letter/pillar boxing
```
mogrify -resize 80x80 -background white -gravity center -extent 80x80 -format jpg -quality 75 -path thumbs *.jpg
```

Convert all BMPs to JPG
```
mogrify -format jpg -quality 90 *.bmp
```

Create thumbnails without extended spaces
```
mogrify -resize 640x640 -format jpg -quality 75 -path thumbs *.jpg
```

Thumbnails 2
```
mogrify -resize "160^>" -gravity center -crop 160x160+0+0 -format jpg -quality 75  *.jpg
```

Create smaller versions of images only if they are bigger than X dimension and fit inside X dimension:
```
mogrify -resize 1024x1024^> -format jpg -quality 75 -path thumbs *.jpg
```

Crop
```
mogrify -crop 1920x1080+320-0  +repage -format jpg -quality 75 *.jpg
```

Watermark
```
mogrify \
-gravity SouthEast \
-draw "image Over 0,0 0,0 'copyright.png'" \
-format jpg \
-quality 75 \
-path wm \
*.jpg
```

Slice image
```
convert tocut.png -crop 265x265 +repage +adjoin %d.png
```

Remove padding
```
mogrify -trim +repage *.png
```

Add padding
```
mogrify -background none -gravity center -extent 162x162 *.png
```

Create thumbnails
```
mogrify -format png -resize 128x128 -path 128 folder/*.png
mogrify -format png -resize 40x40 -path 40 folder/*.png
```

Create PDF from BMP
```
# Pad and crop
mogrify -background white -gravity NorthWest -extent 2550x3300 -crop 2550x3300+0+0 *.bmp

# To JPG
mogrify -format jpg -quality 75 *.bmp

# To PDF
mogrify -format pdf *.jpg

# Consolidate PDF
pdftk *.pdf cat output ../Doc2.pdf
```

[source](http://stackoverflow.com/questions/12433300/imagemagick-how-to-resize-proportionally-with-mogrify-without-a-background)


