### ImageMagick Cheats

Resize and save to 75 quality all JPGs
```sh
mogrify -resize 1296x864 -quality 75 *.jpg
```

```
! = Ignore Aspect Ratio
> = Only Shrink Larger
< = Only Enlarge Smaller
^ = Fill Given Area
% = Percentage Resize
@ = Pixel Count Limit
```

Create thumbnails with letter/pillar boxing
```sh
mogrify -resize 80x80 -background white -gravity center -extent 80x80 -format jpg -quality 75 -path thumbs *.jpg
```

Resize all images to fit inside 640x480px and strip the metadata
```sh
mogrify -resize '640x480>' -strip *.jpg
```

Convert all BMPs to JPG
```sh
mogrify -format jpg -quality 90 *.bmp
```

Create thumbnails without extended spaces
```sh
mogrify -resize 640x640 -format jpg -quality 75 -path thumbs *.jpg
```

Thumbnails 2
```sh
mogrify -resize "160^>" -gravity center -crop 160x160+0+0 -format jpg -quality 75  *.jpg
mogrify -resize "200x200^" -gravity center -crop 200x200+0+0 -format png *.psd
```

Create smaller versions of images only if they are bigger than X dimension and fit inside X dimension:
```sh
mogrify -resize "1024x1024^>" -format jpg -quality 75 -path thumbs *.jpg
```

Crop
```sh
mogrify -crop "1920x1080+320-0"  +repage -format jpg -quality 75 *.jpg
```

Watermark
```sh
mogrify \
-gravity SouthEast \
-draw "image Over 0,0 0,0 'copyright.png'" \
-format jpg \
-quality 75 \
-path wm \
*.jpg
```

Slice image
```sh
convert tocut.png -crop 265x265 +repage +adjoin %d.png
```

Remove padding
```sh
mogrify -trim +repage *.png
```

Add padding
```sh
mogrify -background none -gravity center -extent 162x162 *.png
```

Create thumbnails
```sh
mogrify -format png -resize 128x128 -path 128 folder/*.png
mogrify -format png -resize 40x40 -path 40 folder/*.png
```

Join a mosaic image
```sh
montage  \
0000000000-0000066619.jpg \
0000066620-0000130186.jpg \
0000130187-0000163987.jpg \
0000163988-0000197124.jpg \
-tile 2x2 -geometry 512x512+0+0 Left.tif
```

Change DPI
```sh
mogrify -resample 150 *.tiff
```

To grayscale
```sh
mogrify -set colorspace Gray -separate -average *.tiff
```

JPG Grayscale
```sh
mogrify -format jpg -quality 90 -set colorspace Gray -separate -average *.tiff
```

PDF to PNG
```sh
convert -density 150 file.pdf file.png
```

Create PDF from BMP
```sh
# Pad and crop
mogrify -background white -gravity NorthWest -extent 2550x3300 -crop 2550x3300+0+0 *.bmp

# To JPG
mogrify -format jpg -quality 75 *.bmp

# To PDF
mogrify -format pdf *.jpg

# Consolidate PDF (OLD)
pdftk *.pdf cat output ../Doc2.pdf

# Before Monterey
"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o all.pdf *.pdf

# After Monterey

# poppler pdfunite
brew install poppler
pdfunite fileA.pdf fileB.pdf output.pdf
pdfunite *.pdf output.pdf

# Ghostscript
gs \
-dNOPAUSE \
-sDEVICE=pdfwrite \
-sOUTPUTFILE=merged.pdf \
-dBATCH \
*.pdf

# Reduce PDF Size with Ghostscript
gs \
-sDEVICE=pdfwrite \
-dCompatibilityLevel=1.4 \
-dPDFSETTINGS=/prepress \
-dNOPAUSE \
-dQUIET \
-dBATCH \
-sOutputFile=compressed_PDF_file.pdf \
input_PDF_file.pdf


# PDF to PNG
ls --color=never test*.pdf | sed 's|.pdf||' | xargs -I{} pdftoppm {}.pdf -png {}
```

### Sources
* [Resize](http://stackoverflow.com/questions/12433300/imagemagick-how-to-resize-proportionally-with-mogrify-without-a-background)  
* [Combine PDFs](https://jordanelver.co.uk/blog/2021/01/30/combine-pdfs-on-the-command-line-with-pdfunite/)  
* [Combine PDFs in Linux](https://www.bitslovers.com/how-to-merge-pdf-on-linux/)  
