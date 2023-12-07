# Siril

* Download: https://siril.org/download/  
* Shortcuts: https://siril.readthedocs.io/en/stable/GUI/shortcuts.html  
* Documentation: https://siril.readthedocs.io/en/stable/

## Download Preprocessing Scripts
```sh
mkdir -p ~/.siril/scriptsiril/scripts
cd ~/.siril/scriptsiril/scripts
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/DSA-StarTrails-WithoutDBF.ssf?ref_type=heads" -O DSA-StarTrails-WithoutDBF.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/Mono_Preprocessing_WithoutDBF.ssf?ref_type=heads" -O Mono_Preprocessing_WithoutDBF.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/Mono_Preprocessing_WithoutDark.ssf?ref_type=heads" -O Mono_Preprocessing_WithoutDark.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/Mono_Preprocessing_WithoutFlat.ssf?ref_type=heads" -O Mono_Preprocessing_WithoutFlat.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/Mono_Preprocessing_withbackgroundextraction.ssf?ref_type=heads" -O Mono_Preprocessing_withbackgroundextraction.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/OSC_Preprocessing_WithoutDBF.ssf?ref_type=heads" -O OSC_Preprocessing_WithoutDBF.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/OSC_Preprocessing_WithoutDark.ssf?ref_type=heads" -O OSC_Preprocessing_WithoutDark.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/OSC_Preprocessing_WithoutFlat.ssf?ref_type=heads" -O OSC_Preprocessing_WithoutFlat.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/OSC_Preprocessing_withbackgroundextraction.ssf?ref_type=heads" -O OSC_Preprocessing_withbackgroundextraction.ssf
wget "https://gitlab.com/free-astro/siril-scripts/-/raw/main/preprocessing/OSC_Startrail.ssf?ref_type=heads" -O OSC_Startrail.ssf
```

Extra info:  
https://gitlab.com/free-astro/siril-scripts/-/tree/main?ref_type=heads


## Using local catalogues in Siril

```sh
mkdir -p ~/.local/share/kstars/
cd ~/.local/share/kstars/
wget https://free-astro.org/download/kstars-siril-catalogues/namedstars.dat.xz
wget https://free-astro.org/download/kstars-siril-catalogues/unnamedstars.dat.xz
wget https://free-astro.org/download/kstars-siril-catalogues/deepstars.dat.xz
wget https://free-astro.org/download/kstars-siril-catalogues/USNO-NOMAD-1e8.dat.xz
xz -d namedstars.dat.xz
xz -d unnamedstars.dat.xz
xz -d deepstars.dat.xz
xz -d USNO-NOMAD-1e8.dat.xz
```

Extra info:  
https://siril.readthedocs.io/en/stable/astrometry/platesolving.html#using-local-catalogues


## Installing local Astrometry.net for Siril in macOS

1. Install astrometry-net with Homebrew
2. Download the 4100 index series
3. Copy the index files into `/opt/homebrew/Cellar/astrometry-net/0.94_3/data`

Install `astrometry-net`
```sh
brew install astrometry-net
```

Download indexes
```sh
cd /opt/homebrew/Cellar/astrometry-net/*/data
wget http://data.astrometry.net/4100/index-4107.fits
wget http://data.astrometry.net/4100/index-4108.fits
wget http://data.astrometry.net/4100/index-4109.fits
wget http://data.astrometry.net/4100/index-4110.fits
wget http://data.astrometry.net/4100/index-4111.fits
wget http://data.astrometry.net/4100/index-4112.fits
wget http://data.astrometry.net/4100/index-4113.fits
wget http://data.astrometry.net/4100/index-4114.fits
wget http://data.astrometry.net/4100/index-4115.fits
wget http://data.astrometry.net/4100/index-4116.fits
wget http://data.astrometry.net/4100/index-4117.fits
wget http://data.astrometry.net/4100/index-4118.fits
wget http://data.astrometry.net/4100/index-4119.fits
```

Test solve-field
```sh
solve-field -O -T image.tif
```

Siril command
```sh
solve-field \
-C stop \
--temp-axy \
-p \
-O \
-N none \
-R none \
-M none \
-B none \
-U none \
-S none \
--crpix-center \
-l 10 \
-u arcsecperpix \
-L 1.5 \
-H 1.5 \
-T file.xyls
```

Fake `solve-field` for truly blind plate solving
```sh
#!/usr/bin/env bash

# Get the last argument
INPUT="${!#}"
/opt/homebrew/bin/solve-field -O -T "$INPUT"

```

Extra info:  
https://siril.readthedocs.io/en/stable/astrometry/platesolving.html#using-the-local-astrometry-net-solver  
https://siril.readthedocs.io/en/stable/astrometry/platesolving.html#index-files


## CLI StarNet2 for MacOS
```sh
mkdir -p ~/.apps
cd ~/.apps
wget https://www.starnetastro.com/wp-content/uploads/2023/02/StarNet2T_MacOS.zip
unzip StarNet2T_MacOS.zip && rm -rf StarNet2T_MacOS.zip __MACOSX
cd StarNet2T_MacOS
./install.sh
```

# Optional installation

Building Siril for macOS (Doesn't show in Applications folder and macOS Launchpad)
```sh
ulimit -n 10000
brew install siril
```