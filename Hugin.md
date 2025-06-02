# Hugin

Hugin is an Open Source panorama stitcher and graphical user interface (GUI) for
Panorama tools that provides a number of additional components and command line
tools.

## Installation in macOS
To install Hugin, **download it using the `curl` command** to avoid the
headaches macOS provide when downloading something from the internet, open the
image and drag the files to the Applications folder.

Hugin for Apple Silicon / ARM64
```sh
cd ~/Desktop
curl -L --progress-bar -O https://bitbucket.org/Dannephoto/hugin/downloads/Hugin-2024.0.1_arm64.dmg
open Hugin-2024.0.1_arm64.dmg
```

Hugin for Intel
```sh
cd ~/Desktop
curl -L --progress-bar -O https://bitbucket.org/Dannephoto/hugin/downloads/Hugin-2023.0.0_Intel.dmg
open Hugin-2023.0.0_Intel.dmg
```

## CLI tools
It is recommended to add the `/Applications/Hugin/tools_mac` directory to your
system `$PATH` to have the tools available system wide.

To modify the crop of a `.pto` file
```sh
pano_modify \
--crop="${left},${right},${top},${bottom}" \
-o "output.pto" \
input.pto
```

To see all other options
```sh
pano_modify --help
```

Stitch and blend a `.pto` file
```sh
hugin_executor \
--stitching \
--prefix="Pano" \
input.pto
```

To check all the commands that runs, add the `--dry-run` flag:
```sh
hugin_executor \
--stitching \
--prefix="Pano" \
--dry-run \
input.pto
```

To stich images
```sh
nona \
-o output.tif \
-m TIFF \
-z LZW \
input.pto
```

To merge images with `verdandi`
```sh
verdandi \
pano0000.tif \
pano0001.tif \
pano0002.tif \
pano0003.tif \
pano0004.tif \
pano0005.tif \
-o output.tif
```

More Hugin components:  
https://wiki.panotools.org/Hugin#Hugin_components
