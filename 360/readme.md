# 360° image and video manipulation

## Equirectangular to Cubemap
There are three tools for this, Hugin which it multiplatform, Kubi and py360convert that are Python scripts.

> **Note:** `convert360` has an image limit size up to 13376x6688px, while Facebook has an image limit of 16384px8192px. Hugin's `nona` can process bigger images.

### Kubi
To convert a panorama to cubemap with Kubi
```sh
kubi \
-s 6848 \
-f Right Left Up Down Front Back \
Panorama.tif \
Panorama
```

Guide to install Kubi: https://github.com/rodrigopolo/clis/tree/main/360#alternative-to-tocubemapsh  

### Hugin
You can open your equirectangular image in Hugin's GUI, set the field of view to 90x90 in the projection tab, export each image changing the yaw to +90 in the move/drag tab, one for each horizontal face, and then change the pitch +90 and -90 for the up and down image. Alternatively, you can use `tocubemap.sh` script located here:
https://github.com/rodrigopolo/clis/tree/main/360#tocubemapsh

### py360convert

```sh
convert360 \
-i equirectangular.png \
-o cubemap.png \
-s 2992 2992 \
-it equirectangular \
-ot cubemap
```
More about `py360convert`: https://github.com/sunset1995/py360convert  

## Cubemap to Equirectangular with `toequirectangular.sh`

To convert 6 separated `tif` image cube faces into an equirectangular panorama,
you can call it by setting just one cube face. The script will look for the file
name prefix, then look for the `_Back`, `_Down`, `_Front`, `_Left`, `_Right`
and `_Up` files, and the output file would have the `_equirectangular` suffix:
```sh
./toequirectangular.sh Pano_Front.tif
```

Result:
```
Panorama_equirectangular.tif
```

You can also call it by setting all the cube faces:
```sh
./toequirectangular.sh \
Pano_Back.tif \
Pano_Down.tif \
Pano_Front.tif \
Pano_Left.tif \
Pano_Right.tif \
Pano_Up.tif
```

Check all the panorama scripts: https://github.com/rodrigopolo/clis/tree/main/360#360-panorama-scripts  


## Cubemap to Equirectangular with Hugin

1. Load the images in Hugin, make sure the images have the sufix `Back`, `Down`, `Front`, `Left`, `Right` and `Up` for clarity.
2. Set the `HOV` to `90` when loading the images.
3. Double click in each image and set the `Yaw` and `Pitch` as in the next table or lad the `CubemapTemplate.pto` by clicking in `File->Apply Template...`.
4. In the `Canvas` tab, click in the `Calculate optimal size` button, and select `builtin` as the `Blender` option.
5. Review the pano in the `GL` panorama preview, and stich.

   | Face  | yaw | pitch |
   |-------|----:|------:|
   | back  | 180 |     0 |
   | down  |   0 |   -90 |
   | front |   0 |     0 |
   | left  | -90 |     0 |
   | right |  90 |     0 |
   | up    |   0 |    90 |


## Superscale Insta360 x4 image
1. Convert the original dual-fisheye DNG to TIF with Photoshop or ImageMagick.
2. Resize the TIF to 2 or 4x using Topaz Gigapixel AI or similar tools.
3. Load the resized TIF into Hugin, twice.
4. In Hugin, select `File` -> `Apply Template...`, and choose `Insta360Template.pto`
5. In "Sticher" tab, select "Calculate oprimal size" and then export the image.

> **Denoise:** You can use Topaz DeNoise AI before Topaz Gigapixel AI, and use Affinity Photo 2 to refine the horizon.
> **Object removal:** You can use `tocubemap.sh` to convert the equirectangular image to cubemap, then with Photoshop Generative Fill, remove objects, and then with `toequirectangular.sh` convert it back to equirectangular.
> **Metadata:** You can copy the metadata from an already exported image and copy it to the new image with `exiftool -overwrite_original -tagsFromFile source.tif target.tif`

## Download a Facebook 360° image

1. View the 360 image in a webbrowser by clicking in it until it is in its maximum size, NOT full screen.
2. Open the browser Developer Tools and reload the page.
3. In the tab Network, righ clic any requested file, select `Copy` and then `Copy all as URLs`.
4. Paste the curls into a `urls.txt` file, and save it into a folder, then:

```sh
# Create the download script into the downloadfolder
./curls2uris.py urls.txt downloadfolder

# Download the images
aria2c -j 16 --continue=true --auto-file-renaming=false -d ./downloadfolder/ -i ./downloadfolder/uris.txt

# Create the cube faces
./joinmosaic.sh ./downloadfolder ./prefix

# Assemble the cube to equirectangular
./c2e.sh prefix finalimage.tif fb

# Convert it to JPG
tif2jpg.sh finalimage.tif
```

Or after saving the `urls.txt` file, just run:
```sh
./fbdown.sh urls.txt myimage
```

## Download a panorama from 360cities.net
```sh
# Create download directory
mkdir download

# Create download and metadata scripts
node 360cities.js \
https://www.360cities.net/image/URL \
./download/uris.txt \
./download/exiftool.sh

# Download the images
aria2c -j 16 --continue=true --auto-file-renaming=false -d ./download -i ./download/uris.txt

# Create the cube faces
./process_cubemap_360cities.sh ./download pano

# Assemble the cube to equirectangular
./c2e.sh ./download/pano finalimage.tif

# Convert it to JPG
./tif2jpg.sh finalimage.tif

# Add its metadata
bash ./download/exiftool.sh finalimage.jpg
```

Or just run
```sh
./360cities.sh https://www.360cities.net/image/URL
```

## Dependencies

### For image processing and download
```sh
brew install imagemagick exiftool aria2
```

### Hugin
Installations instructions available here:  
https://github.com/rodrigopolo/clis/tree/main/360#hugin  

### Publishing 360 panorama

Convert your 360 equirectangular panorama in a multiple cubemap grids, and generate the HTML for the Pannellum viewer
```sh
./Pannellum.sh panorama.jpg
```

### Downloading 360 video from YouTube

Check which format you want to download:
```sh
youtube-dl "https://youtu.be/<HASH>" -F
```

Use the format id to download, in this case, the `571` video and `140` audio:
```sh
youtube-dl "https://youtu.be/<HASH>" -f "571+140"
```

#### YouTube's cubemap to equirectangular

Some 360° videos come in a special cubemap format with a `16:9` aspect ratio. To convert these videos back to their original equirectangular format, you can use the following FFmpeg command. Note that all equirectangular images have a `2:1` aspect ratio; thus, a 4K video would have a resolution of `3840x1920`, and an 8K video would have a resolution of `7680x3840`.

```sh
ffmpeg \
-hwaccel auto \
-y \
-hide_banner \
-i input.mkv \
-vf "v360=c3x2:e:cubic:in_forder='lfrdbu':in_frot='000313',scale=3840:1920,setsar=1:1" \
-pix_fmt yuv420p \
-c:v libx264 \
-preset faster \
-crf 21 \
-c:a copy \
-movflags +faststart \
output.mp4
```

# 360° Panorama with EOS R5 + 15-35mm + Panoramic tripod head

### Gear:
* [Canon EOS R5](https://bhpho.to/4aIiFJf)
* [Canon RF 15-35mm f/2.8 L](https://bhpho.to/41ICrlD)
* [Nodal Ninja NN3 MK3 + Rotator Mini](https://bhpho.to/4hPlQSy)

### Steps capturing the images:

1. **Prepare the Rotator:** Swap the detent ring on the Rotator Mini V2 to 60° for consistent rotation stops.
2. **Assemble the Setup:** Follow the [Nodal Ninja mount user manual](https://www.nodalninja.com/Manuals/nn3mk3.pdf) to attach the NN3 MK3 to your tripod and secure the EOS R5 with the 15-35mm lens.
3. **Find the Nodal Point:** Adjust the camera position on the NN3 MK3 [so the lens’s nodal point aligns with the rotation axis](https://youtu.be/uadeEgiLRCY) (test by rotating and checking foreground/background alignment).
4. **Capture the Nadir:** Set the camera straight down (nadir), ensure it’s centered, and take the first shot.
5. **First Row:** Tilt the camera to -30°, rotate it in 60° increments (using the detent ring), and take a full row of images.
6. **Second Row:** Tilt the camera to +30°, repeat the 60° rotation steps, and capture the second row of images.
7. **Zenith Shot:** Point the camera straight up (zenith) and take the final image.

### Stitching

* Import, adjust and export to TIF the images using Adobe Lightroom.
* Open Hugin and enter into "Preview panorama (OpenGL)".
* Load images, and alignt images using Hugin Assistant.
* Just in case, go to "Move/Drag" and select "Straighten".
* Export the panorama.

### Dealing with Hugin merge momory limit exporting 3 rows
Check https://github.com/rodrigopolo/clis/blob/main/360/ptogrid_rows.sh  

### Removing the tripod
* Convert the equirectangular TIF file to cubemap using `tocubemap.sh`.
* Open the down side in Photoshop and either using "Generative Fill" or "Content-Aware Fill".
* Convert back to equirectangular with `toequirectangular.sh`.

### Dealing with metadata

Copy the metadata from one of the original tif images to the stitched panorama using:

```sh
exiftool \
-overwrite_original \
-tagsFromFile source.tif \
target.tif
```

Set the panorama metadata and tag
```sh
exiftool \
-overwrite_original \
-ProjectionType="equirectangular" \
-XMP-GPano:InitialViewHeadingDegrees=0 \
-Keywords+=360i \
"target.tif"
```

Or just run `add360metadata.sh onput.tif`

### Export to JPG

You can either import the tif file back to Lightroom and use the export funcion, or use the `tif2jpg.sh` script
