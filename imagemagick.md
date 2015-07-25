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

[source](http://stackoverflow.com/questions/12433300/imagemagick-how-to-resize-proportionally-with-mogrify-without-a-background)


