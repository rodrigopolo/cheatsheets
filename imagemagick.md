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

[source](http://stackoverflow.com/questions/12433300/imagemagick-how-to-resize-proportionally-with-mogrify-without-a-background)


