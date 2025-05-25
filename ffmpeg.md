# FFmpeg cheat sheet


## Encoding

### AVC/H.264/AAC Encoding
```sh
FFmpeg \
-i input.mp4 \
-c:v libx264 \
-preset slow \
-crf 20 \
-c:a aac \
-b:a 128k \
-ac 2 \
-ar 44100 \
-movflags +faststart \
output.mp4
```

> X264 8-bit CRF: `0-51`, 0=lossless 23=default, 51=worst, 18 almost lossless  
> X264 10-bit CRF: `0-63`

#### X264 Presets:
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

### HEVC/H.265/HE-AAC version 2 Encoding
```sh
ffmpeg \
-i input.mp4 \
-c:v libx265 \
-preset superfast \
-crf 21 \
-c:a aac \
-b:a 128k \
-ac 2 \
-ar 44100 \
-tag:v hvc1 \
-movflags +faststart \
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

### Modify rotation metadata without re-encoding.
```sh
ffmpeg \
-y \
-hide_banner \
-i input.m4v \
-metadata:s:v rotate="90" \
-codec copy \
output.m4v
```

### To JPG sequence:
```sh
ffmpeg \
-y \
-hide_banner \
-i input.mp4 \
-an \
-f image2 \
image%04d.jpg
```

### To JPG sequence alternative:
```sh
ffmpeg \
-i input.mp4 \
-qscale:v 2 \
image%04d.jpg
```

### Video from images
```sh
ffmpeg \
-y \
-hide_banner \
-f image2 \
-i image%04d.jpg \
-r 12 \
-an \
output.mp4
```

### GoPro image sequence to DNxHD at 90Mbps
```sh
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

### GoPro image sequence to ProRes
```sh
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

### GoPro image sequence to ProRes_ks
```sh
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

### Generate 10 thumbnails from a video
```sh
THUMBNAIL_NO=10
FILE=MyVideoFile.mp4
DURATION=$(mediainfo --Inform="General;%Duration%" "${FILE}")
ffmpeg \
-i "${FILE}" \
-vf "fps=${THUMBNAIL_NO}000/${DURATION}" \
out%04d.png
```

### ProRes with YUV 4444 support
```sh
ffmpeg -i input.mp4 -c:v prores_ks -profile:v 3 -c:a pcm_s16le output.mov
```

`prores_ks` profiles:
| #  | Profile        | Mbps      | CS   | Chroma  |
|---:|:---------------|----------:|:-----|--------:|
| -1 | auto (default) |           | YUV  |   4:2:2 |
|  0 | Proxy          |  ≈ 45Mbps | YUV  |   4:2:2 |
|  1 | LT             | ≈ 102Mbps | YUV  |   4:2:2 |
|  2 | Standard       | ≈ 147Mbps | YUV  |   4:2:2 |
|  3 | HQ             | ≈ 220Mbps | YUV  |   4:2:2 |
|  4 | 4444           | ≈ 330Mbps | YUVA | 4:4:4:4 |
|  5 | 4444-HQ        | ≈ 500Mbps | YUVA | 4:4:4:4 |


> Source: https://trac.ffmpeg.org/wiki/Encode/VFX#Prores

### DNX to H.264/AAC for YouTube with `hqdn3d` denoise and GOP 30
```sh
ffmpeg \
-i input.mxf \
-pix_fmt yuv420p \
-vf "hqdn3d=1.5:1.5:6:6" \
-c:v libx264 \
-preset fast \
-x264opts "keyint=30:scenecut=-1" \
-crf 22 \
-c:a aac \
-b:a 128k \
-ac 2 \
-ar 44100 \
-movflags +faststart \
output.mp4
```

### DNX to H.264/AAC
```sh
ffmpeg \
-i input.mxf \
-pix_fmt yuv420p \
-c:v libx264 \
-preset fast \
-crf 22 \
-c:a aac \
-b:a 128k \
-ac 2 \
-ar 44100 \
-movflags +faststart \
output.mp4
```

### DNX to H.265/AAC
```sh
ffmpeg \
-i input.mxf \
-pix_fmt yuv420p \
-c:v libx265 \
-preset superfast \
-crf 21 \
-c:a aac \
-b:a 128k \
-ac 2 \
-ar 44100 \
-tag:v hvc1 \
-movflags +faststart \
output.mp4
```

## Chroma subsampling and 10bits

### X264 10bit 4:2:2 Chroma at CRF 20 using X264 10Bit
```sh
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

### X264 10bit 4:2:2 Chroma at 135Mbps using X264 10Bit
```sh
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

### X264 10bit 4:4:4 Chroma at 135Mbps using X264 10Bit
```sh
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

### H.265 for BluRay
```sh
ffmpeg \
-hwaccel auto \
-y \
-hide_banner \
-i input.mkv \
-pix_fmt yuv420p \
-c:v libx265 \
-tag:v hvc1 \
-preset medium \
-crf 18 \
-x265-params aq-mode=3:psy-rd=1.0:aq-strength=1.0 \
-an \
-movflags +faststart \
output.mp4
```

Explaination:
* `ffmpeg`: This is the command to invoke FFmpeg.
* `-hwaccel auto`: Enables automatic hardware acceleration for decoding tasks, allowing FFmpeg to use available hardware acceleration capabilities.
* `-y`: Overwrites output files without asking for confirmation. Useful for batch processing where you don't want to manually confirm each overwrite.
* `-hide_banner`: Hides the banner information (version, configuration, copyright notice, etc.) displayed by FFmpeg at the beginning of execution for a cleaner output.
* `-i input.mkv`: Specifies the input file (input.mkv in this case).
* `-pix_fmt yuv420p`: Specifies the pixel format for the output video as YUV 4:2:0, which is commonly used for H.265 encoding and is compatible with most devices and players.
* `-c:v libx265`: Sets the video codec to H.265/HEVC using the libx265 encoder.
* `-tag:v hvc1`: Adds the necessary hvc1 tag to indicate HEVC video content in MP4 container format.
* `-preset medium`: Sets the encoding preset to medium, which balances encoding speed and compression efficiency.
* `-crf 18`: Sets the constant rate factor (CRF) to 18, controlling the trade-off between video quality and file size. Lower values result in higher quality but larger file sizes.
* `-x265-params`: Allows you to specify additional parameters that are passed directly to the x265 encoder. These parameters provide fine-grained control over various aspects of the encoding process to achieve desired compression efficiency and visual quality.
  * `aq-mode=3`: Adaptive Quantization (AQ) mode controls how x265 dynamically adjusts the quantization levels based on the complexity of each frame. Setting it to `3` activates AQ mode 3, which is a spatial AQ mode that adjusts quantization based on local spatial complexity. This helps allocate more bits to visually important areas, improving overall visual quality.
  * `psy-rd=1.0`: Psycho-Visual Rate Distortion (Psy-RD) is a parameter that balances visual quality against bitrate allocation by considering the perceptual impact of compression. A value of `1.0` for `psy-rd` indicates a balanced approach, where both visual quality and compression efficiency are given equal importance. Adjusting this parameter allows fine-tuning of the trade-off between visual quality and file size.
  * `aq-strength=1.0`: Adaptive Quantization (AQ) strength controls the aggressiveness of adaptive quantization. A value of `1.0` indicates full strength, meaning that the quantization levels are adjusted aggressively based on the perceived complexity of each frame. This parameter influences the granularity of quantization adjustments and can impact visual quality and compression efficiency.
* `-an`: Disables audio encoding, resulting in a video-only output.
* `-movflags +faststart`: Optimizes the MP4 output file for web streaming by rearranging the file's internal structure, allowing for faster playback start times when streaming over HTTP.
* `output.mp4`: Specifies the output filename and format.


### YouTube "Recomended Settings"
```sh
ffmpeg \                # Calling the binary
-i input.mp4 \          # Input video file
-r 30000/1001 \         # Set the frame rate - optional
-vf scale="1920:1080" \ # Resize video - optional
-codec:v libx264 \      # X264 Video Codec
-crf 21 \               # Video Quality
-bf 2 \                 # Maximum 2 B-frames as per guideline
-flags +cgop \          # Closed GOP as per guideline
-pix_fmt yuv420p \      # Chroma subsampling 4:2:0 as per guideline
-c:a aac \              # Fraunhofer FDK AAC codec library
-b:a 128k \             # Audio Bitrate
-ac 2 \                 # Audio channels
-r:a 44100 \            # Audio samplerate
-map 0:v:0 \            # First file : video : first track
-map 0:a:0 \            # First file : audio : first track 
-movflags faststart \   # Put MOOV atom at the front of the file
output.mp4
```

## Alpha Channel

### Add alpha channel mask encoding to `qtrle`
```sh
ffmpeg \
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

### Add alpha channel mask encoding to `png`
```sh
ffmpeg \
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

## Filters

### Add blured bars for vertical video
```sh
ffmpeg \
-i "input.mp4" \
-filter_complex "[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16" \
-pix_fmt yuv420p \
-c:v libx264 \
-preset fast \
-crf 22 \
-c:a aac \
-b:a 128k \
-ar 44100 \
-ac 2 \
-movflags +faststart \
output.mp4
```

### Test a filter with `ffplay`
```sh
ffplay \
-filter:v "crop=1920:1080:0:140" \
input.mp4
```

### Create blue video with subs
```sh
ffmpeg \
-f lavfi \
-i "color=c=blue:s=1920x1080" \
-vf "subtitles=subs.srt:force_style='Fontsize=26,PrimaryColour=&H00ffff&'" \
-pix_fmt yuv420p \
-c:v libx264 \
-preset fast \
-crf 21 \
-an \
-t "00:14:56.244" \
-movflags +faststart \
subs.mp4
```

### YouTube's cubemap to equirectangular
```sh
ffmpeg \
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

### Equirectangular PNG to Cubemap
```sh
ffmpeg \
-y \
-i "equirectangular-input.png" \
-vf "v360=equirect:c3x2" \
cubemap3x2-output.png
```

### Cubemap PNG to Equirectangular
```sh
ffmpeg \
-y \
-i "cubemap3x2-input.png" \
-vf "v360=c3x2:e:cubic" \
equirectangular-output.png
```

### ProRes blue screen with subtitles from SRT
```sh
ffmpeg \
-f lavfi \
-i "color=c=blue:s=1920x1080" \
-pix_fmt yuv422p10le \
-vf "subtitles=sub.srt:force_style='Fontsize=26,PrimaryColour=&H00ffff&'" \
-c:v prores_aw \
-an \
-t "00:01:04.993" \
-movflags +faststart \
output.mov
```

### Add SRT subtitles to a MP4 file
```sh
ffmpeg \
-i input.mp4 \
-i subtitle.srt \
-c:v copy \
-c:a copy \
-c:s mov_text \
-metadata:s:s:0 language=eng \
output.mp4
```

### Other filter flags

Crop
```sh
-vf "crop=1920:816:0:132" \
```

Denoise
```sh
-vf "hqdn3d=4:4:9:9" \
```

Scale
```sh
-vf "scale=640:-16" \
```

Denoise and scale
```sh
# -vf "hqdn3d=4:4:9:9,scale=640:-16" \
```

4K to UHD Pad
```sh
-vf "scale=min(iw*2160/ih\,3840):min(2160\,ih*3840/iw),pad=3840:2160:(3840-iw)/2:(2160-ih)/2" \
```

Add hard yellow subtitles
```sh
-vf "subtitles=subs.srt:force_style='Fontsize=26,PrimaryColour=&H00ffff&'"
```

Deinterlace
```sh
-vf yadif 
```

Change volume
```sh
-filter:a "volume=24dB"
```

## Timelapse

Make a time-lapse fom a video, if you have a GoPro video recorded at normal speed (29.97fps) and you want to convert that video to a time-lapse video using the same GoPro time-lapse speed selection style, like a picture each 0.5, 1, 2, 5, 10, 30, 60 seconds, here is the command, the filter `setpts` changet the presentation timestamp (PTS), the `1/0.5/(30000/1001)*PTS` formula goes as follows, one second divided the pictures per second, the result is devided by the input frame rate, having 29.97 being described as `30000/1001`, and the result, multiplied by PTS. More info about video speed [here](https://trac.ffmpeg.org/wiki/How%20to%20speed%20up%20/%20slow%20down%20a%20video)  

You can also specify the `-filter:v "setpts=0.5*PTS"` to a 2x speed using `0.5`, 4x speed using `0.25`, 8x speed using `0.125`, 16x speed using `0.0625` and so on.

```sh
ffmpeg \
-y \
-hide_banner \
-i GOPR0001.MP4 \
-filter:v "setpts=1/0.5/(30000/1001)*PTS" \
-c:v libx264 \
-preset medium \
-crf 20 \
-an \
-strict experimental \
time-lapse.mp4
```

Time-lapse from GoPro JPGs with crop and resize (`4000×3000` to `1280x720`)
```sh
ffmpeg \
-y \
-hide_banner \
-r 30000/1001 \
-f image2 \
-start_number 5523 \
-i G001%04d.JPG \
-pix_fmt yuv420p \
-vf "crop=4000:2250:0:375,scale=1280:720" \
-c:v libx264 \
-preset faster \
-crf 22 \
-an \
-movflags +faststart \
time-lapse.mp4
```

Time-lapse from a JPEG image sequence with 5 digits, to an HEVC/H265 file.
```sh
ffmpeg \
-y \
-hide_banner \
-r 24 \
-f image2 \
-start_number 1 \
-i x%05d.jpg \
-pix_fmt yuv420p \
-c:v libx265 \
-tag:v hvc1 \
-preset superfast \
-crf 22 \
-an \
-movflags +faststart \
time-lapse.mp4
```

Time-lapse from a JPEG image sequence with 5 digits, to an ProRes file.
```sh
ffmpeg \
-y \
-hide_banner \
-r 24 \
-f image2 \
-start_number 1 \
-i x%05d.jpg \
-pix_fmt yuv422p10le \
-c:v prores_ks \
-profile:v 3 \
-vendor apl0 \
-an \
-movflags +faststart \
time-lapse.mov
```

## Join/Concat and plit video

GoPro join, first, the `mylist.txt` file:
```sh
file 'GOPR5522.MP4'
file 'GP015522.MP4'
file 'GP025522.MP4'
```

Then, the encoding:
```sh
ffmpeg -f concat -i mylist.txt -c copy output.mp4
```

Using the concat protocol:
```sh
ffmpeg \
-i 'concat:GOPR5522.MP4|GP015522.MP4|GP025522.MP4' \
-codec copy output.mp4
```

Split stereo into two mono tracks:
```sh
ffmpeg \
-i stereo.wav \
-map_channel 0.0.0 left.wav \
-map_channel 0.0.1 right.wav
```

## Audio

### 5.1 AC3 to 5.1 AAC
```sh
ffmpeg \
-y \
-i input.ac3 \
-channel_layout "5.1" \
-c:a aac \
-b:a 384k \
-movflags +faststart \
output.m4v
```

### 5.1 AC3 to 5.1 AAC with [eac3to](https://www.videohelp.com/software/eac3to) and [Nero AAC Codec](https://www.videohelp.com/software/Nero-AAC-Codec)
```sh
eac3to input.ac3 output.m4a -progressnumbers -384 -log=NUL
```

### 5.1 EAC3 or AAC to 5.1 AC3
```sh
ffmpeg \
-hwaccel auto \
-y \
-i input.aac \
-map 0 \
-c:a ac3 \
-b:a 640k \
out.ac3
```

### 5.1 to Stereo
```sh
ffmpeg \
-i "Audio.mkv" \
-vn \
-ac 2 \
-af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" \
stereo.wav
```

### Stereo + Stereo → Stereo
![stereo + stereo → stereo](https://i.imgur.com/AiAGIly.png "stereo + stereo → stereo")

Using the amix filter
```sh
ffmpeg \
-i input0.mp3 \
-i input1.mp3 \
-filter_complex amix=inputs=2:duration=longest \
output.mp3
```

Using the amerge filter
```sh
ffmpeg \
-i input0.mp3 \
-i input1.mp3 \
-filter_complex amerge=inputs=2 \
-ac 2 \
output.mp3
```
### Downmix each input into specific output channel
![Downmix each input into specific output channel](https://i.imgur.com/MPsU7mG.png "Downmix each input into specific output channel")

Using the amerge and pan filters
```sh
ffmpeg \
-i input0.mp3 \
-i input1.mp3 \
-filter_complex "amerge=inputs=2,pan=stereo|c0<c0+c1|c1<c2+c3" \
output.mp3
```

### Mono + Mono → Stereo
![mono + mono → stereo](https://i.imgur.com/uhQZYpZ.png "mono + mono → stereo")

Using the join filter
```sh
ffmpeg \
-i input0.mp3 \
-i input1.mp3 \
-filter_complex "join=inputs=2:channel_layout=stereo" \
output.mp3
```

Using the amerge filter
```sh
ffmpeg \
-i input0.mp3 \
-i input1.mp3 \
-filter_complex "amerge=inputs=2" \
output.mp3
```

### Mono + Mono → Mono
![mono + mono → mono](https://i.imgur.com/y45Hc6j.png "")

Using the amix filter
```sh
ffmpeg \
-i input0.mp3 \
-i input1.mp3 \
-filter_complex "amix=inputs=2:duration=longest" \
output.mp3
```

> [FFmpeg Wiki: Audio Channels](https://trac.ffmpeg.org/wiki/AudioChannelManipulation)
> [Source](https://stackoverflow.com/a/14528482/218418)

## Misc

Install in maOS
```sh
brew install ffmpeg
```

## FFmpeg progress bar
```sh
pip install --user ffpb
pip show ffpb
```

List streams
```sh
ffmpeg -i input.mp4 2>&1 | grep "Stream #"
```

Split a FLAC file into separate tracks based on the CUE file, or just use [flacon](http://flacon.github.io/)
```sh
brew install shntool
shnsplit -f file.cue -o flac file.flac
```

v360 links
* https://ffmpeg.org/ffmpeg-filters.html#v360
* https://www.cxyzjd.com/article/qiutiantxwd/107283224
* https://www.programmersought.com/article/32807747315/


Links (Deprecated)
* [ffmpeg downloads](http://www.videohelp.com/software/ffmpeg)
* [X264 10-BIT BUILDS](https://ffmpeg.zeranoe.com/blog/?p=435)
* [Video Samples](https://www.arri.com/camera/alexa/learn/alexa_sample_footage/)
* [Sources](https://www.ffmpeg.org/faq.html#How-do-I-encode-single-pictures-into-movies_003f)
* [How to encode 10bit H.264 files](http://video.stackexchange.com/questions/13164/encoding-422-in-10-bit-with-libx264)
* [ProRes Info](https://transcoding.wordpress.com/2012/01/29/prores-ffmpeg/)
* [Homebrew](http://brew.sh/)
* [Most complete FFmpeg compilation for Windows](http://oss.netfarm.it/mplayer/)