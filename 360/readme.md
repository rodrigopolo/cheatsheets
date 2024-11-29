# 360° image and video manipulation

## Equirectangular to Cubemap

To convert any equirectangular image to cubemap, you'll need `imagemagick`, `exiftool` and either Hugin's `nona` or `convert360`, at the end how to install this dependencies. `convert360` requires the input image to be png.

> **Note:** `convert360` has an image limit size up to 13,376px x 6,688px, while Facebook has an image limit of 16,000px x 8,000px. Hugin's `nona` can process bigger images.

### Using Hugin's `nona` and `exiftool`

Just run `tocubemap_nona.sh` with each image you want to process, making shure that `nona` is in the `$PATH` and all dependencies installed, see dependencies at the end.
```sh
./tocubemap_nona.sh pano1.jpg pano2.jpg pano3.jpg...
```

### Using `convert360`
1. Convert the equirectangular image to a flat PNG file
```sh
magick equirectangular.tif -flatten -alpha off equirectangular.png
```

2. Get the image width, to devide it into 4 to get the cube size
```sh
exiftool -s -s -s -ImageWidth equirectangular.png
```

3. Convert the png file to cuebemap with `convert360`
```sh
convert360 -i equirectangular.png -o cubemap.png -s 2992 2992 -it equirectangular -ot cubemap
```

4. Slice the cubemap into its different pieces
```sh
magick cubemap.png -crop 2992x2992 +repage output_%d.tif
```

5. Rename files to its cube face
```sh
mv output_1.tif Left.tif
mv output_0.tif Right.tif
mv output_2.tif Up.tif
mv output_3.tif Down.tif
mv output_4.tif Front.tif
mv output_5.tif Back.tif
```

## Cubemap to Equirectangular

For this task, we need Hugin, make shure that `nona` is in the `$PATH` and all dependencies installed, see dependencies at the end.

### With `c2e.sh`

Just run `c2e.sh` setting the path and prefix of the cubemap sides (`ImagePrefix_Back.tif`, `ImagePrefix_Down.tif`, `ImagePrefix_Front.tif`, `ImagePrefix_Left.tif`, `ImagePrefix_Right.tif`, `ImagePrefix_Up.tif`), and the output file.
```sh
./c2e.sh /Path/To/ImagePrefix /Path/To/FinalImage.tif
```

Then you can convert the tif to jpg with `tif2jpg.sh`, which adds the 360° metadata
```sh
./tif2jpg.sh /Path/To/FinalImage.tif
```

### Manually
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


### Manually in the Terminal
1. Create a `.pto` as in the following example, and set the filename of each cube face, in this example the images are `Back.tif`, `Front.tif`, `Down.tif`, `Left.tif`, `Right.tif`, `Up.tif`, also set the dimensions of the final equirectangular image, and the dimensions of each side of the cube.

> In the following example of a `.pto` file, the final equirectangular image has a width of `16384px` by a height of `8192px`, based on a `4096px` cube size. To get the width, we multiply `4` by the cube size, and for the height, `2` by the cube size. Hugin has another "optimized" version of this calculation, where it multiplies the width of the cube by π (pi), rounds up to the nearest integer, and then divides the result by two to get the height.

> **Note:** Facebook downloaded cubemaps have the `up` and `down` faces rotaded 180°, so you'll have to set `y180` to `Up.tif` and `Down.tif`.

Sample `cubemap.pto`
```
p f2 w16384 h8192 v360  k0 E0 R0 n"TIFF_m c:LZW r:CROP"
m i0

i w4096 h4096 f0 v90 Ra0 Rb0 Rc0 Rd0 Re0 Eev0 Er1 Eb1 r0 p0 y180 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a0 b0 c0 d0 e0 g0 t0 Va1 Vb0 Vc0 Vd0 Vx0 Vy0  Vm5 n"Back.tif"
i w4096 h4096 f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p0 y0 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n"Front.tif"
i w4096 h4096 f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p-90 y0 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n"Down.tif"
i w4096 h4096 f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p0 y-90 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n"Left.tif"
i w4096 h4096 f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p0 y90 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n"Right.tif"
i w4096 h4096 f0 v=0 Ra=0 Rb=0 Rc=0 Rd=0 Re=0 Eev0 Er1 Eb1 r0 p90 y0 TrX0 TrY0 TrZ0 Tpy0 Tpp0 j0 a=0 b=0 c=0 d=0 e=0 g=0 t=0 Va=0 Vb=0 Vc=0 Vd=0 Vx=0 Vy=0  Vm5 n"Up.tif"

v Ra0
v Rb0
v Rc0
v Rd0
v Re0
v Vb0
v Vc0
v Vd0
v Eev1
v r1
v p1
v y1
v Eev2
v r2
v p2
v y2
v Eev3
v r3
v p3
v y3
v Eev4
v r4
v p4
v y4
v Eev5
v r5
v p5
v y5
v

```

2. Use `nona` to prepare the image for stitching
```sh
nona -o pano -m TIFF_m -z LZW pano.pto
```

3. Use `verdandi` to blend the images
```sh
verdandi \
pano0000.tif \
pano0001.tif \
pano0002.tif \
pano0003.tif \
pano0004.tif \
pano0005.tif \
-o pano_equirectangular.tif
```

## Superscale Insta360 x4 image
1. Convert the original dual-fisheye DNG to TIF with Photoshop or ImageMagick.
2. Resize the TIF to 2 or 4x using Topaz Gigapixel AI or similar tools.
3. Load the resized TIF into Hugin, twice.
4. In Hugin, select `File` -> `Apply Template...`, and choose `Insta360Template.pto`
5. In "Sticher" tab, select "Calculate oprimal size" and then export the image.

> **Denoise:** You can use Topaz DeNoise AI before Topaz Gigapixel AI, and use Affinity Photo 2 to refine the horizon.
> **Object removal:** You can use `tocubemap_nona.sh` to convert the equirectangular image to cubemap, then with Photoshop Generative Fill, remove objects, and then with `c2e.sh` convert it back to equirectangular.
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
The official download links for Hugin are obsolete, user Dannephoto provided a more recent builds for Intel and Apple Silicon macs:
https://bitbucket.org/Dannephoto/hugin/downloads/

> macOS "protects" its users from "unwanted binaries" that are downloaded, a trick to avoid this issues is to use a `cat Hugin-2023.0.0_GPUFIX.dmg > Hugin-2023.0.0_GPUFIX_noquarantine.dmg` and then install the DMG files.

### `convert360`
1. Install `conda` to have a working Python enviroment
```sh
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```
It is recomended to restart the terminal, then, install `convert360`

2. Install `convert360` with `pip`
```sh
pip install convert360
```

3. For reasons that I don't understand, the `convert360` script has a path from the wrong interpreter, so with `nano`:
```sh
nano ~/miniforge3/bin/convert360
```

Replace the interpreter, from this:

```sh
#!/home/mateus/dev/still360/env/bin/python
```

To this:
```sh
#!/usr/bin/env python
```

### Publishing 360 panorama

Convert your 360 equirectangular panorama in a cubemap HTML with the following libraries
```sh
# Pannellum, quite good in mobile, tons of features
./Pannellum.sh panorama.jpg

# Avansel, simple, yet powerful, able to handle multiple resolutions
./Avansel.sh panorama.jpg

# Marzipano, good, but complex
./Marzipano.sh panorama.jpg
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

**Explanation of FFmpeg Command:**

* `ffmpeg`: Invokes the FFmpeg tool.
* `-hwaccel auto`: Uses hardware acceleration if available to speed up processing.
* `-y`: Automatically overwrites the output file without asking.
* `-hide_banner`: Hides the FFmpeg banner (version information).
* `-i input.mkv`: Specifies the input file.
* `-vf`: Applies video filters:
  * `v360=c3x2:e:cubic:in_forder='lfrdbu':in_frot='000313'`: Converts from cubemap (3x2 faces) to equirectangular projection. 'lfrdbu' specifies the input face order (left, front, right, down, back, up), and '000313' sets rotation for each face to correct orientation.
  * `scale=3840:1920`: Scales the video to a resolution of 3840x1920, fitting the 2:1 aspect ratio of equirectangular format.
  * `setsar=1:1`: Sets the sample/pixel aspect ratio to 1:1 to ensure pixel dimensions match the display aspect ratio.
* `-pix_fmt yuv420p`: Sets the pixel format to YUV 4:2:0 planar, which is widely supported for video playback.
* `-c:v libx264`: Uses H.264 codec for video encoding, which provides good quality at lower bitrates.
* `-preset faster`: Sets the encoding speed; 'faster' balances speed and quality.
* `-crf 21`: Sets the quality for the video; lower values result in higher quality with larger file sizes.
* `-c:a copy`: Copies the audio stream from the input without re-encoding it.
* `-movflags +faststart`: Moves some data to the start of the file for web streaming compatibility.
* `output.mp4`: Specifies the name of the output file in MP4 format.
