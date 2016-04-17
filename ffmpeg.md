H.264/AAC Encoding
```
FFmpeg \
-i input.mp4 \
-c:v libx264 \
-preset slow \
-crf 20 \
-c:a libfdk_aac \
-b:a 128k \
-ac 2 \
-ar 44100 \
-ac 2 \
-movflags +faststart \
output.mp4
```

> X264 8-bit CRF: `0-51`, 0=lossless 23=default, 51=worst, 18 almost lossless  
> X264 10-bit CRF: `0-63`

X264 Presets:
* `ultrafast`
* `superfast`
* `veryfast`
* `faster`
* `fast`
* `medium`
* `slow`
* `slower`
* `veryslow`
* `placebo`

H.265/HE-AAC version 2 Encoding
```
ffmpeg \
-i input.mp4 \
-c:v libx265 \
-preset medium \
-x265-params crf=28 \
-ar 48000 \
-ac 2 \
-c:a libfdk_aac \
-profile:a aac_he_v2 \
-b:a 64k \
-strict experimental \
output.mp4
```

> X265 CRF: 28=default

* `ultrafast`
* `superfast`
* `veryfast`
* `faster`
* `fast`
* `medium`
* `slow`
* `slower`
* `veryslow`
* `placebo`

Modify rotation metadata without re-encoding.
```
ffmpeg \
-y \
-hide_banner \
-i input.m4v \
-metadata:s:v rotate="90" \
-codec copy \
output.m4v
```


To JPG sequence:
```
ffmpeg \
-y \
-hide_banner \
-threads 0 \
-i input.mp4 \
-r 30000/1001 \
-an \
-f image2 \
image%04d.jpg
```

From images
```
ffmpeg \
-y \
-hide_banner \
-f image2 \
-i image%04d.jpg \
-r 12 \
-an \
output.m4v
```

GoPro image sequence to DNxHD at 90Mbps
```
ffmpeg \
-y \
-hide_banner \
-start_number 22 \
-i G003%04d.JPG \
-vcodec dnxhd \
-b:v 90M \
-an \
output.mov
```

GoPro image sequence to ProRes
```
ffmpeg \
-y \
-hide_banner \
-start_number 22 \
-i G003%04d.JPG \
-r 30000/1001 \
-vcodec prores \
-profile:v 0 \
-an \
output.mov
```

GoPro image sequence to ProRes_ks
```
ffmpeg \
-y \
-hide_banner \
-start_number 22 \
-i G003%04d.JPG \
-r 30000/1001 \
-vcodec prores_ks \
-profile:v 0 \
-an \
output.mov
```

ProRes profiles:
* 0: 422 (Proxy)
* 1: ProRes422 (LT)
* 2: ProRes422 (Normal)
* 3: ProRes422 (HQ)


X264 10bit 4:2:2 Chroma at CRF 20 using X264 10Bit
```
ffmpeg \
-y \
-hide_banner \
-i UHD_10bit_444_INPUT.mov \
-c:v libx264 \
-profile:v high422 \
-crf 20 \
-pix_fmt yuv422p \
output.mp4
```

X264 10bit 4:2:2 Chroma at 135Mbps using X264 10Bit
```
ffmpeg \
-y \
-hide_banner \
-i UHD_10bit_444_INPUT.mov \
-c:v libx264 \
-profile:v high422 \
-b:v 120000k \
-pix_fmt yuv422p \
output.mp4
```

X264 10bit 4:4:4 Chroma at 135Mbps using X264 10Bit
```
ffmpeg \
-y \
-hide_banner \
-i UHD_10bit_444_INPUT.mov \
-c:v libx264 \
-profile:v high444 \
-crf 20 \
-an \
output.mp4
```

Add alpha channel mask encoding to `qtrle`
```
/Users/rpolo/Desktop/ffmpeglatest/ffmpeg \
-hide_banner \
-y \
-loop 1 \
-i alpha.png \
-i input.mp4 \
-filter_complex \
"[0:v]alphaextract[alf]; \
 [1:v][alf]alphamerge" \
-c:v qtrle \
-an \
-t 1 \
output.mov
```

Add alpha channel mask encoding to `png`
```
/Users/rpolo/Desktop/ffmpeglatest/ffmpeg \
-hide_banner \
-y \
-loop 1 \
-i alpha.png \
-i input.mp4 \
-filter_complex \
"[0:v]alphaextract[alf]; \
 [1:v][alf]alphamerge" \
-c:v png \
-pix_fmt rgb32 \
-an \
-t 1 \
output.mov
```


Install in OS X
```
brew install \
automake \
fdk-aac \
git \
lame \
libass \
libtool \
libvorbis \
libvpx \
opus \
sdl \
shtool \
texi2html \
theora \
wget \
x264 \
xvid \
libvidstab \
xvid \
yasm

brew install ffmpeg \
--with-fdk-aac \
--with-ffplay \
--with-freetype \
--with-libass \
--with-libquvi \
--with-libvorbis \
--with-libvpx \
--with-opus \
--with-x265
```


Links
* [ffmpeg downloads](http://www.videohelp.com/software/ffmpeg)
* [X264 10-BIT BUILDS](https://ffmpeg.zeranoe.com/blog/?p=435)
* [Video Samples](https://www.arri.com/camera/alexa/learn/alexa_sample_footage/)
* [Sources](https://www.ffmpeg.org/faq.html#How-do-I-encode-single-pictures-into-movies_003f)
* [How to encode 10bit H.264 files](http://video.stackexchange.com/questions/13164/encoding-422-in-10-bit-with-libx264)
* [ProRes Info](https://transcoding.wordpress.com/2012/01/29/prores-ffmpeg/)
* [Homebrew](http://brew.sh/)
* [Most complete FFmpeg compilation for Windows](http://oss.netfarm.it/mplayer/)